/**
 * MinIO 直传示例（Node.js + AWS SDK for JavaScript v3）
 *
 * 默认：桶公开读；上传用 Presigned PUT；校验用公开直链。
 * S3_READ_MODE=signed 时改为签名读校验。
 */

const {
  S3Client,
  HeadBucketCommand,
  CreateBucketCommand,
  PutBucketPolicyCommand,
  PutObjectCommand,
  GetObjectCommand,
} = require("@aws-sdk/client-s3");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

function env(key, def) {
  return process.env[key] || def;
}

function publicObjectUrl(endpoint, bucket, key) {
  return `${endpoint.replace(/\/$/, "")}/${bucket}/${key}`;
}

async function ensurePublicRead(client, bucket) {
  const policy = {
    Version: "2012-10-17",
    Statement: [
      {
        Sid: "PublicReadGetObject",
        Effect: "Allow",
        Principal: { AWS: ["*"] },
        Action: ["s3:GetObject"],
        Resource: [`arn:aws:s3:::${bucket}/*`],
      },
    ],
  };
  await client.send(
    new PutBucketPolicyCommand({
      Bucket: bucket,
      Policy: JSON.stringify(policy),
    })
  );
  console.log("bucket policy: public-read");
}

async function main() {
  const endpoint = env("S3_ENDPOINT", "http://127.0.0.1:9000");
  const accessKey = env("AWS_ACCESS_KEY_ID", "admin");
  const secretKey = env("AWS_SECRET_ACCESS_KEY", "12345678");
  const region = env("S3_REGION", "us-east-1");
  const bucket = env("S3_BUCKET", "data");
  const objectKey = env("S3_OBJECT", "direct-upload/hello-nodejs.txt");
  const publicRead = env("S3_PUBLIC_READ", "true").toLowerCase() === "true";
  const readMode = env("S3_READ_MODE", "public").toLowerCase();
  const content = Buffer.from("hello minio direct upload from nodejs (aws s3 sdk)\n");

  const client = new S3Client({
    region,
    endpoint,
    forcePathStyle: true,
    credentials: {
      accessKeyId: accessKey,
      secretAccessKey: secretKey,
    },
  });

  try {
    await client.send(new HeadBucketCommand({ Bucket: bucket }));
  } catch {
    await client.send(new CreateBucketCommand({ Bucket: bucket }));
    console.log("created bucket:", bucket);
  }

  if (publicRead) {
    await ensurePublicRead(client, bucket);
  }

  const putUrl = await getSignedUrl(
    client,
    new PutObjectCommand({
      Bucket: bucket,
      Key: objectKey,
      ContentType: "text/plain",
    }),
    { expiresIn: 15 * 60 }
  );
  console.log("presigned PUT:", putUrl);

  const putResp = await fetch(putUrl, {
    method: "PUT",
    headers: { "Content-Type": "text/plain" },
    body: content,
  });
  if (!putResp.ok) {
    throw new Error(`PUT failed: ${putResp.status} ${await putResp.text()}`);
  }
  console.log("direct PUT ok:", putResp.status);

  const publicUrl = publicObjectUrl(endpoint, bucket, objectKey);
  console.log("PUBLIC_URL=", publicUrl);

  let verifyUrl = publicUrl;
  if (readMode === "signed") {
    verifyUrl = await getSignedUrl(
      client,
      new GetObjectCommand({
        Bucket: bucket,
        Key: objectKey,
      }),
      { expiresIn: 15 * 60 }
    );
    console.log("SIGNED_URL=", verifyUrl);
  }

  const getResp = await fetch(verifyUrl);
  const body = await getResp.text();
  if (!getResp.ok) {
    throw new Error(`GET failed: ${getResp.status} ${body}`);
  }
  console.log("read ok:", getResp.status, "mode=", readMode, "body=", body);
  console.log("VERIFY_URL=", verifyUrl);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
