#  SQL 기본

## 1. CREATE

- 엔터티 == 테이블

- 행 하나 == row



```sql
CREATE 테이블명(

	컬럼1 데이터타입 NOT NULL

	컬럼2 데이터타입 DEFAULT '기본값'

);
```

CONSTRAINT PK명 PRIMARY KEY (PK컬럼명);

COMMENT ON TABLE 테이블명 IS '나의테이블'

COMMENT ON COLUMN 테이블명.컬럼1 IS '코멘트'



#### 예제) 넷플릭스 테이블 만들기

- **테이블 생성**

  CREATE TABLE NETFILX(

​	VIDEO_NAME VARCHAR2(50),

​	CATEGORY CARCHAR(30),

​	VIEW_CNT  NUMBER(7),

​	REG_DATE DATE

)

-  **테이블 불러오기**

  SELECT * FROM NETFLIX



## 2. ALTER

- ADD COLUMNS 컬럼 추가
- DROP COLUMNS 컬럼 삭제
- MODIFY COLUMNS 컬럼 추가

```sql
ALTER TABLE 테이블명 명령어(ADD,DROP,MODIFY 등) 컬럼 ;
```

- 컬럼 추가

ALTER TABLE NETFLIX ADD (CAST_MEMBER VARCHAR2(20));

- 컬럼 변경

ALTER TABLE NETFLIX MODIFY (CAST_MEMBER VARCHAR2(50));

- 테이블 명 변경

ALTER TABLE NETFLIX MODIFY (CAST_MEMBER VARCHAR2(50));

- 테이블 삭제

ALTER TABLE NETFLIX MODIFY (CAST_MEMBER);



## 3. DROP vs TRUNCATE

- drop 컬럼이 모두 삭제(전체 테이블 삭제)
- tuncate 데이터만 삭제



예시) 테스트 환경 준비

```
CREATE TABLE CODELION(  # 테이블 생성
	COL1 VARCHAR(3),
	COL2 VARCHAR(3)
);

SELECT * FROM CODELION; # 테이블 잘 생성되었는지 확인

INSERT INTO CODELION VALUES ('AAA','BBB');
INSERT INTO CODELION VALUES ('CCC','DDD');

COMMIT; # insert는 commit 해줘야함
```

```
DROP TABLE CODELION; # 전체가 사라짐
```

```
TRUNCATE TABLE CODELION; # 테이블(컬럼 포함)은 남아있고, 값만 삭제
```

## 4. INSERT

실습 전 오토커밋 삭제( 커밋, 롤백 가능해야 함)

- 전체 데이터 삽입

```
SELECT * FROM NETFLIX N ;
INSERT INTO NETFLIX VALUES('나의 아저씨','드라마',50,SYSDATE);

COMMIT; # 반영 완료(작업을 완벽하게 마무리 하겠다는 뜻)
```

Commit 안하면 화면에는 보여지지 않음

SYSDATE : 오늘 날짜



- 두개 컬럼만 데이터 입력

```
INSERT INTO NETFLIX (VIDEO_NAME, VIEW_CNT) VALUES('시그널',10);

ROLLBACK; # INSERT를 취소하겠다는 뜻
```



## 5. UPDATE

INSERT한 데이터를 업데이트 하는 작업

UPDATE 쿼리를 사용할 때 WHERE로 컬럼을 지정해주지 않으면, 전체 row에 적용되니 주의해야 함.

- 컬럼을 한개 이상변경

```
SELECT * FROM NETFLIX N ;

# IDEO_NAME = '나의 아저씨'인 row의 VIEW_CNT 값을 70으로 변경
UPDATE NETFLIX SET VIEW_CNT 70 WHERE VIDEO_NAME = '나의 아저씨;'

COMMIT; # 완벽하게 반영해야 함
```



- 컬럼을 두개 이상 변경

```
UPDATE NETFLIX SET CATEGORY = '드라마', REG_DATE = TO_DATE('20230901','YYYYMMDD') WHERE VIDEO_NAME = '시그널';

ROLLBACK; # 사라짐
```



## 6. DELETE

### DELETE 와 TRUCATE

| DELETE                                              | TRUNCATE                               |
| --------------------------------------------------- | -------------------------------------- |
| 원하는 데이터 삭제                                  | 테이블의 모든 데이터 삭제              |
| 롤백으로 복구 가능하다, 커밋수행해야 완벽 반영된다. | 한번 실행하면 되돌릴 수 없다.          |
|                                                     | 모든 데이터 삭제 시 DELETE 보다 빠르다 |

**DELETE FROM 테이블명 WHERE**

```
SELECT * FROM NETFLIX n ; # 뒤에 n 은 알리야스가 자동으로 생성된 것임

DELETE FROM NETFLIX n WHERE CATEGORY = '드라마' AND VIEW_CNT < 35;

COMMIT;
```



**DELETE FROM 테이블명 ;  = TRUNCATE와 같은 기능**