# R sqldf Package

### 1. "sqldf" Package

	#### 1) Install 'sqldf' Package

깃허브에서 다운

```R
devtools::install_github("ggrothendieck/sqldf")
```

#### 2) installed Packages

```R
library()
```

#### 3) Import "sqldf" Package

```R
library(sqldf)
```



### 2. Load Data

- `read_csv()`  

데이터 불러오기

```R
url = 'https://raw.githubusercontent.com/rusita-ai/pyData/master/PII.csv'dfB df<- read.csv(url)
```

- `str`

 데이터 구조 확인

```R
str(TB)
```

- `head`

```R
head(TB,5) #head 기본값 : 5 
```



### 3. SQL 수행

#### 1) "SELECT *(컬럼) FROM Table_Name(data frame)"

```R
sqldf("SELECT Height FROM TB") #Height 만 출력
sqldf("SELECT Gender, Height FROM TB") %>% head(3) # Gender, Height 3번째 행까지 출력
sqldf("SELECT * FROM TB") %>% head(3) #모든 컬럼 3번째 행까지 출력

```



#### 2)" WHERE" 조건구문

##### (1) AND,OR

```R
sqldf("SELECT * FROM TB WHERE Height > 175 AND Weight < 75") #AND
sqldf("SELECT * FROM TB WHERE Height > 175 OR Age = 24") #OR
```



#### 3) 명목형 연산

```R
sqldf("SELECT * FROM TB WHERE Name = '강백호'")
```



#### 4) "IN" 연산자

- OR 비슷

```R
sqldf("SELECT * FROM TB WHERE BloodType IN ('A', 'B', 'O')")
```



#### 5) "Like" 연산자

- 특정 문자 시작, 중간, 끝 값을 추출

```R
sqldf("SELECT * FROM TB WHERE Weight LIKE '5%'") #시작
sqldf("SELECT * FROM TB WHERE Name LIKE '%소%'") #중간
sqldf("SELECT * FROM TB WHERE Name LIKE '%정'") #끝
```



#### 6) "GROUP BY" 연산자

- 중복값 제외 1개의 고유값 출력

```R
sqldf("SELECT Grade FROM TB GROUP BY Grade")
```



#### 7)"SUM" ,"AVG" 연산자

```R
sqldf("SELECT Grade, SUM(Age), SUM(Height), SUM(Weight)
		   FROM TB  GROUP BY Grade")
sqldf("SELECT Grade, AVG(Age), AVG(Height), AVG(Weight)
		   FROM TB  GROUP BY Grade")
```



#### 8) "HAVING" 연산자

- 추가 조건

```R
sqldf("SELECT Grade, AVG(Age), AVG(Height), AVG(Weight)
		   FROM TB
		   GROUP BY Grade
		   HAVING AVG(Height) > 170")
```



 #### 9) "ORDER BY" 연산자

- 오름차순 : ASC , 내림차순: DESC
- ORDER BY 컬럼명 (ASC/DESC)

```R
sqldf("SELECT * FROM TB WHERE Height > 170 ORDER BY Height ASC")
```



#### 10) "AS" 연산자

- Colunm Name 변경

```R
sqldf("SELECT SUM(Height) AS SUM_Height FROM TB")
```

