import json
import boto3
import uuid

def lambda_handler(event, context):
    input_string = event['string']
    input_character = event['character']

    # Count the occurrences of the character in the string
    count = input_string.count(input_character)

    result = {
        'id': str(uuid.uuid4()),
        'count': count
    }

    # Store the result in DynamoDB
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('occurance-table')
    table.put_item(Item=result)

    # Return the unique ID
    return {
        'statusCode': 200,
        'body': json.dumps({'id': result['id']})
    }