# django gmail 발송

### 1. 준비

- 가상환경 설정

```
% virtualenv venv
% source venv/bin/activate
```

- 패키지 설치
  - 폴더에 requirements.txt 생성 후

```
django-gmail %  pip install -r requirements.txt
```

- 프로젝트 만들기

```
% django-admin startproject djangogmail
```

- 앱 만들기

```
$ cd djangogmail/
$ python manage.py startapp main
```

- 앱 등록하기
  - 파일 경로 : djangogmail > djangogmail > settings.py

```
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "main"
]
```

- 확인

```
$ python manage.py runserver
```

![](/Users/kimsinwoo/Downloads/처음 런서버.png)



### 2. 구글에서 인증키 발급

### 3. 프로젝트 설정

#### (1) Email 설정 세팅

- djangogmail > djangogmail > settings.py

```python
# Email Settings
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_USE_TLS = True
EMAIL_PORT = 587
EMAIL_HOST_USER = 'your_email'
EMAIL_HOST_PASSWORD = 'mvxs~'
```



#### (2) Urls.py 설정

- djangogmail > djangogmail > urls.py

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path('', include('main.urls'))
]
```



#### (3) main 폴더 설정

##### Templates 생성

- djangogmail > main > templates > main > index.html

```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Gmail using Django</title>
</head>
<body>
    <div style="text-align:center;">
        <h4> 연락 정보 </h4>
        <form method="POST" action="{% url 'index' %}">
            {% csrf_token %}
            <input type="text" name="name" placeholder="이메일 제목" required>
            <br>
            <br>
            <input type="email" name="email" placeholder="이메일 주소" required>
            <br>
            <br>
            <textarea name="message" placeholder="메시지 입력" required></textarea>
            <button type="submit">전송</button>
        </form>
    </div>
</body>
</html>
```



##### urls.py

> html 의 action = 'index' 와 연결

- name = 'index'

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
```



##### views.py

- 메일 보내기 기능을 하는 index 함수 생성

```python
from django.shortcuts import render
from django.http import HttpResponse

from django.core.mail import send_mail
from django.conf import settings

# Create your views here.
def index(request, ):
    if request.method == "POST":
        message = request.POST['message']
        email = request.POST['email']
        name = request.POST['name']
        send_mail(
            name, 
            message, # 메시지
            'settings.EMAIL_HOST_USER', 
            [email]
        )
    return render(request, 'main/index.html')
```



### 4. 확인

`python manage.py runserver`

![](/Users/kimsinwoo/Downloads/이메일 발송 실행창.png)

![](/Users/kimsinwoo/Downloads/test 성공.png)