# Python Statistics

통계학에서 알고 싶은 것 > 모집단의 특징

특징 : 중심화 경향치 , 산포도

## 1. Descriptive Statistics

기술통계 : 특정 집단에 관한 현상을 수학적으로 연산하여 기술

### 통계 변수

- 범주형 변수(정성적)
  - 명목형 척도 : == , !=  측정값 사이에 순서 없음
  - 순서형 척도 : > , < , >= , <=  간격이 동일하지 않음.
- 수치형 변수
  - 이산형 척도 : +, -  0의 의미 임의적
  - 연속형 척도 : *,/ 사칙연산 모두 가능



### 중심화 경향치

집단을 대표하는 값(무엇을 중심으로 모여있는가?)

- 평균
- 중앙값
- 최빈값



### 산포도

집단 내 데이터가 흩어져 있는 정도

- 분산
- 표준편차
- 범위
- 사분위 범위 : 사분위 수에서 25% ~ 75% (**IQR**)사이의 값들(**boxplot**) 내에서 표현

----

#### 기술통계 구하기

- pandas

```python
df = sns.load_dataset('tips')
df.info()
df.head()
```

```python
#tip 컬럼이 연속형 척도
import pandas as pd
df.tip.describe()
df.tip.sum()
df.tip.mean()
df.tip.quantile(q = 0.75) #분위수
df.tip.median()
df.tip.max()
df.tip.var(ddof = 0)
df.tip.std(ddof = 0)
```

- numpy

```python
import numpy as np
AR = np.array(df.tip)
AR.sum()
AR.mean()
AR.min()
AR.max()
AR.var(ddof = 0)
AR.std(ddof = 0)
```

- scipy

```python
import scipy as sp
sp.sum(df['tip'])
sp.mean(df['tip'])
sp.amin(df['tip'])
sp.median(df['tip'])
sp.amax(df['tip'])
sp.var(df['tip'],ddof = 0)
sp.std(df['tip'],ddof = 0)
sp.stats.mode(df['tip'])
```



## 2. Probability

확률(가능성) : 일정한 조건하에 어떤 사건이 발생할 가능

통계 : 데이터를 수집 및 정리하여 특징을 확인

- 수학적 확률 : 어떤 사람이 계산에도 동일한 값으로 계산됨
- 통계적 확률 : 어떤 사건을 독립시행으로 반복했을 때 발생하는 확룰
- 주관적 확률 



#### 용어 정리

|   집합    |   확률    |     통계      |
| :-------: | :-------: | :-----------: |
|   원소    |   원소    | 데이터 포인트 |
| 전체 집합 | 표본 공간 |    모집단     |
| 부분 집합 |   사건    |   표본 집단   |
