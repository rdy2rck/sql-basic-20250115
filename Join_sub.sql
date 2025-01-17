USE practice_sql;

CREATE TABLE employee (
employee_number INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20),
age INT,
department_code VARCHAR(2)
);

CREATE TABLE department (
department_code VARCHAR(2) PRIMARY KEY,
name VARCHAR(30),
tel_number VARCHAR(15)
);

ALTER TABLE employee
ADD CONSTRAINT employee_department_code_fk
FOREIGN KEY (department_code)
REFERENCES department (department_code);

ALTER TABLE employee
DROP CONSTRAINT employee_department_code_fk;

INSERT INTO department VALUES ('A', '영업부', '051-555-5555');
INSERT INTO department VALUES ('B', '사업부', '051-555-4444');
INSERT INTO department VALUES ('C', '인사부', '051-555-2222');

INSERT INTO employee (name, age, department_code) VALUES ('홍길동', 23, 'A');
INSERT INTO employee (name, age, department_code) VALUES ('이영희', 32, 'D');
INSERT INTO employee (name, age, department_code) VALUES ('김철수', 36, 'B');
INSERT INTO employee (name, age, department_code) VALUES ('이성계', 40, 'A');
INSERT INTO employee (name, age, department_code) VALUES ('왕건', 18, 'D');

-- Alias : SQL 쿼리문에서 사용되는 별칭 (AS 키워드 사용)
-- 컬럼 및 테이블에서 사용 가능
-- 결과 혹은 원래 이름을 다르게 지정하고 싶을 때 사용
-- AS를 이용해서 별칭 지정 시 컬럼 및 테이블 이름이 해당 별칭으로 변경됨
SELECT
employee_number AS '사번',
name AS '사원이름',
age AS '사원나이',
department_code AS '부서코드'
FROM employee;

-- AS 키워드를 생략 후 띄워쓰기만 해용해도 Alias 사용 가능
SELECT
employee_number '사번',
name '사원이름',
age '사원나이',
department_code '부서코드'
FROM employee;

-- JOIN : 두 개 이상의 테이블을 특정 조건에 따라 조합하여 결과를 반환

-- INNER JOIN : 두 테이블에서 조건에 일치하는 레코드만 반환
-- SELECT column, ... FROM 기준테이블 INNER JOIN 조합할테이블 ON 조인조건
SELECT
E.employee_number '사원 번호',
E.name '사원 이름',
E.age '사원 나이',
D.department_code '부서 코드',
D.name '부서 이름',
D.tel_number '부서 전화번호'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code;

-- JOIN이 포함된 WHERE 작업은 JOIN 결과에서 조건을 검사함
SELECT
E.employee_number '사원 번호',
E.name '사원 이름',
E.age '사원 나이',
D.department_code '부서 코드',
D.name '부서 이름',
D.tel_number '부서 전화번호'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code
WHERE E.age < 20;

-- LEFT OUTER JOIN (LEFT JOIN) : 기준 테이블의 모든 레코드와 조합할 테이블 중 조건에 일치하는 레코드만 반환
-- 만약, 조합할 테이블에 조건에 부합하는 레코드가 존재하지 않으면 null로 채움
SELECT
E.employee_number '사원 번호',
E.name '사원 이름',
E.age '사원 나이',
D.department_code '부서 코드',
D.name '부서 이름',
D.tel_number '부서 전화번호'
FROM employee E LEFT JOIN department D
ON E.department_code = D.department_code;

-- RIGHT OUTER JOIN (RIGHT JOIN) : 조합할 테이블의 모든 레코드와 기준 테이블 중 조건에 일치하는 레코드만 반환
-- 만약 기준 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
SELECT
E.employee_number '사원 번호',
E.name '사원 이름',
E.age '사원 나이',
D.department_code '부서 코드',
D.name '부서 이름',
D.tel_number '부서 전화번호'
FROM employee E RIGHT JOIN department D
ON E.department_code = D.department_code;

-- FULL OUTER JOIN (FULL JOIN) : 기준 테이블의 모든 레코드와 조합할 테이블의 모든 레코드를 반환
-- 만약 기준 테이블 혹은 조합할 테이블에 조건에 부합하는 레코드가 존재하지 않으면 null로 반환
-- MySQL에서는 FULL JOIN를 문법적으로 지원하지 않음
-- FULL JOIN = LEFT JOIN + UNION + RIGHT JOIN
SELECT
E.employee_number '사원 번호',
E.name '사원 이름',
E.age '사원 나이',
D.department_code '부서 코드',
D.name '부서 이름',
D.tel_number '부서 전화번호'
FROM employee E LEFT JOIN department D
ON E.department_code = D.department_code
UNION
SELECT
E.employee_number '사원 번호',
E.name '사원 이름',
E.age '사원 나이',
D.department_code '부서 코드',
D.name '부서 이름',
D.tel_number '부서 전화번호'
FROM employee E RIGHT JOIN department D
ON E.department_code = D.department_code;

-- CROSS JOIN : 기준 테이블의 각 레코드를 조합할 테이블의 각 레코드와 조합하여 반환
-- CROSS JOIN 결과 레코드 수 = 기준 테이블 레코드 수 * 조합할 테이블의 레코드 수
-- CROSS JOIN에서는 ON 조건절이 필요없음
SELECT *
FROM employee E CROSS JOIN department D;

-- MySQL에서 기본 조인이 CROSS JOIN으로 적용
SELECT *
FROM employee E JOIN department D;

SELECT *
FROM employee E, department D;

-- 부서코드가 A인 사원에 대해 사번, 사원 이름, 부서명을 조회하시오
SELECT
E.employee_number '사원번호',
E.name '사원이름',
E.department_code '부서명'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code
WHERE E.department_code = 'A';

-- 나이가 30 이상인 사원에 대해 사원번호, 이름을 조회하시오
SELECT
E.employee_number '사원번호',
E.name '사원이름'
FROM employee E LEFT JOIN department D
ON E.department_code = D.department_code
WHERE E.age >= 30;

-- 부서명이 '영업부'인 사원에 대해 사원번호, 이름, 나이를 조회하시오
SELECT
E.employee_number '사원번호',
E.name '사원이름',
E.age '나이'
FROM employee E RIGHT JOIN department D
ON E.department_code = D.department_code
WHERE D.name = '영업부';