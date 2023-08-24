# 회귀 실습 - 자전거 대여 수요 예측

실습데이터는 https://www.kaggle.com/c/bike-sharing-demand/data 에서 받을 수 잇다.

**이 포스팅은 < 파이썬 머신러닝 완벽 가이드(개정 2판) >을 학습하면서 정리한 내용이다.(https://www.yes24.com/Product/Goods/69752484)**

**
**

## **자전거 대여 수요 예측**

------

### **Step 0. 데이터 다운로드 & 라이브러리 & 한글폰트 설치 & 구글 드라이브 연동**

#### **1. 실습 데이터 다운받기**

**( https://www.kaggle.com/c/bike-sharing-demand/data?select=train.csv )**

![img](https://blog.kakaocdn.net/dn/dsCUEL/btsrYyJKwzj/Rkv9PwVOpsUVBVRXhiav3K/img.png)





2011.01 ~ 2012.12 기간 동안의 날짜/시간, 기온, 습도, 풍속 등의 날씨 정보를 기반으로 한 자전거 대여 횟수가 기재되어 있는 데이터이다.

train.csv 파일을 다운 받아준 후, bike_train.csv 로 이름을 변경해준다.

![img](https://blog.kakaocdn.net/dn/xoxjY/btsrYMBeUv5/OMH4CLvkdtrVw4E6388xkk/img.png)train.csv

------

#### **2. 데이터 정보**

**Data Fields**

**datetime** - hourly date + timestamp   **season** -  1 = spring, 2 = summer, 3 = fall, 4 = winter  **holiday** - whether the day is considered a holiday **workingday** - whether the day is neither a weekend nor holiday **weather** - 1: Clear, Few clouds, Partly cloudy, Partly cloudy 2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist 3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds 4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog  **temp** - temperature in Celsius **atemp** - "feels like" temperature in Celsius **humidity** - relative humidity **windspeed** - wind speed **casual** - number of non-registered user rentals initiated **registered** - number of registered user rentals initiated **count** - number of total rentals

------

#### **3. 라이브러리 & 한글 폰트 설치**

이 실습은 Google Colab에서 진행할 것이다. 다음의 코드를 실행해준다.

```
!pip install lightgbm==3.3.2  # lightBGM 다운그레이드 설치
!sudo apt-get install -y fonts-nanum
!sudo fc-cache -fv
!rm ~/.cache/matplotlib -rf
import lightgbm
lightgbm.__version__ # 버전확인
```



- 런타임 다시시작 후, 아래 테스트 코드 실행

```
import matplotlib.pyplot as plt
plt.rc("font", family="NanumGothic") # 라이브러리 불러오기와 함께 한번만 실행

plt.plot([1, 2, 3])
plt.title("한글")
plt.show()
```



- 구글 드라이브 연동하기

```
from google.colab import drive
drive.mount('/content/drive')
```

------

### **Step 1. 라이브러리 & 데이터 준비**

- 라이브러리 불러오기

```
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline

import warnings
warnings.filterwarnings('ignore',category = RuntimeWarning)
```



- 데이터 불러오기

```
bike_df = pd.read_csv("bike_train.csv")
print(bike_df.shape)
bike_df.head(3)
```

![img](https://blog.kakaocdn.net/dn/5IN5d/btsr5ewtjCr/eKay5EoISwjDhUF8Eknbs1/img.png)

- 데이터 정보 확인

```
bike_df.info()
```

![img](https://blog.kakaocdn.net/dn/bP8pPv/btsr0tVvXMB/AuQ7cN9FG57kkaFzBwXDbK/img.png)



- 날짜 데이터 datetime 으로 변경 후, 년/월/일 추출

```
# 문자열을 datetime 타입으로 변경.
bike_df['datetime'] = bike_df.datetime.apply(pd.to_datetime)

# datetime 타입에서 년, 월, 일, 시간 추출
bike_df['year'] = bike_df.datetime.apply(lambda x : x.year)
bike_df['month'] = bike_df.datetime.apply(lambda x : x.month)
bike_df['day'] = bike_df.datetime.apply(lambda x : x.day)
bike_df['hour'] = bike_df.datetime.apply(lambda x: x.hour)
bike_df.head(3)
```

------

### **Step 2. 데이터 가공 & 탐색적 데이터 분석**

- 컬럼 삭제

```
# 컬럼 삭제
drop_columns = ['datetime','casual','registered']
bike_df.drop(drop_columns, axis = 1, inplace = True)
```

년/ 월 / 일 로 분류한 datetime 컬럼과 casual + registered = count 이므로, casual, registered 컬럼을 삭제해준다.



- 시각화

```
cat_features = ['year', 'month','season','weather','day', 'hour', 'holiday','workingday']
fig, ax = plt.subplots(figsize = (16,8),ncols = 4, nrows = 2)
for i , feature in enumerate(cat_features):
  row = int(i/4) # 몫 0,1
  col = i % 4 # 나머지
  sns.barplot(x = feature, y = 'count',data = bike_df, ax = ax[row][col])
  ax[row][col].set_title(f"ax[{row}][{col}]")

plt.show()
```

Target 값(종속 변수)인 count(대여 횟수) 컬럼을 기준으로 데이터 분포를 살펴본다.



![img](https://blog.kakaocdn.net/dn/evBXAL/btsr5ggNFLl/hk5BZvn2KQkKlgp3p7O6yk/img.png)

ax[0][0] : 2012 > 2011 상대적으로 count 값이 2012 년에 더 높음

ax[0][1] : 월별 분포. 6,7,8,9 월이 count 값 높음

ax[0][2] : 계절별 분포. 여름, 가을이 count 값 높음

ax[0][3] : 날씨 분포, 맑거나(1) 약간 안개(2) 가 있는 경우 count 값 높음

ax[1][1] : 시간별 분포, 오전 출근시간(8), 오후 퇴근시간(17,18) 이 상대적으로 높음

---

### **Step 3. 평가지표 구현**



다양한 회귀모델을 다양한 세트에 적용해 볼 것이다.

캐글에서 요구한 성능평가방법은 **RMSLE(Root Mean Square Log Error)이다.**

오류 값의 로그에 대한 평가지표이다.

(RMSLE에 관한 자세한 사항은 다음의 포스팅을 참고하자. )

https://ahnjg.tistory.com/90

 

RMSLE (Root Mean Squared Log Error)

회귀의 평가를 위한 지표는 실제 값과 회귀 예측값의 차이를 기반으로 합니다. 회귀 평가지표 중에 RMSLE가 있는데 값이 작을수록 회귀 성능이 좋은 것입니다. 예측값과 실제값의 차이가 없다는

ahnjg.tistory.com

```python
from sklearn.metrics import mean_squared_error, mean_absolute_error

# log 값 변환 시 , NaN 등의 이슈로 log() 사용 안함, log1p() 사용함
def rmsle(y,pred):
  log_y = np.log1p(y)
  log_pred = np.log1p(pred)
  squared_error = (log_y - log_pred)** 2
  rmsle = np.sqrt(np.mean(squared_error))
  return rmsle

# mean_squared_error() 를 이용해서 rmse 계산
def rmse(y,pred):
  return np.sqrt(mean_squared_error(y,pred))

# MAE, RMSE, RMSLE 를 모두 계산
def evaluate_regr(y,pred):
    rmsle_val = rmsle(y,pred)
    rmse_val = rmse(y,pred)
    # MAE 는 scikit learn의 mean_absolute_error() 로 계산
    mae_val = mean_absolute_error(y,pred)
    print('RMSLE: {0:.3f}, RMSE: {1:.3F}, MAE: {2:.3F}'.format(rmsle_val, rmse_val, mae_val))
```

------

### **Step 4. 로그 변환 & 피처 인코딩 & 모델 학습**

**회귀 모델을 적용 전, 참고 사항**

- Target 값의 분포가 왜곡된 형태인지, 정규분포 형태인지
- 피처 인코딩

다음의 두 가지를 염두한 상태로 회귀예측을 해보자.

회귀 예측에는 사이킷런 의 LinearRegression을 이용한다.

```python
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.linear_model import LinearRegression, Ridge, Lasso

# 정규화, 표준화 작업 선 진행해줘야 함
y_target = bike_df['count']
X_features = bike_df.drop(['count'], axis = 1, inplace = False)

X_train, X_test, y_train, y_test = train_test_split(X_features, y_target, test_size = 0.3, random_state = 0)
X_train.shape, X_test.shape, y_train.shape, y_test.shape


lr_req = LinearRegression()
lr_req.fit(X_train, y_train)
pred = lr_req.predict(X_test)

evaluate_regr(y_test, pred)
```



![img](https://blog.kakaocdn.net/dn/bArErV/btsrYAVmKkw/HKrNtYgI7ZXT36aItSyg41/img.png)



예측 오류로서 비교적 큰 값이 도출되었다. 

따라서, result_df 데이터프레임을 만들어서 실제값과 예측값의 차이를 알아봐야 한다.

------

### **Step 5. 모델 평가**

```python
def get_top_error_data(y_test, pred, n_tops = 5):
  result_df = pd.DataFrame(y_test.values, columns = ['real_count'])
  result_df['Predicted_count'] = np.round(pred)
  result_df['diff'] = np.abs(result_df['real_count'] - result_df['Predicted_count'])

  # 예측값과 실제값이 가장 큰 데이터 순으로 출력
  print(result_df.sort_values('diff', ascending = False)[:n_tops])

get_top_error_data(y_test,pred,n_tops = 5)
```



![img](https://blog.kakaocdn.net/dn/cmf3Aa/btsr5ZlMe9c/WJ4WgM0yRbFbkAltt1o1SK/img.png)



예측값과 실제값의 차이가 가장 큰 데이터 순서대로 출력해 본 결과 오류 값은 546~168 사이로, 예측 오류가 매우 크다는 것을 알 수 있다.

따라서, 앞서 언급했던 Target 값인 count가 정규분포를 따르는지, 왜곡된 분포인지 확인해야 한다.

```python
y_target.hist()
```



![img](https://blog.kakaocdn.net/dn/nzDgd/btsr64G9c1x/RlGuCvQtqMLZvXbK47rWp1/img.png)count 분포



왜곡된 값을 정규분포 형태로 만들기 이해, **로그 변환**이 필요하다.

```python
y_log_transform = np.log1p(y_target) # 로그 변환
y_log_tranform.hist()
```



![img](https://blog.kakaocdn.net/dn/EDe6Z/btsr62WRrHH/L0wBOyeLkVb8HS15qAtpw1/img.png)count 로그 변환 후 분포



로그 변환을 통해, 왜곡 정도가 줄어든 것을 확인할 수 있다.

따라서 다시, **모델 학습/예측/ 평가**를 진행한다.

 

```python
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.linear_model import LinearRegression, Ridge, Lasso

# 정규화, 표준화 작업 선 진행해줘야 함
y_target_log = np.log1p(y_target) # 이 부분 변경
X_features = bike_df.drop(['count'], axis = 1, inplace = False)

X_train, X_test, y_train, y_test = train_test_split(X_features, y_target_log, test_size = 0.3, random_state = 0)
#X_train.shape, X_test.shape, y_train.shape, y_test.shape

lr_req = LinearRegression()
lr_req.fit(X_train, y_train)
pred = lr_req.predict(X_test)

# 테스트 데이터 셋의 Target 값은 Log 변환되었으므로 다시 expm1를 이용하여 원래 scale로 변환
y_test_exp = np.expm1(y_test)

# 예측 값 역시 Log 변환된 타깃 기반으로 학습되어 예측되었으므로 다시 exmpl으로 scale변환
pred_exp = np.expm1(pred)

evaluate_regr(y_test_exp ,pred_exp)
```



![img](https://blog.kakaocdn.net/dn/K6nTV/btsrVt99DE7/5pjxHkW1NqsKsxT4YFaaBk/img.png)



로그 변환으로 RMSLE 오류는 줄어들었지만, RMSE 값이 늘어난 걸 확인할 수 있다.

따라서, 개별 비쳐의 인코딩을 확인해야 한다.

 

- **각 피처의 회귀 계수값 시각화**

```python
coef = pd.Series(lr_req.coef_,index=X_features.columns)
coef_sort = coef.sort_values(ascending=False)
sns.barplot(x=coef_sort.values, y=coef_sort.index)
```



![img](https://blog.kakaocdn.net/dn/pMzMs/btsr5YtDTbi/Q7kG5HMjUXJ11LIZowflak/img.png)회귀 계수 영향도



6가지 피처의 회기 계수 영향도가 상대적으로 높은 것을 확인할 수 있다.

특히, year, month, hour 변수의 경우 - 숫자형 데이터이지만, 카테고리 형이다. 사이킷런에서는 카테고리형 변수를 처리할 데이터 타입이 없기 때문에, 원핫 인코딩으로 변환해줘야 한다.

 

- **원핫 인코딩**

```python
# 'year', month', 'day', hour'등의 피처들을 One Hot Encoding
X_features_ohe = pd.get_dummies(X_features, columns=['year', 'month','day', 'hour', 'holiday',
                                              'workingday','season','weather'])
```

 

다시, **모델 학습 / 예측 / 평가**를 진행한다.

- **사이킷런 의 선형회귀모델 LinearRegression, Ridge, Lasso를** 사용하여, 비교 분석한다.

```python
from pandas.io.xml import preprocess_data
X_train, X_test, y_train, y_test = train_test_split(X_features_ohe, y_target_log, test_size = 0.3, random_state = 0)

def get_model_predict(model,X_train, X_test, y_train, y_test, is_expm1 = False): # 지수 변환
  model.fit(X_train, y_train)
  pred = model.predict(X_test)
  if is_expm1: # 지수변환 요청
    y_test = np.expm1(y_test)
    pred = np.expm1(pred)
  print('###',model.__class__.__name__,'###')
  evaluate_regr(y_test, pred)


# model 별로 평가 수행
lr_reg = LinearRegression()
ridge_reg = Ridge(alpha=10)
lasso_reg = Lasso(alpha=0.01)

for model in [lr_reg, ridge_reg, lasso_reg]:
    get_model_predict(model,X_train, X_test, y_train, y_test,is_expm1=True)
```



![img](https://blog.kakaocdn.net/dn/RMKkU/btsr5JXxnuk/wDq68JDcO6aByvIXSuBfzK/img.png)



원핫 인코딩 후 예측 성능이 많이 향상됨을 확인할 수 있다.

```python
coef = pd.Series(lr_reg.coef_ , index=X_features_ohe.columns)
coef_sort = coef.sort_values(ascending=False)[:20]
sns.barplot(x=coef_sort.values , y=coef_sort.index)
```



![img](https://blog.kakaocdn.net/dn/kZRwA/btsrZyW1VRl/Jl9niie4Kthb0LYdP3vcSK/img.png)



year 관련 피쳐들의 회귀계수 영향도가 여전히 높지만, 다른 피처들의 영향도가 달라졌다.

 

마지막으로, 회귀트리를 이용해서 성능을 평가해 보겠다.

- **회귀 트리 이용한 예측 RandomForest, GBM, XGBoost, LightGBM**

```python
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from xgboost import XGBRegressor
from lightgbm import LGBMRegressor

# 랜덤 포레스트, GBM, XGBoost, LightGBM model 별로 평가 수행
rf_reg = RandomForestRegressor(n_estimators=500)
gbm_reg = GradientBoostingRegressor(n_estimators=500)
xgb_reg = XGBRegressor(n_estimators=500)
lgbm_reg = LGBMRegressor(n_estimators=500)

for model in [rf_reg, gbm_reg, xgb_reg, lgbm_reg]:
    # XGBoost의 경우 DataFrame이 입력 될 경우 버전에 따라 오류 발생 가능. ndarray로 변환.
    get_model_predict(model,X_train.values, X_test.values, y_train.values, y_test.values,is_expm1=True)
```



![img](https://blog.kakaocdn.net/dn/BaVl2/btsrTO7KfU4/chVBa3VSsjpZqnToQ1whvK/img.png)



선형 회귀 모델보다 회귀 트리를 통한 성능 예측이 더 나은 성능을 보였다.

------

예측 결과는 데이터 세트에 따라서 달라질 수 있다.