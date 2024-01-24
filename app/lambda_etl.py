import boto3
import os

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    destination_bucket = os.environ['OUTPUT_BUCKET']

    # Download the file from the source bucket
    s3.download_file(source_bucket, key, '/tmp/' + key)

    # Perform your transformation here
    # For example, let's just convert the file to uppercase
    with open('/tmp/' + key, 'r') as file:
        data = file.read().upper()

    # Write the transformed data to a new file
    with open('/tmp/transformed_' + key, 'w') as file:
        file.write(data)

    # Upload the transformed file to the destination bucket
    s3.upload_file('/tmp/transformed_' + key, destination_bucket, 'transformed_' + key)

    return {
        'statusCode': 200,
        'body': f"Transformed file (3) uploaded to {destination_bucket}"
    }
