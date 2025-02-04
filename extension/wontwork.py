# This will NOT work with parent flake
# this WILL work with child flake
import requests

result = requests.get('https://example.com')

print(result.text)

from preggy import expect

expect(result.text).to_include('Example Domain')
expect(result.status_code).to_equal(999)
print('The above AssertionError means preggy worked!')
