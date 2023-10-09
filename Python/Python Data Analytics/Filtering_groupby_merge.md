# Data Preprocessing

## Filtering

#### 1)`loc['row','column']`

- series 

```python
df.loc[:,'survived']
```

- dataframe

```python
df.loc[:,['survived']]
```



#### 2) &,\ 

- 'age'가 10살 이상이면서 20살 미만  -> series 형태로 출력

```python
filter1 = (df.age >= 10) & (df.age < 20) #series
```

```python
df.loc[filter1,:] #dataframe
```

- 'age'가 10살 미만 또는 60살 이상
  - 'age','sex','alone' 열만 출력

```python
filter2 = (df.age < 10) | (df.age >= 60)
df.loc[filter2,['age','sex','alone']]
```



#### 3) `query`



## 데이터프레임 합치기

#### 1) `concat`

열방향, 행방향으로 데이터 이어붙이기

```python
pd.concat([TB1, TB2], axis = 0)
pd.concat([TB1, TB3], axis = 0, ignore_index = True) #인덱스 새로 구성
```



#### 2) `merge`

- on = [' ']

```python
pd.merge(TB1, TB2, on = ['Name', 'Gender'])
```



## 그룹 연산

```python
TD = titanic.loc[:, ['age', 'sex', 'class', 'fare', 'survived']]
```

#### 1) `grouby`

- 'class' 기준(first, second, third)

```python
grouped = TD.groupby(['class'])
grouped_two = TD.groupby(['class','sex'])
```

- `get_group`

```python
grouped.get_group('First').head(3) # dataframe
grouped_two.get_group(('First','female')).head(3)
```

- 결과 확인(3개 그룹별,6개 그룹별 평균)

```python
grouped.mean()
grouped_two.mean()
```



#### 2) `agg`

- 여러개의 함수를 groupby 객체에 적용
  - 그룹별로 연산결과 집계 return

```python
grouped_TWO.agg(['mean', 'std'])
grouped.fare.agg(['min', 'max']) # fare 컬럼에만 적용
grouped.agg({'fare' : ['min', 'max'], 'age' : ['mean', 'std']}) # 각기 다른 함수
```



#### 3) `filter`

```python
grouped.filter(lambda x : len(x) >= 200).head() #데이터의 개수 200개 이상만 필터링
grouped.filter(lambda x: x.age.mean() < 30).tail() #age 열 평균이 30보다 작은 데이터만 필터링
```

- 그룹별 데이터 개수

```python
grouped.apply(len) 
```
