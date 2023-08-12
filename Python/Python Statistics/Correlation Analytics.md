## Correlation Analytics

> 상관관계, 인과관계, 상관분석, 상관계수, 공분산

- 상관 관계 : 원인과 결과가 불분명한 관계 -> 연속형 데이터만 의미가 있음

- 인과 관계 : 선행하는 변수의 변화가 다른 변수의 원인으로 작용하는 관계
  - 1. 상관관계가 존재해야 함
    2. 시간의 순서가 존재해야 함
    3. 제 3의 변수가 존재하지 않는다는 것을 증명

#### 상관분석(Correlation Analysis)

양의 상관관계, 음의 상관관계

- 상관계수(r) :  얼마나 관계 있는지 나타내는 수치

  - -1 ~ 1 로 표준화 시킴

  - | 상관계수(+,-) |        상관관계        |
    | :-----------: | :--------------------: |
    |   0.9 이상    |  상관관계가 아주 높다  |
    |   0.7 ~ 0.9   |    상관관계가 높다     |
    |   0.4 ~ 0.7   |    상관관계가 있다     |
    |   0.2 ~ 0.4   | 상관관계가 있으나 낮다 |
    |   0.2 미만    |  상관관계가 거의 없다  |

  

- 공분산(Covarience) : 두 변수가 함께 변화는 정도를 나타내는 지표

  - (+) : 두 변수가 같은 방향으로 변화
  - ( - ) : 두 변수가 반대 방향으로 변화 

- 공분산의 크기

  - 공분산 = 0 이면 두 변수가 독립
  - 공분산의 크기가 클수록 두 변수는 함께 많이 변화
  - 단위에 따라 크기가 달라져 절대적 크기로 판단이 어려움



##### 상관관계, 공분산 구하기

예시 데이터 'https://raw.githubusercontent.com/rusita-ai/pyData/master/PII.csv'

1. Numpy

```python
import numpy as np
#상관계수
np.cov(df.height, df.weight)[0][1] #[1][0]도 상관없음
#공분산
np.cov(DF.Height, DF.Weight)[0][1] / (np.std(DF.Height, ddof = 1) * np.std(DF.Weight,ddof = 1))
np.corrcoef(DF.Height, DF.Weight)[0][1] # 간단하게 구하기
```

2. Scipy

```python
from scipy import stats
#상관계수
stats.pearsonr(DF.Height, DF.Weight)[0] #등간, 비율에만 사용가능
stats.spearmanr(DF.Height, DF.Weight)[0] # +서열척도 있는 경우
stats.kendalltau(DF.Height, DF.Weight)[0] #표본의 크기가 작다면 신뢰성 높음
```

3. pandas

```python
DF.corr(method = 'pearson')
```

4. 시각화

```python
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize = (9,7))
sns.heatmap(DF.corr(),
            cbar = True,
            annot = True,
            annot_kws = {'size' :20},
            fmt = '.2f',
            square = True,
            cmap = 'Blues')
plt.show()
```

![](/Users/kimsinwoo/Downloads/Unknown.png)

