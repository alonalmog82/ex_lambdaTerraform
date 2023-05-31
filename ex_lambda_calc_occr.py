import boto3
import json
import uuid

def lambda_handler(event, context):
    # Retrieve input from event
    input_json = event['input']
    input_string = input_json['string']
    input_character = input_json['character']
    
    # Calculate the number of occurrences of the character in the string
    occurrences = input_string.count(input_character)
    
    # Generate a unique identifier
    result_id = str(uuid.uuid4())
    
    # Write the result to DynamoDB
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('your-dynamodb-table-name')  # Replace with your DynamoDB table name
    table.put_item(Item={'id': result_id, 'occurrences': occurrences})
    
    # Prepare response
    response = {
        'result_id': result_id
    }
    
    return response
