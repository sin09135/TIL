# 웹 스크래핑 Basic

## 1. requests

> 웹페이지를 **요청**하고 **응답**을 처리하는 모듈 (**html** 가져오는 모듈)

### 1) html 가져오기

```Python
import requests
res = requests.get("http://google.com/")
```



## 2) 에러 확인

> 응답코드가 200이면 정상

- `if` 문 사용

```python
# 응답코드 확인
print("응답코드:", res.status_code)

# 응답코드 확인하는 반복문
if res.status_code == requests.codes.ok:
    print('정상입니다.')
 else:
     print("문제가 생겼습니다.[에러코드 : ",res.status_code, "]")

 res.raise_for_status()
 print("웹 스크래핑을 진행합니다.")
```

res 의 status_code 가 requests codes.ok 와 같으면 정상 (응답코드가 200이면 정상)

다르면, 에러코드를 출력



<img src="/Users/kimsinwoo/Downloads/응답코드 200.png" style="zoom:75%;" />



- `raise_for_status()`

```python
res.raise_for_status()
print("응답코드:", res.status_code)
```

if 문 없이 한 줄로 처리 가능

<img src="/Users/kimsinwoo/Downloads/응답코드 200.png" style="zoom:75%;" />



### 3) html 파일 가져오기

- `res.text`  응답의 html 내용 가져오는 함수

```python
print(len(res.text)) # html 텍스트 길이 출력
print(res.text) # html 텍스트 출력
```

![](/Users/kimsinwoo/Downloads/html 텍스트, 텍스트 길이 출력.png)



- 파일 생성 후, 응답 내용 저장

```python
with open("mygoogle.html","w",encoding="utf8") as f:
    f.write(res.text)
```

'mygoogle.html' 파일을 생성한 후,  쓰기 모드로 열어서 응답의 HTML 내용을 저장한다.



### 4) 브라우저로 열기

- [확장] 탭에서 `Live server` 설치하기 (open in browser 도 가능하다 )

![](/Users/kimsinwoo/Downloads/live server.png)

![](/Users/kimsinwoo/Downloads/open in browser.png)

- 우클릭 > 브라우저로 열기

![](/Users/kimsinwoo/Library/Mobile Documents/com~apple~Preview/Documents/브라우저 열기.png)

Live server > `Open with Live server`

Open in browser > `Open In Default Browser` , `Open In Other Browsers`



- 확인

![](/Users/kimsinwoo/Downloads/구글 페이지 내용 가져오기.png)



## 2. 정규식 기본

###  `import re`

> 정규 표현식 모듈  re

- 구조

```
1. p = re.complie('정규표현식') 
2. m = p.match("비교할 문자열") # 주어진 문자열을 처음부터 일치하는지 확인
	 m = p.search("비교할 문자열") # 주어진 문자열 중에 일치하는 것이 있는지 확인
	 lst = p.findall("비교할 문자열") # 일치하는 모든 것을 "리스트" 형태로 반환
```



예시)

```python
import re
p = re.compile("s.n") # "s.n" 패턴을 컴파일하여 정규 표현식 객체 P 생성
m = p.match("sun") # "sun" 문자열과 패턴 "s.n"을 비교하여 처음부터 일치하는지 확인
print_match(m) 
```

![](/Users/kimsinwoo/Downloads/정규포현식 1.png)



**정규표현식**

- . (s.n) : 하나의 문자를 의미 ex) sun, son (o)
-  ^ (^in) : 문자열의 시작 ex) install, inside(o)
- $ ($ve) : 문자열의 끝 ex) save, curve (o)



### 1) `match`, `search`, `findall` 차이

- `match`  : 처음부터 일치하는지 확인
- `search` : 주어진 문자열 중에 일치하는게 있는지 확인
- `findall` : 일치하는 모든 것을 "리스트" 형태로 반환

```python
import re

p = re.compile("s.n")  

def print_match(m):

    if m:
        print(m.group())
    else:
        print('매칭되지 않음')


m = p.match("sun") # match : 처음부터 일치하는지 확인
# print_match(m)

m = p.search("sunny") # search : 주어진 문자열 중에 일치하는게 있는지 확인
# print_match(m)

lst = p.findall("sunny") # findall : 일치하는 모든 것을 리스트 형태로 반환
# print(lst)

```

<img src="/Users/kimsinwoo/Downloads/정규표현식 예제2.png" style="zoom:50%;" />

![](/Users/kimsinwoo/Downloads/findall 출력 결과.png)

### 2) 문자열 반환

- `m.group()` : 일치하는 문자열 반환
- `m.string` :  입력받은 문자열 반환
- `m.start()`  : 일치하는 문자열의 시작 index
- `m.end()`  : 일치하는 문자열의 끝 index
- `m.span()` :  일치하는 문자열의 시작 / 끝 index

```python
import re

p = re.compile("s.n")  
# .(s.n) : 하나의 문자를 의미 ex) sun, son (o)
# ^(^in) : 문자열의 시작 ex) install, inside(o)
# $($ve) : 문자열의 끝 ex) save, curve (o)

def print_match(m):

    if m:
        print("m.group():" ,m.group()) # 일치하는 문자열 반환
        print("m.string():" ,m.string) # 입력받은 문자열 반환
        print("m.start():" ,m.start()) # 일치하는 문자열의 시작 index
        print("m.end():" ,m.end()) # 일치하는 문자열의 끝 index
        print("m.span():" ,m.span()) # 일치하는 문자열의 시작 / 끝 index

    else:
        print('매칭되지 않음')


# m = p.match("sun") # match : 처음부터 일치하는지 확인
# print_match(m)

m = p.search("sunny") # search : 주어진 문자열 중에 일치하는게 있는지 확인
print_match(m)
```

<img src="/Users/kimsinwoo/Downloads/스크래핑 2.png" style="zoom:50%;" />



### 3. User-Agent

> 웹 브라우저의 경우, User Agent 문자열은 브라우저의 종류, 버전, 운영 체제, 장치 정보 등을 포함한다. 웹 개발자들은 다양한 장치나 브라우저에서 웹 페이지가 올바르게 표시되도록 조정하기 위해 user_agent 를 사용한다.



### 1) 404 Error 

>  User - Agent 미사용시 발생 에러

- 출력

```python
import requests

url = "https://datapilots.tistory.com/"
res = requests.get(url)
res.raise_for_status() 

with open("tistory.html","w",encoding="utf8") as f:
    f.write(res.text)
```

![](/Users/kimsinwoo/Downloads/404 client 에러.png)

https://datapilots.tistory.com/ 페이지를 html 파일을 만들었을 때, 404 클라이언트 에러가 출력된다.

### 2) User - Agent 가져오기

-  크롬 검색 창에 `what is my user agent` 를 검색한다.

![](/Users/kimsinwoo/Downloads/what is my user agent.png)

- `내 사용자 에이전트` 의 해당 내용을 복사한 후, 크롤링에 활용한다.



### 3) `User-Agent` 사용

```python
import requests

# User-Agent
custom_header = {"User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"}

url = "http://datapilots.tistory.com/" # 티스토리는 User-Agent 없어도 잘 출력되긴 하지만, 임의로 선택
res = requests.get(url, headers=custom_header)
res.raise_for_status() 

with open("Datapilots_tistory.html","w",encoding="utf8") as f:
    f.write(res.text)
```



![](/Users/kimsinwoo/Downloads/datapilots 결과.png)

Datapilots_tistory.html 파일이 잘 생성된 것을 확인할 수 있다.



### 5. BeautifulSoup 사용

### 음악  차트 실시간 스크래핑

#### 1) 라이브러리 준비

- 터미널에 라이브러리 설치

```bash
pip install bs4
pip install lxml
```

Beautifulsoup4(bs4) : 웹 스크래핑을 위한 라이브러리

lxml : 파이썬용 xml, html를 처리하는 라이브러리

웹 스크래핑에 필요한 두 라이브러리를 설치한다.



- 라이브러리 임포트

```python
import requests
from bs4 import BeautifulSoup
```

설치한 라이브러리를 임포트 해준다.



#### 2) 음악 차트 불러오기

- 실시간 순위 차트 html 파악하기

![](/Users/kimsinwoo/Downloads/table.png)



![](/Users/kimsinwoo/Downloads/p 태스.png)



`<table class = "list_trackList byChart">` 

​	`<tbody>` 

 		`<tr>`

​			`<p class = 'title'><a> 제목 </a></p>` 



-  p 출력되는지 테스트

```python
import requests
from bs4 import BeautifulSoup


# 네이버 웹툰
url = "https://music.bugs.co.kr/chart"
res = requests.get(url)
res.raise_for_status()

soup = BeautifulSoup(res.text, "lxml")
tbody = soup.find('tbody')


p = tbody.find_all("p",class_ = 'title') 
print(p)
```



![](/Users/kimsinwoo/Downloads/p 출력.png)

p 태그 정상 출력됨을 확인할 수 있다.



- 반복문 구성

```python
# 벅스 뮤직 차트
url = "https://music.bugs.co.kr/chart"
res = requests.get(url)
res.raise_for_status() # 응답코드 200 인지 확인

soup = BeautifulSoup(res.text, "lxml")
tbody = soup.find('tbody') # 가장 처음 나오는 tbody

result = []
for p in tbody.find_all("p",class_ = 'title'): #find_all은 리스트 형태임
    result.append(p.get_text().replace('\n',''))
    
print(result)
```



- 결과 화면

![](/Users/kimsinwoo/Downloads/음악차트.png)



#### 3) 데이터프레임으로 출력

- 함수1 : 음원차트 크롤링
- 함수2 : 데이터프레임으로 변환
- 함수3:  main 함수(html 문서 가져오기 ~ 데이터프레임 출력)



```python
import requests
from bs4 import BeautifulSoup
import pandas as pd

def create_DF(result_list): # 데이터 프레임으로 변환
    result_df = pd.DataFrame({"title" : result_list})

    return result_df

def crawler(soup): # 음원차트 크롤링
    
    tbody = soup.find("tbody")
    result = []
    for p in tbody.find_all("p", class_ = "title"): 
        result.append(p.get_text().replace('\n', ''))

    return result

def main(): # 메인 함수

    # 요청 url 변수에 담긴 url의 html 문서를 출력
    custom_header = {
        'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
    }
    
    url = "https://music.bugs.co.kr/chart"
    req = requests.get(url, headers = custom_header)
    soup = BeautifulSoup(req.text, "html.parser")
    result = crawler(soup) # 크롤링 함수 실행
    df = create_DF(result) # 데이터프레임으로 만들기
    print(df)
    df.to_csv("result.csv", index=False) # csv 파일로 저장

if __name__ == "__main__":
    main()
```



- 결과 확인

<img src="/Users/kimsinwoo/Downloads/데이터프레임으로 완성.png" style="zoom:50%;" />



<img src="/Users/kimsinwoo/Downloads/csv 파일 생성.png" style="zoom:50%;" />