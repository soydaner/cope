import json
import boto3
import os
from datetime import datetime

def lambda_handler(event, context):

    sample_content = {
        "message": "Hello, this is a sample file!",
        "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    }
    content_to_write = json.dumps(sample_content, indent=4)

    # Get the bucket name from environment variables
    bucket_name = os.environ['BUCKET_NAME']

    # Create a unique file name using the current datetime
    current_time = datetime.now().strftime("%Y%m%d%H%M%S")
    file_name = f"sample_data_{current_time}.json"

    # Example of putting a file into an S3 bucket
    s3 = boto3.client('s3')
    s3.put_object(Bucket=bucket_name, Key=file_name, Body=content_to_write)

    return {
        'statusCode': 200,
        'body': json.dumps(f"File {file_name} uploaded to S3 bucket {bucket_name} successfully!")
    }
