import requests

headers = {"User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"}

url = "http://datapilots.tistory.com/"
res = requests.get(url, headers=headers)
res.raise_for_status() 

with open("Datapilots_tistory.html","w",encoding="utf8") as f:
    f.write(res.text)