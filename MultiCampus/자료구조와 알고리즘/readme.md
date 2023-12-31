# 자료구조 및 알고리즘 특강 개요

**자료구조 및 알고리즘 기본**

- **일정**
  - 1일차 : 이론만
  - 2일차 : 이론 + 엄청 빠른 코딩(1~2분)



- 미니 특강
  - 자격증 관련 --> 9/4
  - 현업 알고리즘 테스트 문제 --> 9/4,5
  - 취업 전략 --> 개인 의견 --> 9/5



- IT 전문가 : 도메인 지식 + 프로그래밍 실력 + 4차 산업(데이터, AI, 클라우드)
  - 모든 IT 전문가 필수 역략? **코딩**
  - A 기업 빅데이터 신입직원 교육 1개월
  - 코딩이 어렵다 --> 오래 걸림 --> 누구던 어렵다 --> 5~10 년(전문가)
  - 데이터도 잘하고 프로그래밍도 잘하면 --> 술술 풀림 2 ~ 5년 예상 --> 연봉 up



- 코딩을 잘하고 싶다면?

  - 파이썬 문법책 공부 + **자료구조 및 알고리즘**

    



## 자료구조

### 선형 자료구조

- **리스트**

  - **선형 리스트(= 순차 리스트) : 배열**  > **시간 순서로 발생/보관되는 데이터가 적합함**

    ex) 신문기사데이터(일자별) , 소설의 연대별 기록

    - 장점 . 공간 절약 ( 비용 절약 ) , 전체 접근 빠름

    - 단점. 삽입/삭제 시 오버헤드

      

  - **단순 연결 리스트** : 노드(Data + Link)

    - 논리적으로 붙어있고, 물리적으로는 멀리 떨어져 있음

    - 장점. 삽입/삭제 시 오버헤드 X

    - 단점. 공간 더 필요(비용 올라감), 전체 접근 느림

      

      - Head
      - 마지막 노드 파악 방법 ( 링크 = None)

      

  - **원형 연결 리스트** : 꼬리가 다시 머

    - 마지막노드 (링크 == Head)


  

- **스택** : 한쪽이 막힌 파이프

  - Push, pop, top

  - overflow 일어날 수 있으므로 스택 full 인지 확인해야 함

    - isStackFull() 확인해야 함. Top == SIZE -1, 
    - isStackEmpty() : top == -1
    
    
    
    

- **큐**: 양쪽이 뚫린 파이프(입구와 출구가 다름 > 먼저 들어가면 먼저 나옴) 

  enQueue, deQueue, front, rear ..... isQueueFull(): rear = SIZE - 1 ---> 3가지
  
  - 순차 큐( = 일반 큐) 
  - 원형 큐( = 환형 큐) 
    - 텅 비었다 front == rear
    - 꽉참 rear + 1 == front



### 비선형 자료 구조(시험용)

- 트리
  - 이진트리 : root, 차수, 왼쪽서브, 오른쪽 서브, TreeNode(left, data, right)
- 그래프
  - 인접행렬( = 이차원 배열) --> 도로망, 길찾기





## 알고리즘

### 정렬

차례대로 정렬

- 오름차순 정렬
- 내림차순 정렬

( 같은 개념임, 부등호만 바꾸면 됨



- 선택 정렬(Selection)



- (삽입 정렬)
- (버블 정렬)
- (퀵 정렬)



### 검색

- 순차 검색
- 이진 검색



### 재귀 : 다양한 사례



### 미니특강 1 (자격증 관련)

___

- 권장 : **정보 처리 기사** (비전공자일 때 기본적인 자격증 > 운전 면허증 정도 수준, 법적으로 필요(우대), 컴공과 4년의 요약)

- 전자계산기조직응용(전공자일 때)

- ADSP, SQLD, 빅데이터 자격증 >> 결론 : 몰라요!
  -  내가 취업할 회사에서 필요? 취업 공고!



- 정보처리기사 : 필기라도 합격했으면 그거라도 적어라

  - 만약에 정처기 없는데, 질문 들어오면 ~ 일정이 안 맞아서 못 땄다.. 다만 준비는 했다.
  - 필기라도 통과하면 기재하는게 좋음
  




### 미니특강 2(시험)

___





### 미니특강 3 ( 취업 전략)

___

- 결론 : 대기업에 취업 ~ (복지/급여)
- 문제 : 신입 직원 채용 계획이 거의 없음(2년동안 투자 개념) , 경력직은 많이 뽑음



- 1순위 : 대기업 (경력직 많이 뽑아서 문이 좁음-- 3년차 정도를 선호함)
- 2순위 : 중소/ 중견 : 좋은 경력(3년) >> 이직(대기업)
  - A 기업 : 50% 넘는 IT 직원이 전부 다 경력직 ( 이전 기업 > 중소기업 )
    - 이직 과정 : 지원 > 이력서(경력) 제출 > 인터뷰 > 출근



1순위는 대기업이지만, 대기업 떨어졌다고 해서, 1년 2년 재수가 아니라,

 중소/ 중견 들어가서 경력 잘 쌓으면 대기업 이직이 가능함. 항상 다른 곳 갈 수 있는 대비가 되어야 함.

준비가 된 사람일 수록 , 더 오래 잘 살아남음



- 경력 3년 : 1 + 1 + 1 : X 안됨 > 한군데에서 가는게 좋음( 경력 꼬이면 힘듦 > 처음에 경력 잘 쌓는 것이 좋음)
  - 회사를 참고 다녀야 되나? 아님. 그만둬야 함.
  - 차라리 그냥 1,2 달 하고 그만두고, clear 하게 다시 시작할 것.



- 회사 고르는 기준
  - 집이 먼 사람 --> 회사는 천국이 아니다.
  - 비전 ( 나의 비전)  : 업무가 비전이 있는지(3~5년정도 했을 때, 다른 곳에서 날 찾을 것 인지)
  - 사람 자주 뽑는 회사. 채용 사이트를 자주 보기(지난 것도 보기)





### 정렬

정렬 방법

- 배열의 첫 번째 값을 가장 작은 값으로 지정
- 나머지와 비교하여 값을 유지하거나 바꿈
