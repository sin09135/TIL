## Hypothesis Testing

**가설검정**

 : 모집단의 특징에 대한 주장인 가설에 대해, 표본으로부터 얻은 정보를 바탕으로 어떤 특징을 채택, 기각할지 판단함으로써 모집단의 현재 특징에 대해 결정하는 과정



### 가설검정 4단계

- 1단계 : 가설 수립
- 2단계 : 표본으로부터 검정을 위한 통계량 계산
- 3단계 : 가설 선택의 기준 수립
- 4단계 : 판정



#### 1단계 : 가설 수립

**귀무가설이 참**이라는 가정 하에 검정 진행

- 귀무 가설(영가설, Null Hypothesis) - H0
  - 일반적 기대영역 이내의 가설
- 대립 가설(연구가설, Alternative Hypothesis)- H1
  - 일반적 기대영역 바깥의 가설



#### 2단계 : 통계량 계산

- 검정 통계량(Test Statistic) - 귀무가설 채택 및 기각 여부 확인
  - 표본분포로부터 표본을 통해 관찰된 통계량



#### 3단계 : 가설선택의 기준 수립

- 오류

|  귀가설 진위  | 귀무가설 채택  | 귀무가설 기각  |
| :-----------: | :------------: | :------------: |
| 귀무가설 사실 |    O (1- α)    | 제 1종 오류(α) |
| 귀무가설 거짓 | 제 2종 오류(β) |   O(1 - β )    |

- 유의수준(Significance Level)
  - 제 1종 오류를 범할 확률의 최대 허용 단계
  - 유의 수준이 α 인 검정 : 제 1종 오류를 범할 확률이 α이하인 검정
- 기각역(Rejection Region, Critical Region)
  - 기각역의 면적의 합은 유의 수준 α가 됨
  - 양측검정(Two - Tailed/Sided Test) : 양쪽에 기각역을 두고 검정
  - 단측검정(One - Tailed/Sided Test) : 한쪽에 기각역을 두고 검정



#### 4단계 : 판정

- 판정 방법
  - 유의확률(P-value)과 유의수준을 이용한 판정
    -  유의확률 < 유의수준(0.05) : 귀무가설 기각
    -  유의확률 > 유의수준 : 귀무가설 채택
  - 검정통계량과 기각역을 이용한 판정
    - 검정통계량이 기각역에 존재 : 귀무가설 기각
    - 검정통계량이 기각역에 있지 않으면 귀무가설 채택



#### Python Package

1. 데이터 불러오기

```python
import pandas as pd

#예시 데이터: 과자 무게 데이터
url = 'https://raw.githubusercontent.com/rusita-ai/pyData/master/foodWeight.csv'
DF = pd.read_csv(url)

DF.info()
```

2. T - Test 사용

- 귀무가설 : 스낵의 평균무게는 50이다.
- 대립가설 : 스낵의 평균무게는 50이 아니다.

```python
import scipy.stats
scipy.stats.ttest_1samp(DF, 50)
>>> TtestResult(statistic=array([2.75033968]), pvalue=array([0.01272559]), df=array([19]))
```

  pvalue 값이 0.05 이하 -> 귀무가설 기각