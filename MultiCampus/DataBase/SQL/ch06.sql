-- 스키마, 테이블 확인
USE instacart;

SELECT * FROM aisles; -- 상품 카테고리
SELECT * FROM departments; -- 상품 카테고리
SELECT * FROM order_products__prior; -- 주문번호의 상세 내역
SELECT * FROM orders;-- 주문 대표 정보
SELECT * FROM products; -- 상품 정보

-- 지표 추출(마케팅과 관련)
-- 전체 건수 > order id, user_id 개수
SELECT 
    COUNT(DISTINCT order_id) 
    ,COUNT(DISTINCT user_id) 
FROM orders;

-- 상품별 주문건수
SELECT
    *
FROM order_products__prior A
LEFT
JOIN products B
ON A.product_id = B.product_id
;

SELECT
    B.product_name
    , COUNT(DISTINCT A.order_id) F
FROM order_products__prior A
LEFT
JOIN products B
ON A.product_id = B.product_id
GROUP BY 1
ORDER BY 2 DESC
;

select
    *
    , ROW_NUMBER() OVER(ORDER BY F DESC) RNK
FROM(
    SELECT 
        user_id
        , COUNT(DISTINCT order_id) F
    FROM orders
    GROUP BY 1) A;

-- 첫번쨰로 담기는 주문건 조회
SELECT
    product_id
    , CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END F_1st
FROM order_products__prior;


-- 첫번쨰로 담기는 주문건 개수 조회
SELECT
        product_id
        ,SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
    FROM order_products__prior
    GROUP BY 1
    ORDER BY 2 DESC;


-- 첫번쨰로 가장 많이 담기는 product_id 상위 10개를 추출
SELECT
    *
    , ROW_NUMBER() OVER(ORDER BY F_1st DESC) RNK
FROM(
    SELECT
        product_id
        ,SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
    FROM order_products__prior
    GROUP BY 1
) A
LIMIT 10;  -- LIMIT


-- 쿼리의 순서를 기억해야 함
-- FROM > WHERE >  GROUP BY, HAVING > SELECT > ORDER BY

SELECT
    *
FROM (
    SELECT
    *
    , ROW_NUMBER() OVER(ORDER BY F_1st DESC) RNK
FROM(
    SELECT
        product_id
        ,SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
    FROM order_products__prior
    GROUP BY 1
) A ) BASE
WHERE RNK BETWEEN 1 AND 10;


-- 시간별 주문 건수
SELECT
    ORDER_HOUR_OF_DAY
    , COUNT(DISTINCT order_id) F
FROM orders
GROUP BY 1
ORDER BY 1;

-- 주문건당 평균 구매 상품 수(UPT)
SELECT
    AVG(days_since_prior_order) AVG_RECENCY
FROM orders
WHERE order_number= 2;


-- 주문건당 평균 구매 상품 수
SELECT
    COUNT(product_id) / COUNT(DISTINCT order_id)
FROM order_products__prior;

-- 인당 평균 주문 건수
SELECT
    COUNT(order_id) / COUNT(DISTINCT user_id) AVG_F
FROM orders;


-- 재구매율이 가장 높은 상품 10개
-- p.169
-- 상품별로 재구매율을 계상한 뒤, 재 구매율을 기준으로 랭크를 계산함(서브쿼리, 윈도우 함수)

SELECT * FROM order_products__prior;

-- 상품별 재구매율 계산
SELECT
    product_id
    , SUM(reordered) / COUNT(*) AS RET_RATIO
FROM
    order_products__prior
GROUP BY 1
;

-- rank
SELECT
    *
    , ROW_NUMBER() OVER(ORDER BY RET_RATIO DESC) AS RNK
FROM(
    SELECT
        product_id
        , SUM(reordered) / COUNT(*) AS RET_RATIO
    FROM
        order_products__prior
    GROUP BY 1
)A
LIMIT 10
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
WHERE 합계 >= 50
;

-- department 별 재구매울이 가장 높은 상품 10개
SELECT
    A.product_id
    , SUM(reordered)/count(*) AS RET_RATIO
FROM order_products__prior A
LEFT
JOIN products B
ON A.product_id = B.product_id
GROUP BY 1
;

-- step01. 조인을 걸어놓고 시작해야 함
SELECT
    department
    ,A. product_id
FROM order_products__prior A
LEFT
JOIN products B
ON A.product_id = B.product_id
LEFT 
JOIN departments C
ON B.department_id = C.department_id
;


-- 비율 구하기
SELECT
    department
    ,A. product_id
    , SUM(reordered) / COUNT(*) AS RET_RATIO
FROM order_products__prior A
LEFT
JOIN products B
ON A.product_id = B.product_id
LEFT 
JOIN departments C
ON B.department_id = C.department_id
GROUP BY 1,2
;

-- 순위 넣기
SELECT
    *
    , ROW_NUMBER() OVER(ORDER BY ret_ratio DESC)
FROM(
    SELECT
        department
        ,A. product_id
        , SUM(reordered) / COUNT(*) AS RET_RATIO
    FROM order_products__prior A
    LEFT
    JOIN products B
    ON A.product_id = B.product_id
    LEFT 
    JOIN departments C
    ON B.department_id = C.department_id
    GROUP BY 1,2
)A;

-- partition by 추가
SELECT
    *
    , ROW_NUMBER() OVER(PARTITION BY department ORDER BY ret_ratio DESC)
FROM(
    SELECT
        department
        ,A. product_id
        , SUM(reordered) / COUNT(*) AS RET_RATIO
    FROM order_products__prior A
    LEFT
    JOIN products B
    ON A.product_id = B.product_id
    LEFT 
    JOIN departments C
    ON B.department_id = C.department_id
    GROUP BY 1,2
)A

-- where 서브쿼리 추가
select
    SELECT * 
        ROW_NUMBER() OVER(ORDER BY ret_ratio DESC) RNK
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
;

-- 최종

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