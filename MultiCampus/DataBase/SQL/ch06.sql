USE instacart;

SELECT * FROM aisles; -- 상품 카테고리
SELECT * FROM departments; -- 상품 카테고리
SELECT * FROM order_products__prior; -- 주문 번호의 상세 내역
SELECT * FROM orders; -- 주문 대표 정보 
SELECT * FROM products; -- 상품 정보

-- p158
-- 지표 추출 : 일반적인 마케팅 관련된 내용 

SELECT * FROM orders;

-- 전체 주문건수
SELECT 
	COUNT(DISTINCT order_id) 
	, COUNT(DISTINCT user_id) 
FROM orders
;

-- 상품별 주문 건수 
-- 주문번호와 상품명이 같이 사용하려면
-- order_products__prior와 products 조인해야 함 
SELECT 
	* 
FROM order_products__prior A
LEFT 
JOIN products B
ON A.product_id = B.product_id
;

-- 제품별 주문건수 
SELECT 
	B.product_name
    , COUNT(DISTINCT A.order_id) F -- 왜 DISTINCT를 사용했는가? 의미 파악
FROM order_products__prior A
LEFT 
JOIN products B
ON A.product_id = B.product_id
GROUP BY 1
ORDER BY 2 DESC
;

-- 장바구니에 가장 먼저 넣는 상품 10개
SELECT * FROM order_products__prior;

-- 첫번째로 담기는 주문건은 1, 그 외에는 0으로 표시 
SELECT 
	product_id
    , CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END F_1st
FROM order_products__prior
ORDER BY 1
;

-- 첫번째로 가장 많이 담기는 product_id 상위 10개를 추출하자! 
SELECT 
	*
    , ROW_NUMBER() OVER(ORDER BY F_1st DESC) RNK
FROM (
	SELECT 
		product_id
		, SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
	FROM order_products__prior
	GROUP BY 1
) A
LIMIT 10
;

-- p.166
SELECT * 
FROM (
	SELECT 
		*
		, ROW_NUMBER() OVER(ORDER BY F_1st DESC) RNK
	FROM (
		SELECT 
			product_id
			, SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
		FROM order_products__prior
		GROUP BY 1
	) A
) BASE
WHERE RNK BETWEEN 1 AND 10
;

-- 시간별 주문 건수 
SELECT * FROM orders;

SELECT 
	order_hour_of_day
    , COUNT(DISTINCT order_id) F 
FROM orders
GROUP BY 1
ORDER BY 1
;

-- 첫 구매 후 다음 구매까지 걸린 평균 일수 
SELECT * FROM orders;
-- order_number 2인 의미 파악 
SELECT 
	AVG(days_since_prior_order) AVG_RECENCY
FROM orders
WHERE order_number = 2
;

-- 주문 건당 평균 구매 상품 수(UPT, Uni Per Transaction) 
SELECT
	COUNT(product_id) / COUNT(DISTINCT order_id) UPT 
FROM order_products__prior
;

-- 인당 평균 주문 건수 : 전체 주문 건수를 구매자 수로 나누어서 계산 
SELECT 
	COUNT(DISTINCT order_id) / COUNT(DISTINCT user_id) AS AVG_F 
FROM orders
;

-- 재구매율이 가장 높은 상품 10개 
-- p.169
-- 상품별로 재구매율을 계산한 뒤, 
-- 재 구매율을 기준으로 랭크를 계산함 (서브쿼리, Windows Function)
-- Rank값으로 1-10 조건 / LIMIT
SELECT * FROM order_products__prior;


-- product_id / RET_RATIO / RNK (~25분까지 실습)
-- 상품별 재구매율 계산
SELECT 
	product_id
    , SUM(reordered) / COUNT(*) AS RET_RATIO
FROM
	order_products__prior
GROUP BY 1
;

-- 재구매율로 랭크(순위) 열 생성하기 
SELECT 
	*
    , ROW_NUMBER() OVER(ORDER BY RET_RATIO DESC) RNK
FROM (
	SELECT 
		product_id
		, SUM(reordered) / COUNT(*) AS RET_RATIO
	FROM
		order_products__prior
	GROUP BY 1
) A 
WHERE product_id IN (
SELECT product_id 
	FROM (
		SELECT 
			product_id
			, SUM(reordered) AS 합계
		FROM
			order_products__prior
		GROUP BY 1 
	) A
	WHERE 합계 >= 50
)
;

SELECT product_id 
FROM (
	SELECT 
		product_id
		, SUM(reordered) AS 합계
	FROM
		order_products__prior
	GROUP BY 1 
) A
WHERE 합계 >= 10
;

-- Department별 재 구매율이 가장 높은 상품 10개 
SELECT 
	* 
    , ROW_NUMBER() OVER(PARTITION BY department ORDER BY RET_RATIO DESC) AS RNK
FROM (
	SELECT 
		department
		, A.product_id
		, SUM(reordered) / COUNT(*) AS RET_RATIO
	FROM order_products__prior A 
	LEFT 
	JOIN products B 
	ON A.product_id = B.product_id
	LEFT 
	JOIN departments C
	ON B.department_id = C.department_id
	GROUP BY 1, 2
) BASE
;

-- WHERE 서브쿼리 추가
SELECT * 
FROM (
	SELECT 
		* 
		, ROW_NUMBER() OVER(PARTITION BY department ORDER BY RET_RATIO DESC) AS RNK 
	FROM (
		SELECT 
				department
				, A.product_id
				, SUM(reordered) / COUNT(*) AS RET_RATIO
		FROM order_products__prior A 
		LEFT 
		JOIN products B 
		ON A.product_id = B.product_id 
		LEFT 
		JOIN departments C
		ON B.department_id = C.department_id
		GROUP BY 1, 2
	) A
	WHERE product_id IN (
		SELECT product_id 
		FROM (
			SELECT 
				product_id
				, SUM(reordered) AS 합계
			FROM
				order_products__prior
			GROUP BY 1 
		) A
		WHERE 합계 >= 10
	)
) BASE
WHERE RNK <= 10
;

-- 4교시 : 오전 3교시 배운 내용 복습, 블로그에 잘 정리! 
-- 8교시 : 블로그 초안 포함 링크 공유 (전원 필히 해주세요!) 5:30분에 모두 제출요망

-- p.174 구매자 분석
SELECT 
	*
    , ROW_NUMBER() OVER(ORDER BY F DESC) RNK
FROM (
	SELECT 
		user_id
		, COUNT(DISTINCT order_id) AS F
	FROM 
		orders
	GROUP BY 1
) A
;

SELECT COUNT(DISTINCT user_id)
FROM 
	(SELECT 
		user_id
		, COUNT(DISTINCT order_id) F 
	 FROM orders
     GROUP BY 1
) A
;

-- 10분위 수 지정
SELECT 
	*, 
    CASE WHEN RNK BETWEEN 1 AND 316 THEN 'Quantile_1' END quantile
FROM (
	SELECT 
		*
		, ROW_NUMBER() OVER(ORDER BY F DESC) RNK
	FROM (
		SELECT 
			user_id
			, COUNT(DISTINCT order_id) AS F
		FROM 
			orders
		GROUP BY 1
	) A
) A 
;

-- 10분위 수 지정
SELECT 
	*, 
    CASE WHEN RNK <= 316 THEN 'Quantile_1' END quantile
FROM (
	SELECT 
		*
		, ROW_NUMBER() OVER(ORDER BY F DESC) RNK
	FROM (
		SELECT 
			user_id
			, COUNT(DISTINCT order_id) AS F
		FROM 
			orders
		GROUP BY 1
	) A
) A 
;


SELECT 
	*, 
    CASE WHEN RNK <= (SELECT COUNT(DISTINCT user_id)
						FROM 
							(SELECT 
								user_id
								, COUNT(DISTINCT order_id) F 
							 FROM orders
							 GROUP BY 1
							) A
					  ) / 10 THEN 'Quantile_1' 
        WHEN RNK <= ((SELECT COUNT(DISTINCT user_id)
						FROM 
							(SELECT 
								user_id
								, COUNT(DISTINCT order_id) F 
							 FROM orders
							 GROUP BY 1
							) A
					  ) / 10) * 2 THEN 'Quantile_2' 
END quantile
FROM (
	SELECT 
		*
		, ROW_NUMBER() OVER(ORDER BY F DESC) RNK
	FROM (
		SELECT 
			user_id
			, COUNT(DISTINCT order_id) AS F
		FROM 
			orders
		GROUP BY 1
	) A
) A 
;

-- p179
CREATE TEMPORARY TABLE INSTACART.USER_QUANTILE AS
SELECT *,
CASE WHEN RNK <= 316 THEN 'Quantile_1'
WHEN RNK <= 632 THEN 'Quantile_2'
WHEN RNK <= 948 THEN 'Quantile_3'
WHEN RNK <= 1264 THEN 'Quantile_4'
WHEN RNK <= 1580 THEN 'Quantile_5'
WHEN RNK <= 1895 THEN 'Quantile_6'
WHEN RNK <= 2211 THEN 'Quantile_7'
WHEN RNK <= 2527 THEN 'Quantile_8'
WHEN RNK <= 2843 THEN 'Quantile_9'
WHEN RNK <= 3159 THEN 'Quantile_10' END quantile
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY F DESC) RNK
FROM
(SELECT USER_ID,
COUNT(DISTINCT ORDER_ID) F
FROM INSTACART.ORDERS
GROUP
BY 1) A) A
;

SELECT *
FROM user_quantile
;

-- 서브쿼리
-- FROM, WHERE, SELECT 
-- 각 분위수별 전체 주문 건수의 합을 구한다. 
SELECT 
	quantile
    , SUM(F)
FROM user_quantile
GROUP BY 1
;

SELECT SUM(F) FROM user_quantile;

SELECT 
	quantile AS 분위수
    , SUM(F) AS 주문건수 
    , SUM(F) / 3220 AS 비율
FROM user_quantile 
GROUP BY 1
;

-- p.181 
-- 재구매 / 재방문 ==> 전환율 비중이 높은 상품을 찾아본다! 

-- 테이블 : order_products__prior 
SELECT 
	A.product_id
    , SUM(reordered) / SUM(1) AS reorder_rate
	, COUNT(DISTINCT order_id) AS F 
FROM order_products__prior A 
LEFT 
JOIN products B
ON A.product_id = B.product_id
GROUP BY A.product_id
HAVING COUNT(DISTINCT order_id) > 10
;

-- p.183
-- SELECT문에서 새롭게 생성한 컬럼에 조건을 걸 때, 
-- 새롭게 생성한 컬럼을 WHERE절에 사용하는 실수 
-- 쿼리 순서 : (1) FROM WHERE GROUP BY HAVING SELECT ORDER BY
SELECT 
	A.product_id
    , B.product_name
    , SUM(reordered) / SUM(1) AS reorder_rate
	, COUNT(DISTINCT order_id) AS F 
FROM order_products__prior A 
LEFT 
JOIN products B
ON A.product_id = B.product_id
GROUP BY A.product_id, B.product_name
HAVING COUNT(DISTINCT order_id) > 10
ORDER BY 3 DESC
;

-- 다음 구매까지의 소요 기간과 재구매 관계
-- 고객이 자주 재구매하는 상품 vs 그렇지 않은 상품보다 일정한 주기를 가질 것이다. 
-- 가정을 세우고 수치를 살펴보자
-- 기초 통계로 적용하면? 
SELECT * 
FROM (
	SELECT 
		* 
		, ROW_NUMBER() OVER(ORDER BY RET_RATIO DESC) RNK
	FROM (
		SELECT 
			product_id
			, SUM(reordered) / COUNT(*) AS RET_RATIO
		FROM order_products__prior
		GROUP BY 1
	) A
) A 
;

CREATE TEMPORARY TABLE product_repurchase_quantile AS 
SELECT 
	A.product_id
    , CASE WHEN RNK <= 929 THEN 'Q_1'
		WHEN RNK <= 1858 THEN 'Q_2'
        WHEN RNK <= 2786 THEN 'Q_3'
        WHEN RNK <= 3715 THEN 'Q_4'
        WHEN RNK <= 4644 THEN 'Q_5'
        WHEN RNK <= 5573 THEN 'Q_6'
        WHEN RNK <= 6502 THEN 'Q_7'
        WHEN RNK <= 7430 THEN 'Q_8'
        WHEN RNK <= 8359 THEN 'Q_9'
        WHEN RNK <= 9288 THEN 'Q_10' END RNK_GRP
FROM (
	SELECT 
		* 
		, ROW_NUMBER() OVER(ORDER BY RET_RATIO DESC) RNK
	FROM (
		SELECT 
			product_id
			, SUM(reordered) / COUNT(*) AS RET_RATIO
		FROM order_products__prior
		GROUP BY 1
	) A
) A 
GROUP BY 1, 2
;

SELECT * FROM product_repurchase_quantile;

-- p.188
-- 각 분위 수별 재구매 소요 기간의 분산을 구하려면 다음과 같은 정보를 결합해 구해야 함 
-- 상품별 분위수 테이블
-- 주문 소요 시간 : orders 테이블
-- 주문 번호 상품번호 : order_products__prior

CREATE TEMPORARY TABLE order_products__pior2 AS 
SELECT 
	product_id
    , days_since_prior_order
FROM order_products__prior A
INNER 
JOIN orders B
ON A.order_id = B.order_id
;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM order_products__pior2;

-- 분위수, 상품별 구매 소요 기간의 분산 계산
SELECT 
	A.rnk_grp
    , A.product_id
    , VARIANCE(days_since_prior_order) AS var_days
FROM product_repurchase_quantile A 
LEFT JOIN order_products__pior2 B
ON A.product_id = B.product_id
GROUP BY 1, 2
ORDER BY 1
;
 
-- 가정 : 재구매율이 높은 상품군은 구매 주기가 일정할 것이다! 
-- 재구매율에 따라 상품을 10가지 그룹으로 분할 했고, 각 분위 수의 상품별 구매 소요 기간의 분산을 계산했다. 
-- median 함수를 이용하겠다! (문제: mysql은 제공하지 않음)

-- 1) SQL에 함수가 존재하지 않음 ===> 사용자 정의 함수 (PL/SQL) 
-- 2) Python 또는 R 이랑 연동을 해서, DB에서 Python으로 데이터를 가져와서 통계처리
SELECT RNK_GRP,
AVG(VAR_DAYS) AVG_VAR_DAYS
FROM
(SELECT A.RNK_GRP,
A.PRODUCT_ID,
VARIANCE(days_since_prior_order) VAR_DAYS
FROM PRODUCT_REPURCHASE_QUANTILE A
LEFT
JOIN INSTACART.ORDER_PRODUCTS__PRIOR B
ON A.PRODUCT_ID = B.PRODUCT_ID
LEFT
JOIN INSTACART.ORDERS C
ON B.ORDER_ID = C.ORDER_ID
GROUP
BY 1,2) A
GROUP
BY 1
ORDER
BY 1
;

-- 분산분석 
-- 3개 이상의 그룹 비교 
-- p.value 0.05 이하 ==> 대립가설 채택 
-- 사후분석 ==> 두개그룹으로 쪼개서, 두 그룹간의 평균 비교
-- Q_1, vs Q_2 비교, Q_3 비교 ... Q_10
-- Q_2, vs Q_3, Q_4... Q_10
-- ...
-- Q_9 vs Q_10

-- 4교시 : 오전 3교시 배운 내용 복습, 블로그에 잘 정리! 
-- 8교시 : 블로그 초안 포함 링크 공유 (전원 필히 해주세요!) 5:30분에 모두 제출요망