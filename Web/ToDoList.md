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



### 5. 데이터 저장 사용

### MVC(Model, View, Controller)

> 소프트웨어 개발 방법론 중 하나

**장고에서 데이터를 사용하기 위한 필수 조건 **

- 사용할 데이터 베이스 설정 ( 기본값 : sqlLite)
- 테이블 형태 정의

### 1) 모델 만들기

#### (1) models.py

```python
from django.db import models

# Create your models here.

class Todo(models.Model):
    content = models.CharField(max_length= 255)
```

하나의 모델을 하나의 클래스로 나타냄

Todo라는 모델에 대해서 데이터가 content 라는 값 하나를 가짐. 

데이터의 형태 : charfield 형태

데이터 최대 길이 : 255



#### (2) 모델을 서버에 적용

`python manage.py makemigrations`

my_to_do_app에 migration 이라는 폴더 생성

```bash
$ ls
db.sqlite3  manage.py*  my_to_do_app/  ToDoList/

$ python manage.py makemigrations
Migrations for 'my_to_do_app':
  my_to_do_app\migrations\0001_initial.py
    - Create model Todo
```



`python manage.py migrate`

migration  파일들을 확인해서 데이터 베이스에 적용

0001.initial 파일 생성

```
$ python manage.py migrate
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying my_to_do_app.0001_initial... OK
  Applying sessions.0001_initial... OK
```



#### (3) 확인

- Django DB에 접근해서 확인

` python manage.py dbshell`

```bash
$ python manage.py dbshell
SQLite version 3.39.3 2022-09-05 11:02:23
Enter ".help" for usage hints.
sqlite>
```



- 테이블 확인

`.tables`

```
sqlite> .tables
auth_group                  django_admin_log
auth_group_permissions      django_content_type       
auth_permission             django_migrations
auth_user                   django_session
auth_user_groups            my_to_do_app_todo
auth_user_user_permissions
```



- 테이블 정보 확인

` PRAGMA table_info(my_to_do_app_todo);`

```
sqlite> PRAGMA table_info(my_to_do_app_todo);
0|id|INTEGER|1||1
1|content|varchar(255)|1||0
```









python manage.py makemigrations

python manage.py migrate

python manage.py dbshell

\>.tables



### 6. 입력한 