# Index Alignment

- "Index alignment"은 인덱스를 기준으로 서로 다른 시리즈나 데이터프레임 간의 연산을 수행할 때, 인덱스가 일치하는 부분끼리 자동으로 정렬되어 연산이 이루어지는 특성이다.

데이터 분석과 관련된 맥락에서 중요한 개념 중 하나로판다스와 같은 라이브러리에서 데이터를 다룰 때 발생하는 중요한 특징 중 하나이다.



데이터프레임 예시를 통해, 개념을 이해해보자.



- 국가별 인구 데이터 프레임 생성

```python
import pandas as pd

# 국가별 인구 데이터프레임
population_data = {'Country': ['USA', 'China', 'India', 'Brazil'],
                   'Population': [331002651, 1439323776, 1380004385, 212559417]}
population_df = pd.DataFrame(population_data)
population_df = population_df.set_index('Country')
```



- 국가별 GDP 데이터프레임 생성

```python
# 국가별 GDP 데이터프레임
gdp_data = {'Country': ['China', 'USA', 'Japan', 'Germany'],
            'GDP': [147.5, 21.43, 5.08, 3.86]}
gdp_df = pd.DataFrame(gdp_data)
gdp_df = gdp_df.set_index('Country')
```

