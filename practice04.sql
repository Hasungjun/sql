-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?

select count(a.emp_no)
from employees a ,salaries b
where a.emp_no = b.emp_no 
and b.to_date = '9999-01-01' 
and salary > (select avg(salary) from salaries  where to_date = '9999-01-01');





-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 

select a.emp_no, a.last_name, c.dept_name, d.salary
from employees a , dept_emp b, departments c , salaries d, (select a.emp_no as emp_no1, d.dept_name as dept_name , max(b.salary) as salary, a.emp_no as emp_no from employees a, salaries b, dept_emp c, departments d where a.emp_no = b.emp_no and a.emp_no = c.emp_no and c.dept_no = d.dept_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' group by d.dept_name) aa
where a.emp_no = b.emp_no and b.dept_no = c.dept_no and a.emp_no = d.emp_no
and b.to_date = '9999-01-01' and d.to_date = '9999-01-01'
and a.emp_no = aa.emp_no1
order by d.salary desc;


-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요



select a.emp_no , a.last_name , d.salary
from employees a , dept_emp b, departments c , salaries d, ( select d.dept_name as dept_name , avg(b.salary) as salary, a.emp_no as emp_no from employees a, salaries b, dept_emp c, departments d where a.emp_no = b.emp_no and a.emp_no = c.emp_no and c.dept_no = d.dept_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' group by d.dept_name) aa
where a.emp_no = b.emp_no and b.dept_no = c.dept_no and a.emp_no = d.emp_no
and b.to_date = '9999-01-01' and d.to_date = '9999-01-01' and aa.dept_name = c.dept_name and d.salary > aa.salary;





-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

select a.emp_no , a.last_name , aa.last_name as manager
from employees a , dept_emp b, departments c ,  (select dept_name, last_name from employees a, dept_manager b, departments c where a.emp_no = b.emp_no and b.dept_no = c.dept_no and b.to_date = '9999-01-01') aa
where a.emp_no = b.emp_no and b.dept_no = c.dept_no 
and b.to_date = '9999-01-01'  and aa.dept_name = c.dept_name ;




-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no, a.last_name , e.title , b.salary
from employees a , salaries b , dept_emp c, departments d , titles e
where a.emp_no = b.emp_no and a.emp_no = c.emp_no and c.dept_no = d.dept_no and a.emp_no = e.emp_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01' and e.to_date = '9999-01-01'
and d.dept_name = (select d.dept_name
from employees a , salaries b , dept_emp c, departments d 
where a.emp_no = b.emp_no and a.emp_no = c.emp_no and c.dept_no = d.dept_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01'
group by dept_name having avg(b.salary)
order by avg(b.salary)
limit 0,1)
order by b.salary desc;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 

select d.dept_name
from employees a , salaries b , dept_emp c, departments d 
where a.emp_no = b.emp_no and a.emp_no = c.emp_no and c.dept_no = d.dept_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01'
group by dept_name having avg(b.salary)
order by avg(b.salary)
limit 0,1;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?

select c.title
from employees a , salaries b , titles c
where a.emp_no = b.emp_no and a.emp_no = c.emp_no
and b.to_date = '9999-01-01' and c.to_date = '9999-01-01'
group by c.title having avg(b.salary)
order by avg(c.title)
limit 0,1;


-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.


select c.dept_name, a.last_name , d.salary , aa.last_name , aa.salary 
from employees a , dept_emp b, departments c , salaries d , (select c.dept_name as dept_name, a.last_name as last_name, d.salary as salary from employees a, dept_manager b, departments c, salaries d where a.emp_no = b.emp_no and a.emp_no = d.emp_no and b.dept_no = c.dept_no and b.to_date = '9999-01-01'and d.to_date = '9999-01-01') aa
where a.emp_no = b.emp_no and b.dept_no = c.dept_no and a.emp_no = d.emp_no
and b.to_date = '9999-01-01' and d.to_date='9999-01-01' and aa.dept_name = c.dept_name and d.salary >aa.salary ;

