## SQLD 실전 모의고사 150제

1. 파생속성: 다른 속성을 이용하여 계산된 속성으로 자신의 고유값을 갖지 않고, 파생, 유추 되어 재산정될 수 있는 속성

2. 학생이라는 엔터티가 잇을 떄 학점이라는 속성 값의 범위, 0~4 사이의 실수값, 20자리 이내의 문자열 > **도메인**

3. 도메인 : 속성에 대한 값의 범위 등 제약사항 기술

4. 관계를 정의할 때 주요하게 체크해야 할 사항

   1. 업무기술서
   2. 장표에 관계연결을 가능하게 하는 **동사**(명사 아님)

5. **비 식별자 관계** : 부모 엔터티로부터 속성을 받았지만, 자식 엔터티의 주식별자로 사용하지 않고, 일반적인 속성으로만 사용

6. **데이터 모델링의 3요소**

   - Things, Attributes, Relationship

7. **데이터 모델링의 3가지 관점**

   - **데이터** : 업무가 어떤 데이터와 **관련**이 있는지, **관계**는 무엇인지 모델링
   - **프로세스** : 업무가 **실제로 하고 있는 일**은 무엇인지, **무엇을 해야하는지** 모델링
   - **데이터와 프로세스 상관 관점** : 업무가 처리하는 **방법**에 따라 어떤 영향을 받는지

8. 실제 데이터 베이스 구축 시 참고되는 모델은 **물리적 데이터 모델**

9. **논리 모델의 외래키**는 물리 모델에서 반드시 구현되지 않는 **선택사항**이다.

10. **엔터티 - 인스턴스 - 속성 - 속성값**

    - 한개의 엔터티는 두개 이상의 인스턴스의 집합
    - 하나의 속성은 하나의 속성값을 가짐
      - 한개 이상(두개부터) 정규화 필요
    - 한개의 엔터티는 두개 이상의 속성을 가짐
    - 엔터티 하나의 인스턴스는 다른 엔터티의 인스턴스 간 관계인 Pairing 을 가짐

11. **분산 데이터 베이스**

    - 개발 비용, 오류의 잠재성, 처리 비용, 관리의 복잡성 증대
    - 신뢰성, 가용성, 빠른 응답속도, 통신 비용 절감, 각 지역의 사용자 요구 수용 증대

12. **Hash Join**

    - 조인 컬럼의 인덱스가 존재하지 않을 경우에도 사용 가능
    - '=' 동등조건에서만 사용 가능
    - 해시테이블을 메모리에 사용할 수 있음
    - 해시테이블을 저장할 때 메모리에 적재할 수 있는 영역의 크기보다 커지면 **임시영역(디스크)**에 저장
    - 선행테이블(Build Input), 후행테이블(Prove Input)

13. **속성의 종류**

    - 기본 속성
      - 파생속성을 제외한 모든 속성
      - 업무로부터 추출한 모든 속성
    - 설계 속성
      - 업무를 규칙화하기 위해 속성을 새로 만들거나 변형하여 정의하는 속성
      - 단일한 식별자를 부여하기 위해 모델 상에서 새로 정의하는 속성

    - 파생 속성
      - 다른 속성에 영향을 받아 발생하는 속성
      - 계산된 값



14. **정규화**

    | 정규화 종류 | 내용                                                         |
    | ----------- | ------------------------------------------------------------ |
    | 제 1 정규화 | 모든 속성은 중복된 값을 가지지 않음                          |
    | 제 2 정규화 | 부분함수종속성 제거: 식별자의 부분 속성에 대해서만 종속관계인 부분 함수 종속을 제거 |
    | 제 3 정규화 | 이행함수종속성 제거 : 식별자를 제외한 일반족성 간 종속 제거  |
    | BCNF        | 다수의 주 식별자 분리                                        |
    | 반정규화    | 중복 허용                                                    |



15. **반정규화**

    - 모든 속성을 참조하기를 원함 > 관계를 중복하는 반정규화 

    - **중복관계 추가** : 데이터 무결성을 깨뜨릴 위험을 갖지 않고서도 데이터 처리의 성능을 향상시킬 수 있음

    - 모델 전체가 관계로 연결, 관계가 서로 먼 친척 간에 조인 관계가 빈번하여 성능저하가 예상 >  관계의 반정규화를 통해 성능향상을 도모할 필요 O

      



16. **설계 단계**

    1. 데이터 모델 성능을 고려하는 절차와 방법

       - 이력 모델의 조정, 기본키/외래키 조정, 슈퍼/서브 타입 조정, 용량 산정 , 트랜잭션 유형 파악
       - 성능을 고려한 데이터 모델링의 첫단계는 정규화를 적용한 데이터 모델링을 만드는 것

    2. 물리적 변환 방법

       - All In One
       - 슈퍼타입/서브타입
       - 1:1 관계로 해체

       

17. **분산 데이터 베이스의 투명성**

    - 분할 투명성 
    - 위치 투명성 : 데이터의 저장 장소 명시가 불필요, 위치정보가 System Catalog에 유지되어야 함
    - 지역 사상 투명성 : 지역 DBMS와 물리적 DB 사이의 Mapping 보장
    - 중복 투명성 
    - 병행 투명성
    - 장애 투명성
    - 병렬투명성(X)



18. **논리적 데이터 모델링**
    - 데이터 모델링이 최종적으로 완료된 상태
    - 물리적인 스키마 설계를 하기 전 단계



19. **엔터티의 공통점**
    - 개념, 사건 , 사람 등 명사
    - 비즈니스 프로세스에서 관리되어야 하는 정보
    - 저장이 필요한 어떤 것
    - **변별 가능한 객체(X)**



20. **ERD 작성 순서**
    - 그리기 > 배치 > 관계 설정 > 관계명 기술 > 참여도 기술 > 필수여부 기술



21. **데이터 유형**
    - VARCHAR : **가변 길이 문자형**



22. **입력 규칙**
    - 테이블명, 컬럼명 > 반드시 문자로 시작



23. **TCL : Commit , Rollback의 장점**
    - 데이터 **무결성** 보장
    - **영구적인 변경을 하기 전**에 변경사항 확인
    - 논리적으로 연관된 작업을 그룹핑하여 처리 가능



24. **와일드 카드**
    - '_' : 아무거나
    - 'A'%' :  A로 시작



25. **집계함수**
    - Count(*) : Null 값 포함 계산



26. **쿼리**
    - From 절에서 테이블에 대함 ALIAS 를 사용했을 때 SELECT 절에서는 반드시 테이블 명이 아닌 ALIAS 명을 사용해야 한다.
    - N개의 여러 테이블에서 원하는 데이터를 조회하기 위해서는 N-1개의 조인 조건이 필요



27. **Join 종류**
    - EQUI JOIN : 조인 컬럼이 1:1 로 맵핑되면 사용 가능, 기본키/외래키 관계에 의해서만 성립되는 것은 아님
    - NON EQUI Join : 등가 조건이 성립되지 않은 테이블에 Join
    - SELF JOIN : 하나의 테이블을 논리적으로 분리, EQUI JOIN 이용
      - 하나의 테이블에서 두개의 컬럼이 연관 관계를 가지고 잇는 경우에 사용



28. **서브 쿼리**
    - Select : 스칼라 서브쿼리(한행과 한 컬럼만 반환)
    - From : Inline View(메인쿼리보다 먼저 수행, 절차성을 확보)
    - 서브쿼리 종류
      - 단일 행 서브쿼리 : 반드시 한 행만 조회( = , >, < , >=, <=)
      - 다중 행 서브쿼리 : 여러개의 행이 조회(In, any, all, Exists)
        - In : 하나만 동일하면 참
        - All : 메인쿼리와 서브쿼리가 모두 동일하면 참
        - Any : 메인 쿼리와 서브쿼리가 하나 이상 동일하면 참
        - Exists : 서브쿼리의 결과가 하나라도 존재하면 참



29. **그룹함수**

    - Rollup(부서?) : 전체 합계 및 부서별 합계 조회
    - Grouping : rollup, cube, grouping sets에서 생성되는 합계값을 구분하기 위해서 만들어진 함수
      - 소계, 합계 등이 계산되면 Grouping 함수는 1을 반환하고 그렇지 않으면 0을 반환 > 합계값 식별
    - Grouping sets : 컬럼의 순서와 상관없이 다양한 소계를 만듦 > 개별적으로 모두 다 처리

    - Cube : 결합 가능한 모든 집계를 계산 > 조합할 수 있는 경우의 수가 모두 조합



30. **그룹함수 구분**
    - 계층적 분류를 포함하고 있는 데이터 집계에 적합한 GROUP 함수 두가지
      - Rollup : 
      - Cube :  다차원적 집계 시 사용



31. **윈도우 함수**
    - Rank : 중복된 값에 대해 동일한 순위 부여
    - Dense_Rank : 중복된 순위 다음에는 바로 다음 순위를 부여
    - Row_Number : 고유한 순위를 부여(같은 등수가 없음)
    - Cumm_Rank(미존재)



32. **절차형 SQL**
    - Procedure, trigger, user Defined Function(o)
    - Built-In Function



33. **옵티마이저 : 질의 실행계획**
    - 규칙 기반
      - 전체 스캔 : 제일 낮은 우선순위
    - 비용 기반
      - 인덱스 스캔보다 전체 스캔이 낫다고 판단하면 그렇게 함
    - 인덱스는 내림차순으로 정렬된다.
    - 비용기반 측면에서 전체 테이블 스캔이 나을 수도 있음
    - 규칙기반 옵티마이저에서는 적절한 인덱스가 존재하면 최대한 인덱스를 사용하려고 함
    - 인덱스 범위 스캔은 결과 건수만큼 반환 > 결과가 없으면 한건도 반환되지 않음



34. **질의 실행계획**
    - 실행계획이 다르다고 결과는 달라지지 않음, 성능은 달라짐
    - 최적화 정보 : 실행단계별 예상 비용



35. **SQL 처리 흐름도**
    - 실행 계획 시각화
    - 인덱스 스캔 , 전체 테이블 스캔 등의 엑세스 기법 표현 가능
    - 성능적인 측면도 표현 가능



36. **옵티마이저 조인**

- From 절에 아무리 많은 테이블이 나열되더라도 항상 2개씩 조인

**NL 조인(소규모에 유리)**

- 선행 테이블(외부 테이블)과 후행 테이블(내부 테이블) 조인
- 선행 테이블의 조건을 만족하는 행 추출 > 후행 테이블 읽으면서 조인
  - 이 과정을 선행테이블의 조건을 만족하는 행 수만큼 반복
- 결과 행의 수가 적은 테이블을 조인 순서상 선행테이블로 두는 것이 유리함



**Sort Merge 조인**

- 조인 컬럼 기준으로 데이터를 정렬한 후 조인 수행
- 정렬할 데이터가 많은 경우에는 성능 저하
- **Non equi 조인 가능**



**Hash join**

- 조인 컬럼 기준으로 해쉬 함수를 수행하여 동일한 해쉬 값을 갖는 경우에만 실제 값을 비교하여 조인 수행
- 데이터가 많은 경우 유리
- 해시 테이블을 메모리에 생성해야 함
  - 결과 행의 수가 적은 테이블을 선행테이블(Build input,)로 사용하는 것이 좋음
  - Build input, Probe input



37. Select 처리 순서
    - From > where > group by > select > order by
