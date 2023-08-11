import unittest
from visit_count_lambda_function import lambda_handler

class test_lambda(unittest.TestCase):
    def test_lambda_statuscode_and_addition(self):
        returns = lambda_handler(any,any)

        self.assertEqual(returns['statusCode'], 200)
        self.assertEqual(int(returns['foobar']) + 1, int(returns['body']))


if __name__ == '__main__':
    unittest.main()