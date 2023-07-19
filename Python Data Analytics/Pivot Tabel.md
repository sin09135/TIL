# Data Preprocessing

## Pivot_table()

Index : 행 인덱스 , column : 열 인덱스, values : 데이터, aggfunc 적용 함수

- `aggfunc `1개 적용

```python
TD_1 = pd.pivot_table(TD,
                     index = 'class',
                     columns = 'sex',
                     values = 'age',
                     aggfunc = 'mean')

TD_1
```

| sex        | female    | male      |
| ---------- | --------- | --------- |
| Class      |           |           |
| **First**  | 34.611765 | 41.281386 |
| **Second** | 28.722973 | 30.740707 |
| **Third**  | 21.750000 | 26.507589 |



- `aggfunc   `2개 적용

```python
TD_3 = pd.pivot_table(TD,
                     index = ['class', 'sex'],
                     columns = 'survived',
                     values = ['age','fare'],
                     aggfunc = {'age' : ['mean', 'std'], 'fare' : ['min', 'max']})

TD_3
```

### Multi - Index

- 행 인덱스
  - .xs() : Cross Section

```python
TD_3.xs('First', level = 'class', axis = 0) #TD_3 중 class가 first 인 데이터
TD_3.xs(('First', 'male'), level = ['class', 'sex'], axis = 0) #class가 first 이면서 남성인 데이터
```

- `set_names`

```python 
D_3.columns.set_names(['Header', 'Fuction', 'Survived'], inplace = True)
```

MultiIndex ([( 'age', 'mean', 0), 

​                      ( 'age', 'mean', 1), 

​                      ( 'age',  'std', 0), 

​                      ( 'age',  'std', 1),

​                     ('fare',  'max', 0),

​                     ('fare',  'max', 1),

​                     ('fare',  'min', 0),

​                     ('fare',  'min', 1)],

​           names=['Header', 'Fuction', 'Survived'])



- `set_levels` 

```
TD_3.columns.set_levels(['Dead', 'Alive'], level = 2, inplace = True) # 열 이름 변경
TD_3
```

![](/Users/kimsinwoo/Downloads/set_levels.png)

- 열 인덱스

  - 생존자 정보

  ```python
  TD_3.xs('Alive', level = 'Survived', axis = 1)
  ```

  

