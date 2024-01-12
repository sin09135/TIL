### 파이썬 머신러닝 완벽가이드 복습

- 교차 검증, 하이퍼 파라미터

  - 교차 검증

    - kfold 교차 검증

    - Stratified K 폴드 : 불균형한 분포를 가진 레이블 데이터 집합을 위한, 전체 데이터의 분포대로 검증데이터셋 구성

      - ex) 대출사기:1이 90% 이상, 0이 10% 처럼 치우쳐진 분포
      - 일반적으로 분류모델에선 stratified k fold 이용

    - cross_val_score()

      - 교차검증을 간편하게 하는 API
      - 기존 ) 1. 폴트 세트 설정, 2. for 반복문으로 학습 및 테스트 데이터 이넥스 추출, 3. 반복 예측, 성능 반환

    - GridSearch - 교차검증 & 최적 하이퍼파라미터 튜닝 한번에

      - cross-validation 을 위한 학습/테스트 데이터를 자동 분할한 뒤에 하이퍼 파라미터에 기술된 모든 파라미터를 순차적으로 적용하여, 최적의 하이퍼 파라미터를 찾음

      ```python
      # 학습/평가 데이터셋 분할
      
      # 모델 생성
      dtree = DecisionTreeClassifier()
      
      # 하이퍼 파라미터 지정
      parameters = {'max_depth' : [1,2,3],
      						 'min_samples_split' : [2,3]}
      
      grid_dtree = GridSearch(dtree, param_grid = parameters, cv = 3, refit = True)
      
      # 학습데이터로 하이퍼 파라미터 순차 학습
      grid_dtree.fit(X_train, Y_train)
      
      # grid_search 결과 추출 Dataframe으로 반환
      scores_df = pd.DataFrame(grid_dtree.cv_results_)
      scores_df[['params','mean_test_score','rank_test_score',
      					 'split0_test_score','split1_test_score','split2_test_score']]
      
      # 최적의 하이퍼 파라미터
      print(grid_dtree.best_params_)
      print(grid_dtree.vest_score_)
      ```

      - 주요 파라미터
        - estimator : classifier, regressor, pipeline 가능
        - param_grid: key + 리스트 값을 가지는 딕셔너리
        - scoring : 예측 성능 평가 방법 지정(’accuracy’)
        - cv : 교차 검증을 위해 분할되는 학습/테스트 개수 지정
        - refit : True로 생성 시, 최적 파라미터를 재학습시킴

- 데이터 인코딩

  - 레이블 인코딩

    - 문자열 값을 숫자형 카테고리 값으로 변환
    - 선형회귀 ML 모델에는 적용 x > 숫자 크기를 중요성으로 인식
    - 트리계열 알고리즘 > 레이블 인코딩 가능

    ```python
    items = ['TV','냉장고','세탁기']
    encoder = LabelEncoder()
    encoder.fit(items)
    labels = encoder.transform(items)
    print('인코딩 변환값' : labels)
    ```

  - 원핫 인코딩

    - 피처 값의 유형에 따라, 새로운 피처를 추가해 고유 값에 해당하는 컬럼에만 1 부여

    ```python
    pd.get_dummies(df)
    ```

- 피쳐 스케일링(표준화, 정규화)

  - 피처 스케일링 : 서로 다른 변수의 값 범위를 일정한 수준으로 맞추는 작업

    - 표준화(Standardization)

      - 데이터 피처 각각이 평균이 0, 분산 1 인 가우시안 정규분포로 만듦
      - StandardScaler

      ```python
      from sklearn.preprocessing import StandardScaler
      
      scaler = StandardScaler()
      scaler.fit(iris_df)
      iris_scaled = scaler.transform(iris_df)
      ```

    - 정규화(Normalization)

      - 서로 다른 피처의 크기를 통일하기 위해, 크기 변환
      - MinMaxScaler

      ```python
      from sklearn.preprocessing import MinMaxScaler
      
      scalr = MinMaxScaler()
      scaler.fit(ifis_df) # fit 기준 정보 설정(데이터 최댓값, 최솟값 등)
      iris_scaled = scaler.transform(iris_df)
      ```

    - 유의할 점

      - fit()은 데이터 변환을 위한 기본 정보 설정을 적용한다.(데이터셋의 최댓값, 최솟값 등)
      - transform()은 해당 기본 정보를 적용하여 스케일링 한다.
      - 학습 데이터로 fit()이 적용된 스케일링 기준 정보를 그대로 테스트 데이터에 적용해야 한다.(테스트 테이터에서 다시 fit()하여 새로 세팅하면, 기준 정보가 달라지게 된다.)
      - 방법1. 가능하다면 전체 일괄 스케일링 변환 적용 후 분리
      - 방법2. 방법1이 불가한 경우, 테스트 변환 시에는 학습데이터로 이미 fit된 scaler를 이용해서 transform으로 변환

      ```python
      from sklearn.preprocessing import MinMaxScaler
      
      scalr = MinMaxScaler()
      scaler.fit(train_array) # fit 기준 정보 설정(데이터 최댓값, 최솟값 등)
      train_scaled = scaler.transform(train_array)
      
      # test
      test_scaled = scaler.transform(test_array) # 학습데이터로 fit 된 scaler 이용
      ```

