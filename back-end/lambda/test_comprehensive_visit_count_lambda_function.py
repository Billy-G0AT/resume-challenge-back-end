import unittest
from unittest.mock import patch, MagicMock

def get_mock_dynamodb_client():
    dynamodb_client_mock = MagicMock()
    table_mock = MagicMock()
    table_mock.get_item.return_value = {
        'Item': {
            'visitcount': '1'
        }
    }
    dynamodb_client_mock.Table.return_value = table_mock
    return dynamodb_client_mock

class LambdaTestCase(unittest.TestCase):
    @patch('boto3.resource')
    def test_lambda_handler(self, boto3_resource_mock):
        # Mock the DynamoDB resource
        dynamodb_mock = get_mock_dynamodb_client()
        boto3_resource_mock.return_value = dynamodb_mock

        # Invoke the lambda function
        from visit_count_lambda_function import lambda_handler
        response = lambda_handler({}, {})

        # Assert the response
        self.assertEqual(response['statusCode'], 200)
        self.assertEqual(response['body'], '2')

        # Assert DynamoDB method calls
        table_mock = dynamodb_mock.Table.return_value
        table_mock.get_item.assert_called_once_with(Key={'sitename': 'billyeuceda'})
        table_mock.update_item.assert_called_once_with(
            Key={'sitename': 'billyeuceda'},
            UpdateExpression='set visitcount = :val',
            ExpressionAttributeValues={':val': '2'}
        )

if __name__ == '__main__':
    unittest.main()
