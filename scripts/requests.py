import requests

endpoint = "http://www.google.com"
def post():
    headers = {"content-type": "application/json"}
    r = requests.get(endpoint, headers=headers)
    data = r.json()
    print json.dumps(data, indent=4)

