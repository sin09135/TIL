# Regression Analysis

> 회기분석 : 과거의 결과값을 기준으로 미래의 결과값을 예측하는 방법

- **회기식 : y ~ ax + b**에서 **최소 제곱법(LSM), 경사하강법(GDM)**으로 **회귀계수**를 계산
- **y : 종속변수, x : 독립변수** > **x의 값에 따라 y값이 결정된다는 의미**
- **a,b : 모수(Parameter)**

머신러닝 : 에러, 통계 : 설명력에 집중하여  회기분석을 설명함

### 최소제곱법 , 경사하강법 구조

: 미분해서 에러값을 최소화 시키는 방법(3차원에서 동작하게됨)

![](/Users/kimsinwoo/Downloads/gradient descent.png)

![](/Users/kimsinwoo/Downloads/1*EPCzO70fMR7Z2l-6TJB8wA.jpg)

- SST = SSR + SSE
  - SST : y의 전체 변동(분산)
  - SSR : 회귀직선(x)으로 설명되는 변동
  - SSE : 회귀직선으로 설명 불가능한 변동(Error)



### 결정계수(Mean Squared Error)

- R Squares(0~1) : 1에 가까울수록 회귀식의 설명력이 높음

- R Squares = SSR/SST or 1 - (SSE/SST)

- MSE , R squares 와 trade-off 관계임

  

### 회귀분석

- 단일 회귀 분석(독립변수 1개)

  - 상관계수

    url = 'https://raw.githubusercontent.com/rusita-ai/pyData/master/Galton.txt'

    ```python
    from scipy import stats
    stats.pearsonr(DFS.Father, DFS.Height)[0]
    ```

  - 회귀선

    ```
    import matplotlib.pyplot as plt
    import seaborn as sns
    
    plt.figure(figsize = (7, 5))
    sns.regplot(x = DFS.Father,
                y = DFS.Height,
                line_kws = {'color':'red'},
                scatter_kws = {'edgecolor' : 'white'})
    plt.show()
    ```

    ![](/Users/kimsinwoo/Downloads/Unknown-2.png)

- **다중 회귀 분석**(독립변수 2개 이상)
  
  - Load Data
  
  ```python
  import seaborn as sns
  DF2 = sns.load_dataset('iris') # 꽃 데이터
  
  DF2.info()
  ```
  
  - 상관계수
  
  ```
  DF2.corr()
  ```
  
  - 시각화
  
  ```
  import matplotlib.pyplot as plt
  import seaborn as sns
  
  sns.pairplot(hue = 'species', data = DF2)
  plt.show()
  ```
  
  - Modeling
  
  ```python
  import statsmodels.formula.api as smf
  
  Model = smf.ols(formula = 'sepal_length ~ sepal_width + petal_length + petal_width',data = DF2)
  
  Model_mr = Model.fit()
  ```
  
  - Modeling Summary
  
  ```python
  Model_mr.summary(alpha = 0.05)
  ```
  
  ![](/Users/kimsinwoo/Downloads/다중회귀분석.png)
  
  - 다중공선성(Multicollinearity)
  
    - 공성성(Colinearity) : 독립변수가 다른 독립변수로 잘 예측되는 경우 또는 서로 상관이 높은 경우
    - 다중공선성 : 독립변수가 다른 여러 개의 독립변수들로 잘 예측되는 경우
  
    1) 독립변수 확인
  
    ```python
    Model.exog_names
    ```
  
    2. 다중공선성 진단
       	- 분산 팽창 계수(VIF) : 보통 10보다 크면 다중공선성이 있다고 판단
  
    ```python
    variance_inflation_factor(Model.exog, 1) #sepal_width
    variance_inflation_factor(Model.exog, 2) #petal_length
    variance_inflation_factor(Model.exog, 3) #petal_width
    
    DF2.corr() #상관계수 확인
    ```
  
    3. 다중공선성 해결
  
       - VIF 가 큰 독립변수 제거 후 모델링
  
       ```python
       Model_VIF = smf.ols(formula = 'sepal_length ~ sepal_width + petal_length',data = DF2).fit()
       ```
  
       ```python
       Model_VIF.summary()
       ```
  
       



