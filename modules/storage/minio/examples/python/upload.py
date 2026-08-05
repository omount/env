"""
MinIO 直传示例（Python + boto3 / AWS S3 SDK）

默认：桶公开读；上传用 Presigned PUT；校验用公开直链。
设 S3_READ_MODE=signed 时改为签名读校验。
"""

from __future__ import annotations

import json
import os

import boto3
import requests
from botocore.client import Config


def env(key: str, default: str) -> str:
    return os.environ.get(key, default)


def public_object_url(endpoint: str, bucket: str, key: str) -> str:
    return f"{endpoint.rstrip('/')}/{bucket}/{key}"


def ensure_public_read(s3, bucket: str) -> None:
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
    print("bucket policy: public-read")


def main() -> None:
    endpoint = env("S3_ENDPOINT", "http://127.0.0.1:9000")
    access_key = env("AWS_ACCESS_KEY_ID", "admin")
    secret_key = env("AWS_SECRET_ACCESS_KEY", "12345678")
    region = env("S3_REGION", "us-east-1")
    bucket = env("S3_BUCKET", "data")
    object_key = env("S3_OBJECT", "direct-upload/hello-python.txt")
    public_read = env("S3_PUBLIC_READ", "true").lower() == "true"
    read_mode = env("S3_READ_MODE", "public").lower()
    content = b"hello minio direct upload from python (aws s3 sdk)\n"

    s3 = boto3.client(
        "s3",
        endpoint_url=endpoint,
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        region_name=region,
        config=Config(signature_version="s3v4", s3={"addressing_style": "path"}),
    )

    try:
        s3.head_bucket(Bucket=bucket)
    except Exception:
        s3.create_bucket(Bucket=bucket)
        print("created bucket:", bucket)

    if public_read:
        ensure_public_read(s3, bucket)

    put_url = s3.generate_presigned_url(
        ClientMethod="put_object",
        Params={
            "Bucket": bucket,
            "Key": object_key,
            "ContentType": "text/plain",
        },
        ExpiresIn=15 * 60,
    )
    print("presigned PUT:", put_url)

    put_resp = requests.put(
        put_url,
        data=content,
        headers={"Content-Type": "text/plain"},
        timeout=60,
    )
    if put_resp.status_code >= 300:
        raise RuntimeError(f"PUT failed: {put_resp.status_code} {put_resp.text}")
    print("direct PUT ok:", put_resp.status_code)

    public_url = public_object_url(endpoint, bucket, object_key)
    print("PUBLIC_URL=", public_url)

    if read_mode == "signed":
        get_url = s3.generate_presigned_url(
            ClientMethod="get_object",
            Params={"Bucket": bucket, "Key": object_key},
            ExpiresIn=15 * 60,
        )
        print("SIGNED_URL=", get_url)
        verify_url = get_url
    else:
        verify_url = public_url

    get_resp = requests.get(verify_url, timeout=60)
    get_resp.raise_for_status()
    print("read ok:", get_resp.status_code, "mode=", read_mode, "body=", get_resp.text)
    print("VERIFY_URL=", verify_url)


if __name__ == "__main__":
    main()
