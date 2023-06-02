import json
import boto3

def lambda_handler(event, context):
    # Get the ID from the event
    id = event["id"]

    # Get the DynamoDB client
    dynamodb = boto3.client("dynamodb")

    # Get the item from the DynamoDB table
    response = dynamodb.get_item(
        TableName="occurrence-table",
        Key={"id":id}
    )

    # Check if the item was found
    if "Item" in response:
        # Get the value from the item
        value = response["Item"]["value"]

        # Return the value
        return value

    # The item was not found
    return None