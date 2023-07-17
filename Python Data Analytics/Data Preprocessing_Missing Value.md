# Data Preprocessing

pandas 모듈 사용해서 타이타닉 데이터 결측값 채우기

## Missing Value

## 1) 데이터셋 불러오기

```python
import seaborn as sns
df = sns.load_dataset('titanic')
```



## 2) 결측치 확인

` info()`,`head()`,`value_counts()`

```python
df.info() -> 열별 information
-> age, sec, deck 열에서 결측치 확인
```

```python
df.head(10) -> 행 위에서 10개만 추출 (NaN 값 확인)
-> age, sec, deck 열에서 결측치 확인
df.head(10).isnull() -> 결측치를 'True' 로 출력
```

```python
# 결측치 값 포함하여 빈도분석
df['deck'].value_counts(dropna = False) -> 결측치 값 포함하여 빈도분석
```

```python
# 빈도분석
df['deck'].value_counts()
```

```python
# 열별로 결측치 개수 확인(axis = 0): 열, (axis = 1) : 행
df.isnull().sum(axis = 0) -> 결측치 개수 열별로 세기
>>> age 177, deck = 688, embark_town = 2
```

 isnull() : 결측치를 True 로 출력

 notnull() : 결측치를 False 로 출력



## 3) 결측치 삭제

- `dropna(thresh,subset)`

```python
# 300개 이하 측정값이 있는 열(column) 삭제
df.dropna(thresh = 300, axis = 1).shape()  -> deck 열이 삭제됨
```

```python
# age 기준으로 결측치가 있는 행(row) 삭제
df.dropna(subset = ['age'],how = 'any',axis = 0)
-> how = 'all'은 모든 값이 결측값일 때 사용
```



## 4) 결측치 치환

- 연속형 데이터 치환
  - 평균값으로 치환

```python
TD['age'].fillna(int(df['age'].mean(axis = 0)), inplace = True)
```

- 명목형 데이터 치환

  `idxmax()`  최빈값으로 치환

```python
most_freq = df['embark_town'].value_counts(dropna = True).idxmax()
# 결측치를 제외하고 개수 세서 최빈값 설정
```

```
df['embark_town'].fillna(most_embark_town, inplace = True)
```

- `method = ffill`이전 데이터 포인트로 치환

```
TD['embarked'].fillna(most_freq, inplace = True)
```



## 5) 결측치 시각화

- `missingno`

```python
import missingno as msno

msno.matrix(df,
         figsize = (15,7),
         color = (0.8,0.2,0.2));
```

![](/Users/kimsinwoo/Downloads/Unknown-3.png)





