# 머신러닝 - 붓꽃 품종 예측하기

사이킷런(scikit-learn) 라이브러리를 이용하여 붓꽃 품종을 분류(Clsssification) 하는 모델을 만들어 본다. 

ML 알고리즘은 의사결정트리를 적용해 볼 것이다.



**모델 구현 순서**

>  분류(Classification)는 지도학습의 방법 중 하나이다. 학습을 위한 피처와 레이블(분류 결정값) 데이터로 모델을 학습한 뒤, 별도의 데이터 세트에서 미지의 레이블을 예측한다. 

1. 데이터 세트 분리 : 학습 데이터/ 테스트 데이터
2. 모델 학습 : ML 알고리즘 적용
3. 예측 수행 : 학습된 ML 모델로 예측 수행
4. 평가 : 결과값을 비교해, 모델 성능을 평가



## 0. 데이터 불러오기

- 붓꽃 데이터 세트 로딩

```python
from sklearn.datasets import load_iris               # 예제 데이터 불러오기
from sklearn.tree import DecisionTreeClassifier      # 결정트리 머신러닝 알고리즘 중 하나
from sklearn.model_selection import train_test_split # 훈련 데이터 / 테스트 데이터
from sklearn.tree import DecisionTreeRegressor

# 데이터 세트 로딩
iris = load_iris()
iris_data = iris.data  # 독립변수
iris_label = iris.target # 종속변수

print('iris target', iris_label)
# print('iris data', iris_data)
print('iris target명', iris.target_names)
```



- 데이터 프레임으로 변환

```python
import pandas as pd
iris_df = pd.DataFrame(data=iris_data, columns = iris.feature_names)
iris_df['label'] = iris.target
iris_df
```

<img src="/Users/kimsinwoo/Downloads/데이터 프레임으로 변환.png" style="zoom:67%;" />

피쳐 : sepal length, sepal width, petal length, petal width

레이블 : 0(Setosa) ,1(versicolor) , 2(virginia) 품종



## 1. 학습용, 테스트용 데이터 분리

사이킷런은 train_test_split() API 를 제공한다.

따라서, 학습데이터와 테스트 데이터를 test_size 파라미터 입력값의 비율로 분할한다.

```python
# 0은 setosa, 1은 versicolor 2는 virginica 품종으로 구분
X_train, X_test, y_train, y_test = train_test_split(
    iris_data     # 피처
    , iris_label # 레이블
    , test_size=0.2 # 테스트 데이터 비율 
    , random_state=2023 # 숫자는 아무거나 지정해도 상관없다.
)
```

학습용 피처 데이터 세트 >  X_train, 학습용 레이블 데이터 세트 >   y_train

테스트용 피처 데이터 세트 >  X_test, 테스트용 레이블 데이터 세트 > y_test 로 반환한다.



## 2. 모델 학습

- 의사결정트리 클래스 객체 생성

```python
# DecisionTreeClassifier 객체 생성
dt_clf = DecisionTreeClassifier(random_state=11)
```



- 학습 수행

DecisionTreeClassifier 의 fit() 메서드 이용

```python
# 학습 수행
dt_clf.fit(X_train, y_train)
```



## 3. 예측 수행

- 예측 수행

Predict() 메서드에 테스트용 피처 데이터 세트를 입력

```python
pred = dt_clf.predict(X_test)
```



## 4. 모델 평가

사이킷런이 제공하는 정확도 측정 함수 accuracy_score() 사용

```python
from sklearn.metrics import accuracy_score
print('예측 정확도 : {0:.4f}''.accuracy_score(y_test, pred))
```

예측 정확도 : 0.9333