## Excel Calculator for Mac - 1

이 포스팅은 "Django 한그릇뚝딱"의 Chapter4 내용을 실습하며 정리한 내용이다.

![](/Users/kimsinwoo/Downloads/XL.jpeg)

## 프로젝트 개요

- 액셀 계산 사이트 만들기
- 기능 구현 
  - 로그인 및 회원가입(이메일 인증 방식)
  - 파일 업로드 
  - 업로드 된 엑셀 파일 계산



## 가상 환경 세팅 및 app 구성

### 1. 가상환경 세팅

- `which python` : python 위치 확인

- `virtualenv venv`  
- `source venv/bin/activate` : 가상환경 활성화



### 2. 라이브러리 설치

requirements.txt를 이용하여 필요한 라이브러리를 설치해준다.

- requirements.txt 생성 후 내용 작성(경로 : ExcelCalculator/)

```txt
django
openpyxl
pandas
jinja2
```

- 라이브러리 설치

```bash
$ pip install -r requirements.txt
```



### 3. 프로젝트 이름 설정

ExcelCalculate로 프로젝트 이름을 설정해준다.

- `Django-admin startproject ExcelCalculate`



### 4. 앱 등록

총 3개의 앱. main, sendEmail, calculate 을 만든다.

- `python manage.py startapp 앱 이름`

```bash
$ cd ExcelCalculate
$ python manage.py startapp main
$ python manage.py startapp sendEmail
$ python manage.py startapp calculate
```



### 5. HTML 파일 추가

저자의 깃허브에서 html 파일 다섯개를 다운로드 한후, 아래 경로에 붙여준다.

- http://github.com/doorBW/Django_with_PracticeExamples/tree/master/project/ExcelCalculate

- `main>templates>main>`

![](/Users/kimsinwoo/Downloads/hrml 5개 다운로드.png)

### 6. urls.py 설정

sendEmail app, calculate app 은 각 앱의 urls.py에서 처리하도록 보내

아무런 일치 사항이 없는 경우 main app의 urls.py에서 처리하도록 설정한다.

- `ExcelCalculate>ExcelCalculate>urls.py`

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path('email/', include('sendEmail.urls'), name="email"), 
    path('calculate/', include('calculate.urls'), name="calculate"),
    path('', include('main.urls'), name="main"),
]
```



### 7. 각 앱의 urls.py 생성 후 설정

- `sendEmail > urls.py`

  sendEmail > views.py의 send 함수로 처리하도록 작성한다. (~/email/send)

```python
from django.urls import path
from . import views

urlpatterns = [
    path('send',views.send, name = "email_send"),
]
```

- `calculate > urls.py`

calculate > views.py 의 calculate 함수로 처리하도록 작성한다.

```Python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.calculate, name = "calculate_do"),
]
```

- `main > urls.py`

메인화면, 회원가입, 로그인, 인증코드 입력, 인증코드 확인, 결과확인 url을 처리한다.

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name="main_index"), #메인화면
    path('signup', views.signup, name="main_signup"), #회원가입
    path('signin', views.signin, name="main_signin"), #로그인
    path('verifyCode', views.verifyCode, name="main_verifyCode"), #인증코드 입력
    path('verify', views.verify, name="main_verify"), #인증 코드 확인 
    path('result', views.result, name="main_result"), # 결과화면
]
```





### 8. 각 앱의 views.py 설정

- `main > views.py`

```python
from django.shortcuts import render, redirect

# Create your views here.
def index(request):
    return render(request, "main/index.html")

def signup(request):
    return render(request, "main/signup.html")

def signin(request):
    return render(request, "main/signin.html")

def verifyCode(request):
    return render(request, "main/verifyCode.html")

def verify(request):
    return redirect("main:index")  # 인증이 완료되면 메인 화면으로 보내줌

def result(request):
    return render(request, "main/result.html")


```

- `sendEmail > views.py`

​    urls.py 에서 views.py에 연결해 준 함수 send 를 생성한다.

```python
from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def send(receiverEmail, verifyCode):
    return HttpResponse("sendEmail, send function!")
```

- `calculate > views.py`

   urls.py 에서 views.py에 연결해 준 함수 calculate 을 생성한다.

```python
from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def calculate(request):
    return HttpResponse("calculate, calculate function!")
```

- `main > views.py`

urls.py에서 views.py로 연결해준 함수 index, signup, signin, verifyCode, verify, result를 생성한다.

```python
from django.shortcuts import render, redirect

# Create your views here.
def index(request):
    return render(request, "main/index.html")

def signup(request):
    return render(request, "main/signup.html")

def signin(request):
    return render(request, "main/signin.html")

def verifyCode(request):
    return render(request, "main/verifyCode.html")

def verify(request):
    return redirect("main:index")  # 인증이 완료되면 메인 화면으로 보내줌

def result(request):
    return render(request, "main/result.html")

```



### 9. 결과화면 출력 확인

- 메인화면 : https://127.0.0.1:8000/
- 로그인 화면 :https://127.0.0.1:8000/signin
- 회원가입 화면 : https://127.0.0.1:8000/signup
- 인증 이메일 화면 : https://127.0.0.1:8000/verifyCode
- 결과 화면 : https://127.0.0.1:8000/result
- 이메일 전송 화면 : https://127.0.0.1:8000/email/send
- 계산 화면 : https://127.0.0.1:8000/calculate
- 인증 화면 :https://127.0.0.1:8000/verify (메인화면으로 돌아가야 함)



## 관리자 페이지 설정(admin)

> admin 페이지 설정 시, 웹 페이지에서 데이터들을 확인할 수 있다.

### 1. superuser 생성

- `python manage.py makemigrations`
- `python manage.py migrate`
- `python manage.py createsuperuser`

```
Username: 
Email address: 
Password:
```

![](/Users/kimsinwoo/Downloads/admin..png)



### 이메일 인증으로 회원가입 하기

#### 이메일 인증으로 회원가입 프로세스

- 회원가입 화면에서 개인정보 입력 후, 회원가입하기 버튼 클릭
- 해당 입력한 정보로 user 데이터 모델에 추가 및 DB 에 저장, 인증되지 않은 uwer로 등록
- 입력한 이메일로 인증 코드 발송
- Verify code 화면으로 전환
- 사용자가 인증코드 입력, 인증하기 버튼을 클릭할 때, 일치하면 성공/일치하지 않으면 실패
  - 쿠리를 활용한 방식, 세션을 활용한 방식
- 성공시, 회원의 이증값 인증이 완료된 회원 등록 / 회원정보 삭제



### 1. 모델 만들기

> 사용자 정보를 저장할 모델 생성

#### 1) 모델 정의

> 이름, 이메일, 비밀번호, 인증여부

- `main > models.py`

```python
from django.db import models

# Create your models here.
# ExcelCalculate > main > models.py

class User(models.Model):
    user_name = models.CharField(max_length=20) # 이름
    user_email = models.EmailField(unique=True) # 이메일
    user_password = models.CharField(max_length=100) # 비밀번호
    user_validate = models.BooleanField(default=False) #인증여부(기본값:인증되지 않은 값)
```



#### 2) 모델 반영

- `python manage.py make migrations`

```bash
$ python manage.py mage migrations
Migrations for 'main':
  main/migrations/0001_initial.py
    - Create model User
```

- `python manage.py migrate`

```bash
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, main, sessions
Running migrations:
  Applying main.0001_initial... OK
```





#### 2. 회원가입 사용자 데이터 DB에 저장

#### 1) html 설정

> 회원가입 때 이동할 url 설정

- `action = signup/join`

```html
 <div class="content">
            <div class="userInfoInputDiv">
                <h1> 회원가입 하기 </h1><br>
                <form action="signup/join" method="POST" id="signup-form">{% csrf_token %}
```



#### 2) urls.py 설정

> 회원 가입 버튼 클릭 시, ~/signup/join url로 이동

- `path('signup/join',views.join, name = "main_join")`

```python
urlpatterns = [
    path('', views.index, name="main_index"), 
    path('signup', views.signup, name="main_signup"), 
    path('signup/join',views.join, name = "main_join"), #추가
    path('signin', views.signin, name="main_signin"),
    path('verifyCode', views.verifyCode, name="main_verifyCode"),
    path('verify', views.verify, name="main_verify"), 
    path('result', views.result, name="main_result"),
]
```



#### 3) views.py 설정

> join 함수 생성

```python
def join(request):
    print(request)

    name = request.POST('signupName')
    email = request.POST('signupEmail')
    pw = request.POST('signupPW')
    user = User(user_name = name,user_email = email, user_password = pw)
    user.save()
    print("사용자 정보 저장 완료됨")
    return redirect("main_verifyCode")
```



#### 4) User admin에 등록

> 모델 등록

- `main > admin.py`

```python
from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(User) # 추가
```



#### 5) 등록 확인

> 회원가입 후, /admin 페이지에 접근해서 등록되어 있는지 확인

- 회원 가입 /signup

![](/Users/kimsinwoo/Downloads/회원가입 입력.png)

- /admin

![](/Users/kimsinwoo/Downloads/ㅇ데이터 저장.png)



