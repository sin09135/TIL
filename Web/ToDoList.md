# Django ToDoList

### 1. 프로젝트 구성하기

#### 1) 가상환경 구축

```bash
$ which python < 파이썬 위치 확인
/Users/kimsinwoo/opt/anaconda3/bin/python

$ virtualenv venv
$ source venv/bin/activate < 가상 환경 들어가기

$ pip install django
```



#### 2) 프로젝트 만들기

`Django-admin startproject 프로젝트명`

```bash
$ django-admin startproject ToDoList < ToDoList 들어가기

$ cd ToDoList 
$ ls
ToDoList        manage.py   < manage 파일 존재하는 거 확인

$ python manage.py startapp my_to_do_app < app 만들기
```

---

### 2. Application 구성하기

#### 1) App 만들기

`python manage.py startapp 앱 네임`

```
$ python manage.py startapp my_to_do_app < app 만들기
```



#### 2) App 등록하기

ToDoList > ToDoList > settings.py

```python
# Application definition

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "my_to_do_app" #마지막 줄에 추가
]

```

---

### 3. URL 설정하기

#### 1) 프로젝트 실행하기

`python manage.py runserver`

```bash
$ python manage.py runserver

You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.
July 26, 2023 - 05:14:22
Django version 4.2.3, using settings 'ToDoList.settings'
Starting development server at http://127.0.0.1:8000/ 
Quit the server with CONTROL-C.

[26/Jul/2023 05:14:31] "GET / HTTP/1.1" 200 12
```

  **Command + 클릭 > 실행**

![](/Users/kimsinwoo/Downloads/runser 실행창.png)

#### 2) 첫페이지 URL

> 사용자가 접근했을 때, urls.py 에서 app으로 넘겨주기

**ToDoList > ToDoList > urls.py**

`from django.urls import path, include`

`path(include('my_to_do_app.urls'))`

![](/Users/kimsinwoo/Downloads/url > app 으로 보내기.png)



#### 3) App 폴더의 urls.py 생성

> 특정 URL로 접근한 사용자에게 보여 줄 화면을 처리할 함수를 연결 해주는 파일

**ToDoList > my_to_do_list > urls.py 생성**

```python
# my_to_do_app > urls.py
#-*- coding:UTF-8 -*-  #한글 파일 처리

from django.urls import path
from . import views

urlpatterns = [
    path('',views.index)
]
```



#### 4) App 폴더의 views.py 에 index 함수 생성

**ToDoList > my_to_do_app > views.py**

```python
from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def index(request):  # 인덱스 함수 생성
    return HttpResponse("첫번째 페이지")
```



#### 5) 실행

`python manage.py runserver`

```
첫번째 페이지






```

---

### 4. HTML 템플릿 사용

#### 1) app 내부에 templates 폴더 생성

**ToDoList > my_to_do_app>templates 생성>my_to_do_app > index.html 생성**

![](/Users/kimsinwoo/Downloads/Html.png)



#### 2) index.html 

데이터**: https://github.com/doorBw/Django_with_PracticeExamples**



#### 3) views.py 수정

`def index(request):
    return render(request, "my_to_do_app/index.html")`

```python
from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
# before

'''
def index(request):
    return HttpResponse("첫번째 페이지")
'''
# after

def index(request):
    return render(request, "my_to_do_app/index.html")
```



![](/Users/kimsinwoo/Downloads/ToDoList - Html.png)



### 5. MVC(Model, View, Controller)

> 소프트웨어 개발 방법론 중 하나

**장고에서 데이터를 사용하기 위한 필수 조건 **

- 어떤 데이터 베이스 사용할 것인지 결정( 기본값. SQL Light)
- 테이블 형태 정의

![](/Users/kimsinwoo/Downloads/common-4.jpeg)



python manage.py makemigrations

python manage.py migrate

python manage.py dbshell

\>.tables