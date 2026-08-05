package main

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

func env(key, def string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return def
}

func publicObjectURL(endpoint, bucket, key string) string {
	return strings.TrimRight(endpoint, "/") + "/" + bucket + "/" + key
}

func ensurePublicRead(ctx context.Context, client *s3.Client, bucket string) error {
	policy := fmt.Sprintf(`{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": {"AWS": ["*"]},
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::%s/*"]
    }
  ]
}`, bucket)
	_, err := client.PutBucketPolicy(ctx, &s3.PutBucketPolicyInput{
		Bucket: aws.String(bucket),
		Policy: aws.String(policy),
	})
	return err
}

func main() {
	endpoint := env("S3_ENDPOINT", "http://127.0.0.1:9000")
	accessKey := env("AWS_ACCESS_KEY_ID", "admin")
	secretKey := env("AWS_SECRET_ACCESS_KEY", "12345678")
	region := env("S3_REGION", "us-east-1")
	bucket := env("S3_BUCKET", "data")
	objectKey := env("S3_OBJECT", "direct-upload/hello-go.txt")
	publicRead := strings.ToLower(env("S3_PUBLIC_READ", "true")) == "true"
	readMode := strings.ToLower(env("S3_READ_MODE", "public"))
	content := []byte("hello minio direct upload from go (aws s3 sdk)\n")

	client := s3.New(s3.Options{
		Region:       region,
		BaseEndpoint: aws.String(endpoint),
		Credentials:  credentials.NewStaticCredentialsProvider(accessKey, secretKey, ""),
		UsePathStyle: true,
	})

	ctx := context.Background()

	_, err := client.HeadBucket(ctx, &s3.HeadBucketInput{Bucket: aws.String(bucket)})
	if err != nil {
		_, err = client.CreateBucket(ctx, &s3.CreateBucketInput{Bucket: aws.String(bucket)})
		if err != nil {
			panic(err)
		}
		fmt.Println("created bucket:", bucket)
	}

	if publicRead {
		if err := ensurePublicRead(ctx, client, bucket); err != nil {
			panic(err)
		}
		fmt.Println("bucket policy: public-read")
	}

	presign := s3.NewPresignClient(client)

	putOut, err := presign.PresignPutObject(ctx, &s3.PutObjectInput{
		Bucket:      aws.String(bucket),
		Key:         aws.String(objectKey),
		ContentType: aws.String("text/plain"),
	}, s3.WithPresignExpires(15*time.Minute))
	if err != nil {
		panic(err)
	}
	fmt.Println("presigned PUT:", putOut.URL)

	req, err := http.NewRequest(http.MethodPut, putOut.URL, bytes.NewReader(content))
	if err != nil {
		panic(err)
	}
	req.Header.Set("Content-Type", "text/plain")
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
	body, _ := io.ReadAll(resp.Body)
	if resp.StatusCode >= 300 {
		panic(fmt.Sprintf("PUT failed: %s %s", resp.Status, string(body)))
	}
	fmt.Println("direct PUT ok:", resp.Status)

	publicURL := publicObjectURL(endpoint, bucket, objectKey)
	fmt.Println("PUBLIC_URL=", publicURL)

	verifyURL := publicURL
	if readMode == "signed" {
		getOut, err := presign.PresignGetObject(ctx, &s3.GetObjectInput{
			Bucket: aws.String(bucket),
			Key:    aws.String(objectKey),
		}, s3.WithPresignExpires(15*time.Minute))
		if err != nil {
			panic(err)
		}
		verifyURL = getOut.URL
		fmt.Println("SIGNED_URL=", verifyURL)
	}

	getResp, err := http.Get(verifyURL)
	if err != nil {
		panic(err)
	}
	defer getResp.Body.Close()
	got, _ := io.ReadAll(getResp.Body)
	if getResp.StatusCode >= 300 {
		panic(fmt.Sprintf("GET failed: %s %s", getResp.Status, string(got)))
	}
	fmt.Println("read ok:", getResp.Status, "mode=", readMode, "body=", string(got))
	fmt.Println("VERIFY_URL=", verifyURL)
}
