## JOIN  메커니즘

#### 실행 환경

- PostgreSQL, DBeaver



#### 조인

- 관계형 DB에서 가장 기본이자 중요한 기능
- 두개 이상의 테이블을 서로 연결하여 데이터를 추출
- 관계형 DB에서는 조인을 통해 서로 다른 테이블 간의 정보를 원하는 대로 가져올 수 있음
- 동격(어떤 테이블을 먼저 조인하든 결과는 똑같다.

```postgresql
/************************************
   조인 실습 - 1
*************************************/
select * from dept;

select * from emp;

select * from emp_salary_hist;

-- 직원 정보와 직원이 속한 부서명을 가져오기
 select a.*
 from hr.dept a 
 	join hr.emp b on a.deptno = b.deptno;

-- job이 SALESMAN인 직원정보와 직원이 속한 부서명을 가져오기. 
 select a.*
 from hr.emp a 
 	join hr.dept b on a.deptno = b.deptno 
 where a.job = 'SALESMAN'
	
-- 부서명 SALES와 RESEARCH의 소속 직원들의 부서명, 직원번호, 직원명, JOB 그리고 과거 급여 정보 추출 
select a.dname, b.empno, b.job, c.fromdate, c.todate, c.sal
from hr.dept a
	join hr.emp b on a.deptno = b.deptno
	join hr.emp_salary_hist esh _hist c on b.empno = c.empno
where a.dname in ('SALES','RESEARCH')
 

-- 부서명 SALES와 RESEARCH의 소속 직원들의 부서명, 직원번호, 직원명, JOB 그리고 과거 급여 정보중 1983년 이전 데이터는 무시하고 데이터 추출 
select a.dname, b.empno, b.job, c.fromdate, c.todate, c.sal
from hr.dept a
	join hr.emp b on a.deptno = b.deptno
	join hr.emp_salary_hist c on b.empno = c.empno
where a.dname in ('SALES','RESEARCH')
and c.fromdate >= to_date('19830101','yyyymmdd')
order by 1,2,3, c.fromdate;

-- 부서명 SALES와 RESEARCH 소속 직원별로 과거부터 현재까지 모든 급여를 취합한 평균 급여
with 
temp_01 as 
(
select a.dname, b.empno, b.ename, b.job, c.fromdate, c.todate, c.sal 
from hr.dept a
	join hr.emp b on a.deptno = b.deptno
	join hr.emp_salary_hist c on b.empno = c.empno
where  a.dname in('SALES', 'RESEARCH')
order by a.dname, b.empno, c.fromdate
)
select empno, max(ename) as ename, avg(sal) as avg_sal
from temp_01 
group by empno;


-- 직원명 SMITH의 과거 소속 부서 정보를 구할 것. 
select a.ename, a.empno, b.deptno, c.dname, b.fromdate, b.todate
from hr.emp a
	join hr.emp_dept_hist b on a.empno = b.empno 
	join hr.dept c on b.deptno = c.deptno
where a.ename = 'SMITH';

 
```



 

#### SQL 조인 시 데이터 집합 레벨의 변화

1: M 조인 시 결과 집합은 M 집합의 레벨을 그대로 유지

M:N 조인 주의



#### 조인 유형

- Inner Join
- Outer Join
  - Right, Left
- Full Outer Join

- Non Equi 조인
  - 키 값으로 연결 시 = 이 아닌 다른 연산자(between 등)으로 연결

- Cross Join
  - 조인 컬럼없이 두 테이블 간 가능한 모든 연결을 결합하는 조인 방식

~~~postgresql
/************************************
   조인 실습 - 2
*************************************/
select * from nw.customers;
select * from nw.orders;

-- 고객명 Antonio Moreno이 1997년에 주문한 주문 정보를 주문 아이디, 주문일자, 배송일자, 배송 주소를 고객 주소와 함께 구할것.  
select a.contact_name, a.address, b.order_id , b.order_date, b.shipped_date , b.ship_address
from nw.customers a
	join nw.orders b on a.customer_id = b.customer_id 
where a.contact_name = 'Antonio Moreno'
and b.order_date between to_date('19970101', 'yyyymmdd') and to_date('19971231', 'yyyymmdd');

-- Berlin에 살고 있는 고객이 주문한 주문 정보를 구할것
-- 고객명, 주문id, 주문일자, 주문접수 직원명, 배송업체명을 구할것
select a.customer_id, a.contact_name, b.order_id, b.order_date, c.first_name || ' ' || c.last_name as employee_name,
d.company_name as shiper_name
from nw.customers a
	join nw.orders b on a.customer_id = b.customer_id
	join nw.employees c on b.employee_id = c.employee_id 
	join nw.shippers d on b.ship_via = d.shipper_id
where a.city = 'Berlin';


-- Beverages 카테고리에 속하는 모든 상품아이디와 상품명, 그리고 이들 상품을 제공하는 supplier 회사명 정보 구할것 

select * from nw.categories;
select * from 

select a.category_id , a.category_name, b.product_id , b.product_name, c.supplier_id, c.company_name
from nw.categories a
	join nw.products b on a.category_id = b.category_id 
	join nw.suppliers c on b.supplier_id = c.supplier_id 
where a.category_name = 'Beverages'

-- 고객명 Antonio Moreno이 1997년에 주문한 주문 상품정보를 고객 주소, 주문 아이디, 주문일자, 배송일자, 배송 주소 및
-- 주문 상품아이디, 주문 상품명, 주문 상품별 금액, 주문 상품이 속한 카테고리명, supplier명을 구할 것. 
select a.contact_name , a.address, b.order_id , b.order_date, b.shipped_date, b.ship_address 
	,c.product_id , d.product_name, c.amount , e.category_name, 
from nw.customers a
	join nw.orders b on a.customer_id = b.customer_id
	join nw.order_items c on b.order_id = c.order_id
	join nw.products d on c.product_id = d.product_id
	join nw.categories e on d.category_id = e.category_id
	join nw.suppliers f on d.supplier_id = f.supplier_id 
where a.contact_name = 'Antonio Moreno'
and b.order_date between to_date('19970101', 'yyyymmdd') and to_date('19971231', 'yyyymmdd');
	

/************************************
   조인 실습 - Outer 조인. 
*************************************/	

-- 주문이 단 한번도 없는 고객 정보 구하기. 
select a.customer_id , a.contact_name , b.order_id,b.customer_id 
from nw.customers a
	left outer join nw.orders b on a.customer_id = b.customer_id 
where b.order_id is null;


-- 부서정보와 부서에 소속된 직원명 정보 구하기. 부서가 직원을 가지고 있지 않더라도 부서정보는 표시되어야 함. 
select a.*, b.empno, b.ename
from hr.dept a
	left join hr.emp b on a.deptno = b.deptno;
	

-- Madrid에 살고 있는 고객이 주문한 주문 정보를 구할것.
-- 고객명, 주문id, 주문일자, 주문접수 직원명, 배송업체명을 구하되, 
-- 만일 고객이 주문을 한번도 하지 않은 경우라도 고객정보는 빠지면 안됨. 이경우 주문 정보가 없으면 주문id를 0으로 나머지는 Null로 구할것. 

select a.customer_id , a.contact_name, coalesce (b.order_id,0),
c.first_name || ' ' || c.last_name as employee_namㄷ, d.company_name as shipper_name
from nw.customers a
	left join nw.orders b on a.customer_id = b.customer_id
	left join nw.employees c on b.employee_id = c.employee_id 
	left join nw.shippers d on b.ship_via = d.shipper_id
where a.city = 'Madrid';
	

-- 만일 아래와 같이 중간에 연결되는 집합을 명확히 left outer join 표시하지 않으면 원하는 집합을 가져 올 수 없음.  


-- orders_items에 주문번호(order_id)가 없는 order_id를 가진 orders 데이터 찾기 
select *
from nw.orders a
	left join nw.order_items b on a.order_id = b.order_id
where b.order_id is null;

-- orders 테이블에 없는 order_id가 있는 order_items 데이터 찾기. 
select * 
from nw.order_items a 
	left join nw.orders b on a.order_id = b.order_id
where b.order_id is null;


/************************************
   조인 실습 - Full Outer 조인. 
*************************************/	

-- dept는 소속 직원이 없는 경우 존재. 하지만 직원은 소속 부서가 없는 경우가 없음. 
select a.*, b.empno, b.ename
from hr.dept a
	left join hr.emp b on a.deptno = b.deptno; 

-- full outer join 테스트를 위해 소속 부서가 없는 테스트용 데이터 생성. 
drop table if exists hr.emp_test; 

create table hr.emp_test
as
select * from hr.emp;

select * from hr.emp_test;

-- 소속 부서를 Null로 update
update hr.emp_test set deptno = null where empno=7934;

select * from hr.emp_test;

-- dept를 기준으로 left outer 조인시에는 소속직원이 없는 부서는 추출 되지만. 소속 부서가 없는 직원은 추출할 수 없음.  
select a.*, b.empno, b.ename
from hr.dept a
	left join hr.emp_test b on a.deptno = b.deptno; 

-- full outer join 하여 양쪽 모두의 집합이 누락되지 않도록 함. 
select a.*, b.empno, b.ename
from hr.dept a
	full outer join hr.emp_test b on a.deptno = b.deptno; 


/************************************
   조인 실습 - Non Equi 조인과 Cross 조인. 
*************************************/
select * from hr.salgrade;
select * from hr.emp;

-- 직원정보와 급여등급 정보를 추출. 
select a.*, b.grade as salgrade
from hr.emp a 
	join hr.salgrade b on a.sal between b.losal and b.hisal;

select * from hr.emp_salary_hist;
select * from hr.emp_dept_hist;


-- 직원 급여의 이력정보를 나타내며, 해당 급여를 가졌던 시점에서의 부서번호도 함께 가져올것. 
select * 
from hr.emp_salary_hist a
	join hr.emp_dept_hist b on a.empno = b.empno and a.fromdate between b.fromdate and b.todate;

-- cross 조인
with
temp_01 as (
select 1 as rnum 
union all
select 2 as rnum
)
select a.*, b.*
from hr.dept a 
	cross join temp_01 b;

~~~

