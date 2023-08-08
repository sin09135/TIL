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

`spiders > Worldmeter_crawl.py` 를 생성한다.

앞으로 이 파일에 크롤링 코드를 저장할 것이다.



#### Step1 . country, population, Yearly Change 스크래핑

##### scrapy 기본 구성

```python
import scrapy

class WorldometerItem(scrapy.Item):
    # 크롤링 코드 입력
    def parse(self, response):
      
      yield {
           # yield 키워드를 사용하여 데이터를 하나씩 반환하면 Scrapy가 이를 딕셔너리 형태로 반환한다.
        }

```

파일을 구성하는 기본 구조는 다음과 같다.



- title element 를 통해 구조를 파악해보자

![](/Users/kimsinwoo/Downloads/scrapy_title.png)

title 을 `copy xpath` 로 복사해준다.



- 코드 구현

```python
import scrapy


class WorldometerSpider(scrapy.Spider):
    
    #크롤링 할 도메인 지정
    name = "worldometer"
    allowed_domains = ["www.worldometers.info"]
    
    # 크롤링을 시작할 웹페이지 지정
    start_urls = ["https://www.worldometers.info/world-population/population-by-country"]

    def parse(self, response):
        
        # title 크롤링 코드
        title = response.xpath('//h1/text()').get()
  
        yield {
            'title' : title 
        }
```

복사한 코드를 `title = response.xpath('복사한 코드').get()`  삽입하여 크롤링 코드를 입력하고 `yield{}` 에 입력하여 딕셔너리 형태로 처리한다.

- `scrapy crawl 프로젝트이름`  출력

```bash
$ scrapy crawl worldometer
```

![](/Users/kimsinwoo/Downloads/title 결과 확인.png)

title이 딕셔너리 형태로 출력되는 것을 확인할 수 있다.



##### 1) country, population, Yearly Change 크롤링

- 구조 파악

  >  `command + F` 로 xpath 경로를 입력하면서 맞는 경로를 찾는다.

  - country :  //table/tbody/tr/td[2]/a/text()

  ![](/Users/kimsinwoo/Downloads/country xpath.png)

  - Population : //table/tbody/tr/td[3]/a/text()

  ![](/Users/kimsinwoo/Library/Mobile Documents/com~apple~Preview/Documents/population_html(only).png)

  - Yearly Change : //table/tbody/tr/td[4]/a/text()

  ![](/Users/kimsinwoo/Downloads/yearly_html.png)



- `worldmeter_crawl.py` 코드 구현

- worldmeter_crawl.py

```python
import scrapy

class WorldometerSpider(scrapy.Spider):
    
    name = "worldometer"
    allowed_domains = ["www.worldometers.info"]
    start_urls = ["https://www.worldometers.info/world-population/population-by-country"]

    def parse(self, response):
       
        # country, population, yearly_change 코드
        rows = response.xpath('//table/tbody/tr')
        
        for row in rows:
            country = row.xpath('./td[2]/a/text()').get()
            population = row.xpath('./td[3]/text()').get()
            yearly_change = row.xpath('./td[4]/text()').get()

            yield {
                'country': country,
                'population': population,
                'yearly_change': yearly_change
            }
```



- 출력 결과

![](/Users/kimsinwoo/Downloads/country,population,change 출력.png)

