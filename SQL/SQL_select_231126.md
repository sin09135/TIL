# 20231126_SQL 복습과제
### select문법 - 2

### 데이터 불러오기
```sql
-- 실행 전 market, buy 데이터 불러오기
SELECT * FROM member;
SELECT * FROM buy;
```



### 1. select 사용하는 서브쿼리

```sql
-- 에이핑크의 키 이상인 경우의 멤버 추출 
SELECT mem_id,mem_name, height FROM member WHERE height > 164;

-- 에이핑크 키보다 큰 멤버들만 추출
SELECT mem_id, mem_name, height FROM member WHERE height > (SELECT height FROM member WHERE mem_name ='에이핑크');

-- 서울 addr을 가진 소녀시대의 아이디와 네임을 서브쿼리로 출력
SELECT mem_id, mem_name, addr FROM member WHERE addr = (SELECT addr FROM member WHERE mem_name ='소녀시대');

-- 소녀시대의 phone1과 동일한 멤버의 아이디와 네임을 서브쿼리로 출력
SELECT mem_id, mem_name, phone1, phone2 FROM member WHERE phone1 = (SELECT phone1 FROM member WHERE mem_name = '소녀시대');

-- 두 개의 테이블로 구조가 된 서브쿼리
SELECT mem_id, mem_name, phone1 FROM member WHERE phone1 = (SELECT phone1 FROM member WHERE mem_name = '소녀시대');

```



### 2. SELECT의 여러 문법

```sql
-- ORDER BY 정렬
SELECT * FROM member ORDER BY debut_date; -- 날짜순으로 정렬
SELECT * FROM member ORDER BY debut_date DESC; -- 내림차순 정렬

-- ORDER BY에서 여러 컬럼으로 정렬
SELECT * FROM member WHERE addr='서울' ORDER BY debut_date DESC, height ASC;

-- LIMIT 출력 개수 제한
SELECT * FROM member LIMIT 3; -- 상위 3개만 출력
SELECT mem_id, mem_name FROM member WHERE addr = '서울' ORDER BY debut_date DESC LIMIT 1; -- 서울에서 가장 최근 데뷔한 멤버 1명만 출력

-- DISTINCT 중복 제거
SELECT DISTINCT addr FROM member; -- 중복 제거된 주소만 출력

-- GROUP BY 그룹 별 통계치
SELECT mem_id, SUM(amount), AVG(price), COUNT(prod_name) FROM buy GROUP BY mem_id;

-- 통계치를 사용하지 않고 컬럼 출력
SELECT mem_id, amount, price, prod_name FROM buy GROUP BY mem_id;

-- MAX, MIN으로 그룹별 통계치
SELECT MAX(debut_date) FROM member; -- 최근 데뷔한 날짜
SELECT MIN(debut_date) FROM member; -- 가장 오래된 데뷔 날짜
SELECT COUNT(DISTINCT addr) FROM member; -- 중복 제거된 주소의 개수

-- 서로 다이렉트로 곱해 새로운 컬럼 생성
SELECT mem_id, SUM(price*amount) FROM buy GROUP BY mem_id;

```

