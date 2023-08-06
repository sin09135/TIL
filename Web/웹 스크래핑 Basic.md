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
print_match(m)

m = p.search("sunny") # search : 주어진 문자열 중에 일치하는게 있는지 확인
print_match(m)

```

<img src="/Users/kimsinwoo/Downloads/정규표현식 예제2.png" style="zoom:50%;" />



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