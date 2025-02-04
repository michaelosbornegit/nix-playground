# This will work from parent.nix
import requests

result = requests.get('https://example.com')

print(result.text)

