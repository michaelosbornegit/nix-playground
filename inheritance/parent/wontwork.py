# This will NOT work, preggy isn't installed, check out the child folder
import requests

result = requests.get('https://example.com')

print(result.text)

from preggy import expect

expect(result.text).to_include('Example Domain')
