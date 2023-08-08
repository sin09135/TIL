# Scrapy 크롤링, 스크래핑

> Scrapy는 웹 크롤링 및 스크래핑을 위한 파이썬 기반의  오픈소스 프레임워크이다. 웹 페이지에서 데이터를 추출하고 필요한 정보를 구조화된 형식으로 저장할 수 있다.



## worldometer 인구 데이터 

### 1. 크롤링 전 준비

#### 1) 폴더, 가상환경 세팅

- 원하는 경로에 작업할 폴더를 생성한다.

```bash
$ mkdir worldometer_scrapy
```



- Vscode 를 실행한다.

```
$ cd worldometer_scrapy
$ code .
```



- [터미널] 에서 가상환경을 세팅한다

```bash
$ virtualenv venv
$ source venv/bin/activate
```



- `scrapy` 프레임워크를 설치한다.

```
$ pip install scrapy
```



- scrapy 명령어가 잘 실행되는지 확인한다

```
$ scrapy
```

<img src="/Users/kimsinwoo/Downloads/scrapy 명령어 실행.png" style="zoom:150%;" />



#### 2) worldometer 프로젝트 생성

- `scrapy startproject "프로젝트이름"`

```
$ scrapy startproject worldometer
```

![](/Users/kimsinwoo/Downloads/scrapy startproject.png)

<img src="/Users/kimsinwoo/Downloads/worldmeter 생성.png" style="zoom:50%;" />

프로젝트가 잘 생성되었다.



### 2. 크롤링 데이터 구조 파악

- 웹 사이트

https://www.worldometers.info/world-population/population-by-country

- 웹사이트 메인 화면

![](/Users/kimsinwoo/Downloads/population 메인.png)



- `worldmeter_crawl.py` 생성

<img src="/Users/kimsinwoo/Downloads/worldmeter_crawl 생성.png" style="zoom:50%;" />

spiders > Worldmeter_crawl.Py 를 생성한다.

앞으로 이 파일에 크롤링 코드를 저장할 것이다.



#### Step1 . country, population, Yearly Change 스크래핑

##### 1) 

