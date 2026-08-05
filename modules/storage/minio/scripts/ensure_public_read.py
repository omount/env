import json
import os
import time

import boto3
from botocore.client import Config
from botocore.exceptions import ClientError


def main() -> None:
    endpoint = os.environ.get("S3_ENDPOINT", "http://minio:9000")
    access_key = os.environ.get("AWS_ACCESS_KEY_ID", "admin")
    secret_key = os.environ.get("AWS_SECRET_ACCESS_KEY", "12345678")
    bucket = os.environ.get("S3_BUCKET", "data")
    region = os.environ.get("S3_REGION", "us-east-1")

    s3 = boto3.client(
        "s3",
        endpoint_url=endpoint,
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        region_name=region,
        config=Config(signature_version="s3v4", s3={"addressing_style": "path"}),
    )

    for i in range(60):
        try:
            s3.list_buckets()
            break
        except Exception:
            if i == 59:
                raise
            time.sleep(1)

    try:
        s3.head_bucket(Bucket=bucket)
    except ClientError:
        s3.create_bucket(Bucket=bucket)
        print("created bucket:", bucket)

    policy = {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicReadGetObject",
                "Effect": "Allow",
                "Principal": {"AWS": ["*"]},
                "Action": ["s3:GetObject"],
                "Resource": [f"arn:aws:s3:::{bucket}/*"],
            }
        ],
    }
    s3.put_bucket_policy(Bucket=bucket, Policy=json.dumps(policy))
    print(f"bucket {bucket}: public-read enabled")


if __name__ == "__main__":
    main()
