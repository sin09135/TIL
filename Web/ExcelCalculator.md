## Excel Calculator for Mac 

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



---



## 인증코드 메일로 보내기

**로직**

join 함수 : 인증코드를 무작위로 생성 후 > 사용자에게 보냄

 > 사용자에게 보낸 코드 == 사용자가 입력한 코드

일치하면 회원정보가입 성공

아니면, 계속 아님



### 1. 인증코드 생성

- main > views.py

```python
def join(request):
    print("테스트", request)

    name = request.POST['signupName'] 
    email = request.POST['signupEmail']
    pw = request.POST['signupPW']
    user = User(user_name = name,user_email=email, user_password=pw)
    user.save()
    print("사용자 정보 저장 완료됨")

    #인증코드 하나 생성
    code = randint(1000,2000)
    print("인증코드 생성",code)
    
    return redirect("main_verifyCode") 
```



- 테스트

 회원가입 후(/signup), 터미널 확인

![](/Users/kimsinwoo/Downloads/인증코드 .png)



### 2. 응답 객체 생성

- main > views.py

```python
def join(request):
    print("테스트", request)

    name = request.POST['signupName']  
    email = request.POST['signupEmail']
    pw = request.POST['signupPW']
    user = User(user_name = name,user_email=email, user_password=pw)
    user.save()
    print("사용자 정보 저장 완료됨")

    #인증코드 하나 생성
    code = randint(1000,2000)
    print("인증코드 생성",code)
    
    response = redirect("main_verifyCode")
    response.set_cookie('code', code)
    response.set_cookie('user_id',user.id)
    print('응답객체완성',response)

    return redirect("main_verifyCode") 
```

- 테스트

  회원가입 후(/signup), 터미널 확인

![](/Users/kimsinwoo/Downloads/응답객체완성.png)



### 3. 인증코드를 이메일로 발송하기

#### 1) 메일 포멧 만들기 - html 생성

- `sendEmail > templates > sendEmail > email_format.html`

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    </head>
    <body>
        <h1>ExcelCalculate 회원 가입</h1>
        <p>다음의 인증 코드를 입력해 주세요</p>
        <h2> {{ verifyCode }} </h2>
    </body>
```



#### 2) views.py 설정

> send 함수 수정

- `sendEmail > views.py`

```python
from django.shortcuts import render
from django.http import HttpResponse
from django.core.mail import send_mail,EmailMessage
from django.template.loader import render_to_string

# Create your views here.
def send(receiverEmail, verifyCode):
    # main > join 함수 내부에서 사용이 될 것
    # receiverEmail : 사용자가 회원가입 떄 사용한 이메일 주소
    # verifyCode : 인증코드
    # 인증코드 발송은 에러가 날 가능성이 존재
    # try-except 구분문 사용Google 이용 <-- 개발자가 통제할 수 있는 영역이 아님
    try:
        content = {'verifyCode':verifyCode}
        msg_html = render_to_string("sendEmail/email_format.html", content)
        msg = EmailMessage(subject = "인증 코드 발송 메일",
                           body = msg_html,
                           from_email="skwkiix@gmail.com",
                           bcc =  [receiverEmail])
        msg.content_subtype = 'html'
        msg.send()
        print("sendEmail > views.py > send 함수 임무 완료------------")
        return True
    except:
        print("sendEmail > views.py > send 함수 임무 실패 원인 파악하세요 --------")
        return False
```



#### 3) settings.py 설정

> 구글의 SMTP 서버를 사용할 것이므로, 코드를 추가해준다.

- ExcelCalculate > settings.py

```python
ALLOWED_HOSTS = []

#Email settings
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_USE_TLS = True
EMAIL_PORT = 587
EMAIL_HOST_USER = 'skwkiix@gmail.com'
EMAIL_HOST_PASSWORD = '보안키'
```



#### 4) views.py 설정

> send 함수를 join함수에서 호출

- `main > views.py`

```python
def join(request):
    print(request)

    name = request.POST['signupName']
    email = request.POST['signupEmail']
    pw = request.POST['signupPW']
    user = User(user_name = name, user_email = email, user_password = pw)
    user.save()

    # print("사용자 정보 저장 완료됨!! ")

    # 인증코드 하나 생성
    code = randint(1000, 9000)
    print("인증코드 생성-----------------", code) # 서버가 보낸 코드, 쿠키와 세션
    
    response = redirect("main_verifyCode") # 응답을 객체로 저장한다!
    response.set_cookie('code', code) # 인증코드
    response.set_cookie('user_id', user.id)

    print("응답 객체 완성----------------", response)

    # 이메일 발송 하는 함수 만들어보기
    # ExcelCalculate > main > views.py > join 함수 
    # 이메일 주소 2개를 준비를 해주세용
    send_result = send(email, code)
    if send_result:
        print("Main > views.py > 이메일 발송 중 완료된 거 같음....")
        return response
    else:
        return HttpResponse("이메일 발송 실패!")
```

메일 발송이 성공했다면 "이메일 발송 중 완료된 거 같음"

실패한다면 "이메일 발송 실패" 가 출력되도록 구현



- 확인

![](/Users/kimsinwoo/Downloads/이메일 성공.png)

![](/Users/kimsinwoo/Downloads/인증코드 성공.png)

### 4. 인증코드 입력 후 인증 완료한 유저로 설정

#### 1) "인증하기" 버튼 클릭 시 verify 화면으로 이동

- `main > templates > verifyCode.html`

```html
<form action = "verify">
```

```html
<div class="content">
            <div class="mainDiv">
                <h4>회원가입을 위해 입력하신 이메일로 인증코드를 보냈습니다.</h4>
                <h3>이메일로 전송된 메일의 인증코드를 입력해주세요.</h3><br>
                <form action="verify" method="POST">{% csrf_token %}
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">인증코드</span>
                        <input name='verifyCode' type="text" class="form-control" placeholder="인증코드를 적어주세요." aria-describedby="basic-addon1">
                    </div><br>
                    <input type="submit" class="btn btn-success btn-lg" value="인증하기">
                </form>
            </div>
        </div>
```

<form action = "verify">

#### 2) views.py 설정

> 사영자가 입력한 코드값, 쿠키에 저장된 코드값 불러와서 비교하기
>
> 일치 시 user_validate 값을 1로 변경

- `main > views.py`

```python
def verify(request):
    # 사용자가 입력한 code 값을 받아야 함
    user_code = request.POST['verifyCode']

    # get으로 쿠키에 저장되어 있는 code 값을 가져온다(join함수 확인)
    cookie_code = request.COOKIES.get('code')
    print("코드 확인:",user_code, cookie_code)

    if user_code == cookie_code:
        user = User.objects.get(id = request.COOKIES.get('user_id'))
        user.user_validate = 1 #True 1 False 0
        user.save()

        print("DB에 user_validate 업데이트 ---------------")

        response = redirect('main_index')

        # 저장되어 있는 쿠키를 삭제
        response.delete_cookie('code')
        response.delete_cookie('user_id')
        #response.set_cookie('user',user)

        #사용자 정보를 세션에 저장
        request.session['user_name'] = user.user_name # 로그인 화면 구현
        request.session['user_email'] = user.user_email # 로그인 화면 구현

        return response
    else:
        return redirect('main_index')
```



#### 3) 확인

> 인증코드 일치 시, User validate 가 체크되어있는지 확인

- `/verify` 에서 인증코드 입력

![](/Users/kimsinwoo/Downloads/인증코드 인증.png)

- `admin` 으로 이동하여 생성한 관리자 계정으로 로그인 후 DB에 저장된 정보 확인

![](/Users/kimsinwoo/Downloads/user validate.png)



## 로그인, 로그아웃

세션을 이용하여 사용자의 로그인 정보를 관리(로그인된 사용자인지 판단 필요)

### 1. 사용자 정보를 세션으로 저장

#### 1) 추가 설정

- `ExcelCalculate > settings.py`  확인

```python
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware", # 확인
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions", # 확인
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "main", 
    "sendEmail", 
    "calculate"
]
```



#### 2) views.py 수정

> 쿠키를 통해 사용자 정보 저장하는 코드 주석처리,
>
> 사용자 정보를 세션에 저장

- `main > views.py` 

```python
def verify(request):
    # 사용자가 입력한 code값을 받아야 함
    user_code = request.POST['verifyCode']

    # 쿠키에 저장되어 있는 code값을 가져온다. (join 함수 확인)
    cookie_code = request.COOKIES.get('code')
    print("코드 확인: ", user_code, cookie_code)

    if user_code == cookie_code:
        user = User.objects.get(id=request.COOKIES.get('user_id')) # SELECT FROM WHERE id = cookie_id 데이터를 가져오는 것, 
        user.user_validate = 1 # True 1 False 0
        user.save()

        print("DB에 user_validate 업데이트-----------------")

        response = redirect('main_index')

        # 저장되어 있는 쿠키를 삭제
        response.delete_cookie('code')
        response.delete_cookie('user_id')
        # response.set_cookie('user', user) # 주석처리

        # 사용자 정보를 세션에 저장
        request.session['user_name'] = user.user_name   ## 로그인 화면 구현 
        request.session['user_email'] = user.user_email ## 로그인 화면 구현

        return response

    else:
        return redirect('main_verifyCode') # verifyCode 화면으로 돌리기 

```



### 2. 로그인 기능 구현

> 로그인 버튼 클릭시, 이동할 url 처리
>
> 로그인 처리 함수

- `main > signin.html`

> <action = "signin/login" .. >

```html
<div class="content">
            <div class="mainDiv">
                <h3>안녕하세요. 로그인을 진행해주세요.</h3><br>
                <form action="signin/login" method="POST">{% csrf_token %}
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">이메일</span>
                        <input type="email" name='loginEmail' class="form-control" placeholder="이메일을 적어주세요." aria-describedby="basic-addon1">
                    </div><br>
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">비밀번호</span>
                        <input type="password" name='loginPW' class="form-control" placeholder="비밀번호를 적어주세요." aria-describedby="basic-addon1">
                    </div><br>
                    <input type="submit" class="btn btn-success btn-lg" value="로그인">
                </form>
                <a href="signup">회원가입하기</a>
            </div>
        </div>
```



- `main > urls.py` 설정

> 로그인 버튼 클릭 시, 이동할 url 처리 > login 함수로 url 처리를 넘겨줌

```python
from django.urls import path 
from . import views 

urlpatterns = [
    path('', views.index, name="main_index"), 
    path('signup', views.signup, name="main_signup"), 
    path('signup/join', views.join, name="main_join"),
    path('signin', views.signin, name="main_signin"),
    path('signin/login', views.login, name="main_login"), #추가
    path('verifyCode', views.verifyCode, name="main_verifyCode"),
    path('verify', views.verify, name="main_verify"), 
    path('result', views.result, name="main_result"), 
]
```



- `main > views.py` 설정

> 사용자가 입력한 이메일, 비밀번호 불러와서 입력 값과 user 데이터에 저장된 값이 일치하는 지 확인
>
> 일치 > 메인화면으로 이동
>
> 불일치 > 다시 로그인 화면으로 이동

```python
def login(request): 
    # 로그인된 사용자만 이용할 수 있도록 구현
    # 이 때, 현재 사용자가 로그인된 사용자인지 판단하기 위해 세션 사용 FROM (verify함수에서 만든 세션)
    # 세션 처리 진행
    print("----------------------------------접근--------")
    loginEmail = request.POST['loginEmail']
    loginPW = request.POST['loginPW']
    user = User.objects.get(user_email=loginEmail)
    if user.user_password == loginPW:
        print("매칭 성공")
        request.session['user_name'] = user.user_name # 사용자가 회원가입 시, 입력한 정보
        request.session['user_email'] = user.user_email # 사용자가 회원가입 시, 입력한 정보
        return redirect('main_index')
    else:
        # 로그인 실패, 정보가 다름
        print("매칭 실패")
        return redirect("main_loginFail")
```



### 3. 메인화면 로그인

> 로그인 사용자만 접속 가능하게 설정

- `main > views.py`

> Index , result 함수 로그인 처리 구현

```python
def index(request):
    # 로그인된 사용자만 접근
    # 조건문 : 사용자의 정보가 세션에 존재하면 메인(=서비스) 화면으로 출력
    #          만약, 사용자의 정보가 세션에 없다면 로그인 화면으로 출력 
    if 'user_name' in request.session.keys():
        return render(request, 'main/index.html') # 사용자의 세션 정보가 담겨져 있는 상태에서의 index.html
    else:
        return redirect('main_signin')
    
    # return render(request, "main/index.html") # 아무런 세션 정보가 없는 index.html 


def result(request):
    if 'user_name' in request.session.keys(): #장고에서 세션값은 딕셔너리 형태로 저장
        return render(request, 'main/result.html') # 사용자의 세션 정보가 담겨져 있는 상태에서의 index.html
    else:
        return redirect('main_signin')

```



### 4. 로그아웃 기능 구현

- `main > urls.py` 

> 로그아웃 버튼 클릭 시, ~/logout 으로 이동

```python
urlpatterns = [
    path('', views.index, name="main_index"), 
    path('signup', views.signup, name="main_signup"), 
    path('signup/join', views.join, name="main_join"),
    path('signin', views.signin, name="main_signin"),
    path('signin/login', views.login, name="main_login"), 
    path('verifyCode', views.verifyCode, name="main_verifyCode"),
    path('verify', views.verify, name="main_verify"), 
    path('result', views.result, name="main_result"), 
    path('logout', views.logout, name="main_logout") # 추가
]
```



- `main > views.py` 

> logout 함수로 처리, 로그 아웃시 세션에서 user_name, user_email 정보 삭제

```python
ef logout(request):
    # 로그아웃의 개념 : 세션 정보를 삭제하는 것
    # 파이썬에서 객체를 지울 때 
    del request.session['user_name']
    del request.session['user_email']

    return redirect('main_signin')
```

- 확인

> 로그아웃 클릭 시 , 바로 로그인 창으로 넘어감



## 파일 업로드 기능 구현

### 1. 파일 제출 

- `main > index.html`

> "파일 제출" 버튼 클릭 시 이동할 url 설정,  form action = "calculate" 

```html
 <div class="content">
            <div class="fileInputDiv">
                <form action="calculate" method="POST" enctype="multipart/form-data">{% csrf_token %}
                    <div class="input-group">
                        하단 버튼을 통해 파일을 업로드 해주세요.(.xls 확장자의 파일만 가능합니다.)<br>
                        <input id="fileInput" name="fileInput" type="file" class="form-control">
                        <input type="submit" class="btn btn-success btn-lg" value="파일 제출">
                    </div>
                </form>
            </div>
        </div>
```



- `calculate > views.py`

```python
def calculate(request):
    file = request.FILES['fileInput']
    print(" #사용자가 등록한 파일의 이름 :", file)
    return HttpResponse("calculate, calculate function")
```



- 확인

> 파일 제출 시, 터미널에 정상적으로 파일 이름이 출력됨

![](/Users/kimsinwoo/Downloads/사용자가 등록한 파일 이름.png)



## Pandas library 로 액셀 파일 계산하기

**구현할 항목**

- grade 별 최솟값, 최댓값, 평균
- 이메일 도메인 주소별 인원 수



### 1. 엑셀파일 읽어오기

- ` calculate > views.py`

> pandas 모듈 임포트 한 후, 엑셀파일을 데이터 프레임으로 읽어 온다.

```python
from django.shortcuts import render
from django.http import HttpResponse
import pandas as pd

# Create your views here.
def calculate(request):
    # ExcelCalculate > calculate > views.py
    file = request.FILES['fileInput']
    print("# 사용자가 등록한 파일의 이름: ", file)
    df = pd.read_excel(file, sheet_name="Sheet1", header=0)
    print(df.head(5))
    return HttpResponse("calculate, calculate function!")
```

- 확인

> 판다스로 불러온 엑셀파일이 잘 출력되는지 확인

![](/Users/kimsinwoo/Downloads/정상출력.png)



### 2. 계산 구현하기

>  grade 별 최솟값, 최댓값, 평균

> 이메일 도메인 주소별 인원 수

- ` calculate > views.py`

```python
from django.shortcuts import render
from django.http import HttpResponse
import pandas as pd

# Create your views here.
def calculate(request):
    # ExcelCalculate > calculate > views.py
    file = request.FILES['fileInput']
    print("# 사용자가 등록한 파일의 이름: ", file)
    df = pd.read_excel(file, sheet_name="Sheet1", header=0)
    #print(df.head())

    # grade별 value 리스트 만들기 
    grade_dic = {} # 빈 딕셔너리 생성
    total_row_num = len(df.index)
    # print(total_row_num)

    for i in range(total_row_num):
        data = df.loc[i, :]
        if not data.grade in grade_dic.keys():
            grade_dic[data.grade] = [data.value]
        else:
            grade_dic[data.grade].append(data.value)
    # print(grade_dic)

    grade_calculate_dic = {}
    for key in grade_dic.keys():
        grade_calculate_dic[key] = {}
        grade_calculate_dic[key]['min'] = min(grade_dic[key]) # 각 grade별 최소값 ex) grade 1의 최소값
        grade_calculate_dic[key]['max'] = max(grade_dic[key]) # 각 grade별 최대값
        grade_calculate_dic[key]['avg'] = float(sum(grade_dic[key])) / len(grade_dic[key])

    # print(grade_calculate_dic)

    # 결과 출력
    grade_list = list(grade_calculate_dic.keys())
    # print("")
    # print(grade_list)
    grade_list.sort()
    # print(grade_list)
    for key in grade_list:
        print("# grade: ", key)
        print("min:", grade_calculate_dic[key]['min'], end="")
        print("/ max:", grade_calculate_dic[key]['max'], end="")
        print("/ avg:", grade_calculate_dic[key]['avg'], end="\n\n")

   
  # 이메일 주소 도메인별 인원 구하기
    email_domain_dic = {}
    for i in range(total_row_num):
        data = df.loc[i, :]
        # print(data.email)
        email_domain = data['email'].split("@")[1] # 새로운 변수
        if not email_domain in email_domain_dic.keys():
            email_domain_dic[email_domain] = 1 # 새로운 도메인이 나타나면 1 숫자 부여
        else:
            email_domain_dic[email_domain] += 1 # 기존 도메인이 또 나타나면 +1 숫자 추가 (Count)

    print("## Email 도메인별 사용 인원")
    for key in email_domain_dic.keys():
        print("#", key, ": ", email_domain_dic[key], "명")

    return HttpResponse("calculate, calculate function!")
```



- 확인

  ![](/Users/kimsinwoo/Downloads/판다스 계산1.png)

![](/Users/kimsinwoo/Downloads/도메인별 사용인원.png)
