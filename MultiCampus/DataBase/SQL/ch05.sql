USE mydata;

SELECT COUNT(*) FROM dataset2;
SELECT * FROM dataset2;

-- a) DIVISION NAME 평균 평점 
SELECT 
	`DIVISION NAME`
    , AVG(RATING) AVG_RATE
FROM dataset2
GROUP BY 1
ORDER BY 2 DESC;

-- b) Department별 평균 평점 
SELECT 
	`DEPARTMENT NAME`
    , AVG(RATING) AVG_RATE
FROM dataset2
GROUP BY 1
ORDER BY 2 DESC;

-- Trend의 평점 3점 이하 리뷰 
SELECT * 
FROM dataset2
WHERE `department name` = 'trend'
	AND RATING <= 3
;

-- 구간을 그룹으로 나누어서 집계하는 방법
-- CASE WHEN 
SELECT 
	CASE WHEN AGE BETWEEN 0 AND 9 THEN '0009'
		WHEN AGE BETWEEN 10 AND 19 THEN '1019'
        WHEN AGE BETWEEN 20 AND 29 THEN '2029'
        WHEN AGE BETWEEN 30 AND 39 THEN '3039'
        WHEN AGE BETWEEN 40 AND 49 THEN '4049'
        WHEN AGE BETWEEN 50 AND 59 THEN '5059'
        WHEN AGE BETWEEN 50 AND 59 THEN '5059'
        WHEN AGE BETWEEN 60 AND 69 THEN '6069'
        WHEN AGE BETWEEN 70 AND 79 THEN '7079'
        WHEN AGE BETWEEN 80 AND 89 THEN '8089'
        WHEN AGE BETWEEN 90 AND 99 THEN '9099' END AGEBAND
	, AGE
FROM dataset2
WHERE `department name` = 'trend'
	AND rating <= 3
;

-- FLOOR 메서드 사용 
SELECT 
	FLOOR(AGE/10) * 10 AS AGEBAND 
    , AGE
FROM dataset2
WHERE `department name` = 'trend'
	AND rating <= 3
;

-- 결과 
SELECT 
	FLOOR(AGE/10) * 10 AS AGEBAND 
    , COUNT(*) CNT
FROM dataset2
WHERE `department name` = 'trend'
	AND rating <= 3
GROUP BY 1
ORDER BY 2 DESC
;

-- Department별 연령별 리뷰 수
SELECT 
	FLOOR(AGE/10) * 10 AS AGEBAND 
    , COUNT(*) CNT
FROM dataset2
WHERE `department name` = 'trend'
GROUP BY 1
ORDER BY 2 DESC;

-- 50대 3점 이하 Trend 리뷰를 살펴보기 
-- 리뷰 주 내용이 사이즈 불만
SELECT * 
FROM dataset2
WHERE `department name` = 'trend'
	AND rating <= 3
    AND AGE BETWEEN 50 AND 59 
LIMIT 10
;
	

-- p.134 
-- 평점이 낮은 상품의 주요 Complain 
-- Department Name, Clothing Name별 평균 평점 계산 
SELECT 
	`department name`
    , `clothing id`
    , AVG(rating) AS AVG_RATE
FROM dataset2
GROUP BY 1, 2
;

-- Department 내에서 평균 평점을 기준으로 순위를 매긴다. 
-- ROW_NUMBER() 

SELECT *
	, ROW_NUMBER() OVER(PARTITION BY `department name` ORDER BY AVG_RATE) RNK
FROM (
	SELECT 
		`department name`
		, `clothing id`
		, AVG(rating) AS AVG_RATE
	FROM dataset2
	GROUP BY 1, 2
) A 
;

-- 1~10위 데이터 조회 
-- 평균 평점이 낮은 데이터를 추출 하기 위해서 (상위 10개) 
SELECT * 
FROM (
	SELECT *
		, ROW_NUMBER() OVER(PARTITION BY `department name` ORDER BY AVG_RATE) RNK
	FROM (
		SELECT 
			`department name`
			, `clothing id`
			, AVG(rating) AS AVG_RATE
		FROM dataset2
		GROUP BY 1, 2
	) A 
) A
WHERE RNK <= 10
;

-- clothing ID만 추출한 뒤, 각 부서별 리뷰 텍스트를 추출
-- 임시 테이블 생성 
CREATE TEMPORARY TABLE stat AS
SELECT * 
FROM (
	SELECT *
		, ROW_NUMBER() OVER(PARTITION BY `department name` ORDER BY AVG_RATE) RNK
	FROM (
		SELECT 
			`department name`
			, `clothing id`
			, AVG(rating) AS AVG_RATE
		FROM dataset2
		GROUP BY 1, 2
	) A 
) A
WHERE RNK <= 10
;

SELECT * FROM stat;
-- 부서명 : Bottoms
-- Clothong ID 18, 588, 1039, 1058
SELECT * FROM dataset2;
SELECT
	`department name`
	, `clothing id`
	, `Review Text`
FROM dataset2
WHERE `clothing id` IN (SELECT `clothing id`
						FROM stat
						WHERE `department name` = 'bottoms')
ORDER BY `clothing id`
;

-- p.139 
-- 연령별 worst department 
-- 각 연령대별로 가장 낮은 점수를 준 Department를 구하고, 
-- 해당 Department의 할인 쿠폰을 발송한다. 
-- 연령별로 가장 낮은 점수를 준 department가 구한다 
-- 연령별로 가장 낮은 점수를 준 department에 혜택을 준다. 

SELECT 
	`department name`
    , FLOOR(AGE/10) * 10 AGEBAND
    , AVG(RATING) AS AVG_RATING
FROM dataset2
GROUP BY 1, 2
HAVING AGEBAND = 10
ORDER BY 3 ASC
;

SELECT *
	, ROW_NUMBER() OVER(PARTITION BY AGEBAND ORDER BY AVG_RATING) RNK
FROM (
	SELECT 
		`department name`
		, FLOOR(AGE/10) * 10 AGEBAND
		, AVG(RATING) AS AVG_RATING
	FROM dataset2
	GROUP BY 1, 2
) A
;

SELECT * 
FROM (
	SELECT *
		, ROW_NUMBER() OVER(PARTITION BY AGEBAND ORDER BY AVG_RATING) RNK
	FROM (
		SELECT 
			`department name`
			, FLOOR(AGE/10) * 10 AGEBAND
			, AVG(RATING) AS AVG_RATING
		FROM dataset2
		GROUP BY 1, 2
	) A
) A 
WHERE RNK = 1;

-- 4교시 : 오전 3교시 배운 내용 복습, 블로그에 잘 정리! 
-- 8교시 : 블로그 초안 포함 링크 공유 (전원 필히 해주세요!) 5:30분에 모두 제출요망
