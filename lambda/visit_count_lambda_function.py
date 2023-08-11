import boto3

def lambda_handler(event,context):
    # Initialize DynamoDB resource
    dynamodb = boto3.resource('dynamodb')

    # Get current visit count
    table = dynamodb.Table('visit-count-table')
    response = table.get_item(Key={'sitename': 'billyeuceda'})
    current_value = response['Item']['visitcount']

    # Add 1 to current count
    new_value = str(int(current_value) + 1)

    # Update current value to new value
    table.update_item(
        Key={'sitename': 'billyeuceda'}, 
        ExpressionAttributeValues= {':val': new_value}, 
        UpdateExpression= 'set visitcount = :val'
        )

    return {
        'statusCode': 200,
        'body': new_value,
        'foobar': current_value
    }


# if __name__ == '__main__':
#     print(lambda_handler(any,any))