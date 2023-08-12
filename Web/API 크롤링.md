## **API 크롤링** 예시

"서울 열린데이터광장"의 회원가입 및 인증키 발급이 완료된 상태를 전제로 한다.

서울 열린데이터 광장에서 제공하는 open api를 통해 JSON 파일의 데이터를 크롤링할 것이며, 데이터 프레임 형태로 변환 및 CSV로 저장하는 과정을 다룬다.

------

### **1. 서울 열린데이터광장에서 "유동인구" 검색**

### [https://data.seoul.go.kr](https://data.seoul.go.kr/)



![img](https://blog.kakaocdn.net/dn/cQ8nF8/btsq1JLt9Hk/9mAPXgFFWXJbQje2PiquDK/img.png)



 

가장 첫번째에 나오는 **스마트서울 도시데이터 센서(S-DoT) 유동인구 측정 정보**를 클릭한다.

 

### **2. 데이터 설명 확인**

 



![img](https://blog.kakaocdn.net/dn/b13yiY/btsq0ExlIPR/BPE53vTFykArkUTR54zWV0/img.png)



서울 전역 100 곳에 유동인구를 감지할 수 있는 센서에 대한 데이터를 담고 있으며, 10분 단위이다.

###  

### **3. 미리보기 정보 확인(Open API)**

 



![img](https://blog.kakaocdn.net/dn/VGPUV/btsqZyYJirT/VO4Lz99etCp9yISEfSqKz1/img.png)



 미리보기 정보를 확인하고 요청인자에 따라 URL을 입력해야 한다.

샘플 URL 을 살펴보면 ( http://openapi.seoul.go.kr:8088/(인증키)/xml/IotVdata018/1/5/[ ](http://openapi.seoul.go.kr:8088/sample/xml/IotVdata018/1/5/) ) 이다.

즉, http://openapi.seoul.go.kr:8088/(인증키) + 파일 타입/lotVdata018/시작번호/끝번호/자치구 이렇게 입력해 준다.

 

샘플코드를 활용해서 크롤링하는 코드를 작성해 보겠다.

------

## 4. 데이터 크롤링 하기

새로운 ipynb 파일을 생성한 후, 코드를 입력해 준다.

 

- **requests 라이브러리를 이용, 데이터 요청하기**

```
# requests 라이브러리 임포트
import requests 

# json 파일, 1 ~ 1000 개의 데이터를 가져옴
url = 'http://openapi.seoul.go.kr:8088/인증키/json/IotVdata018/1/1000/'

req = requests.get(url) # 정의한 URL로 GET 요청 전송
req.text # 요청한 응답데이터의 본문 가져오기
```

다음과 같이 출력된다. 요청과 응답이 잘 처리된 것을 확인할 수 있다.



![img](https://blog.kakaocdn.net/dn/etL1hl/btsq0EqyXUt/srFdBVijae6lgCyw0od6T1/img.png)



 

 

-  json 파일 형식으로 불러와서 pop 변수에 저장

```
import requests

url = 'http://openapi.seoul.go.kr:8088/인증키/json/IotVdata018/1/1000/'

req = requests.get(url)

# HTTP GET 요청으로 받아온 응답 데이터를 JSON 형식으로 파싱하여 변수 pop에 저장
pop = req.json() 
pop
```



![img](https://blog.kakaocdn.net/dn/cmpRmM/btsq1bOYY2A/3JpgdFk15GomXm8ZtuQDkk/img.png)



 

-  **pop 변수에서 'IotVdata018' 키에 해당하는 값을 찾아서 'row' 키 값 추출**

```
pop['IotVdata018']['row']
```



![img](https://blog.kakaocdn.net/dn/bWmhpW/btsq8LodqKK/1N7GSmm6bQgWCutknwfKjK/img.png)



 

- **데이터 프레임 형태로 만들기**

```
import pandas as pd

pop_live_df = pd.DataFrame(pop['IotVdata018']['row'])
pop_live_df.head()
```



![img](https://blog.kakaocdn.net/dn/KoKDk/btsq5dMdYzA/MMrjBy3Ny8YkXXKL7UxG7k/img.png)



 

- **CSV 파일로 저장하기 (오늘 날짜로 저장)**

```
#csv 로 오늘날짜로 내보내기
from datetime import datetime
now = datetime.now()

today = now.strftime('%Y%m%d')

pop_live_df.to_csv(path_or_buf= "파일경로/S-Dot" + today + ".csv")
```

오늘 날짜를 더해서 출력하기 위해서 datetime을 임포트 해준다.

오늘 날짜를 파일 이름에 더하기 위해서 today 변수로 오늘날짜를 230802 이런 형식으로 저장한다.

이후, 데이터 프레임 형태인 pop_live_df를 csv 형태로 저장하는 코드를 구현해 준다.

 



![img](https://blog.kakaocdn.net/dn/pkKeT/btsqZuu84D3/ZsUFwPeKvQl6WukPYSgXU0/img.png)파일이름 생성

![img](https://blog.kakaocdn.net/dn/puik0/btsq1cAwE4Z/j4pgPMZORcq6y2zmnFeTWK/img.png)csv 파일로 저장