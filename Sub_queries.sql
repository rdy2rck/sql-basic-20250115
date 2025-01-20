USE pracitce_sql;

-- 서브 쿼리 : 쿼리 내부에 존재하는 또 다른 쿼리, 쿼리 결과를 조건이나 테이블로 사용할 수 있도록 함

-- WHERE 절에서의 서브 쿼리 : 조회 결과를 조건으로 사용하여 조건을 동적으로 지정할 수 있도록 함
-- WHERE 절에서 비교 연산 등으로 사용할 때 서브 쿼리의 결과 컬럼 수 및 레코드 수를 주의
SELECT employee_number, name, age
FROM employee
WHERE department_code = (
SELECT department_code
FROM department
WHERE name = '영업부'
);
-- 1. 서브쿼리를 통해 테이블 department에서 '영업부'의 부서 코드를 먼저 확인
-- 2. 1을 통해 확인한 '영업부'의 부서 코드와 일치하는 사원들의 사원번호, 이름, 나이를 테이블 employee에서 조회

-- WHERE 조건절에서 서브쿼리를 사용할 땐 일반적으로 해당 서브쿼리의 결과 컬럼은 1개가 와야 함
-- (= 서브 쿼리 사용 시 SELECT 이후 오는 반환은 무조건 하나만 있어야 함)
SELECT employee_number, name, age
FROM employee
WHERE department_code = (
SELECT department_code
FROM department
);
-- Error 1242 : = 연산자는 단일 값만 비교하는데, 서브 쿼리에 WHERE가 없어 복수 이상의 모든 department_code 값을 반환하게 되기 때문에 에러 발생

-- WHERE 서브 쿼리를 사용할 땐 연산자에 따라 레코드의 개수를 잘 확인해야 함
SELECT employee_number, name, age
FROM employee
WHERE department_code IN (
SELECT department_code
FROM department
);
-- 작동함 : 서브 쿼리에서 department_code 단일 칼럼만을 반환했기 때문에 단일 칼럼 비교 연산자인 IN()과 충돌하지 않음

SELECT employee_number, name, age
FROM employee
WHERE department_code IN (
SELECT *
FROM department
);
-- Error 1241 : 서브 쿼리에서 *을 이용해 모든 컬럼을 반환했으므로 단일 칼럼 비교 연산자인 IN()과 충돌함

-- FROM 절에서의 서브 쿼리 : 조회 결과 테이블을 다시 FROM 절에서 재사용
SELECT *
FROM employee E INNER JOIN (
SELECT * FROM department WHERE name = '영업부'
) D
ON E.department_code = D.department_code;

-- 서브 쿼리를 FROM 절에서 사용할 땐 3개 이상의 테이블을 조인해서 결과를 얻고자 할 때 아주 유용하게 사용됨