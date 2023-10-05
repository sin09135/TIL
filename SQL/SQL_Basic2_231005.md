## SQL 기초 문법

### 0. CREATE(테이블 생성)

- 문법

```sql
CREATE TABLE 테이블명(
  컬럼명 데이터타입 속성
  PRIMARY KEY(컬럼명)
  FOREIGN KEY(컬럼명) 외래키 조건 설정
);
```



- 예시

```sql
CREATE TABLE IF NOT EXISTS tasks (
	  task_id INT AUTO_INCREMENT
    , title VARCHAR(255) NOT NULL
    , start_date DATE 
    , due_date DATE 
    , priority TINYINT NOT NULL DEFAULT 3 
    , DESCRIPTION TEXT 
    , PRIMARY KEY (task_id)
);
```

tasks 라는 테이블이 없으면 테이블을 생성한는 명령문이다.

다음과 같은 형식으로 테이블을 만든다.

| 컬럼명      | 데이터타입                         | 속성                                          |
| ----------- | ---------------------------------- | --------------------------------------------- |
| task_id     | INT - 정수형                       | AUTO_INCREMENT                                |
| title       | VARCHAR(255) - 최대 255개의 문자열 | NOT NULL                                      |
| start_date  | DATE                               |                                               |
| due_date    | DATE                               |                                               |
| Priority    | TINYINT - 우선순위 숫자 저장       | NOT NULL DEFAULT 3 - 결측값 없음, 기본값 지정 |
| DESCRIPTION | TEXT                               |                                               |
|             |                                    |                                               |

기본기(task_id)



![](/Users/kimsinwoo/Library/Mobile Documents/com~apple~Preview/Documents/insert.png)

task 테이블이 잘 생성되었다.



### 1. INSERT (행 추가)

- 문법

```sql
INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3)
VALUES (값1, 값2, 값3)
;
```



- 예시

```sql
INSERT INTO tasks(title, priority)
VALUES ('Learn MySql', 1);
```

![](/Users/kimsinwoo/Downloads/insert2.png)

task 테이블에 행이 추가된 것을 확인할 수 있다.



### 2. DELETE(행 삭제)

- 문법

```sql
DELETE FROM 테이블명
WHERE 조건
```

- 예시

```sql
DELETE FROM tasks WHERE task_id = 1;
```



### 3. UPDATE( 데이터 갱신)

- 문법

```
```



```
UPDATE tasks
SET priority = 10 
WHERE task_id = 5;
```

