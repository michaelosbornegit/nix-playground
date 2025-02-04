# This will work from both parent and child flakes
import requests

result = requests.get('https://example.com')

print(result.text)

