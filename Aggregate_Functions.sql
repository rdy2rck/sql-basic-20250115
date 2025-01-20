Use practice_sql;

CREATE TABLE sale (
sequence_number INT PRIMARY KEY AUTO_INCREMENT,
date DATE,
amount INT,
employee_number INT
);

INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-20', 100000, 1);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-20', 120000, 2);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-20', 60000, 1);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-21', 200000, 3);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-21', 150000, 2);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-23', 100000, 3);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-21', 160000, 1);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-21', 80000, 3);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-21', 90000, 1);
INSERT INTO sale (date, amount, employee_number)
VALUES ('2025-01-21', 120000, 2);

SELECT * FROM sale;

-- 집계 함수 : 여러 행의 레코드를 종합하여 하나의 결과값을 반환
-- SELECT 다음에 입력하는 방식으로 사용

-- COUNT() : 특정 조건에 해당하는 레코드의 갯수를 반환
SELECT COUNT(*) FROM sale;
SELECT COUNT(*) FROM sale WHERE amount >= 100000;
SELECT COUNT(amount) FROM sale WHERE amount >= 100000;

-- SUM() : 특정 조건에 해당하는 컬럼의 값을 모두 더한 결과를 반환
SELECT SUM(amount) FROM sale;
SELECT SUM(amount) FROM sale WHERE employee_number = 1;

-- AVG() : 특정 조건에 해당하는 컬럼의 값의 평균을 반환
SELECT AVG(amount) FROM sale;
SELECT AVG(amount) FROM sale WHERE employee_number = 1;

-- MIN(), MAX() : 특정 조건에 해당되는 컬럼의 값의 최대 or 최소 값을 반환
SELECT MIN(amount), MAX(amount) FROM sale;
SELECT MIN(amount), MAX(amount) FROM sale WHERE employee_number = 1;

-- 그룹화 (GROUP BY) : 조회 결과에 대해 레코드를 하나 이상의 컬럼
-- 일반적으로 집계함수와 같이 사용됨
SELECT MIN(amount), MAX(amount), employee_number
FROM sale
GROUP BY employee_number;
-- 각각 직원 번호 1, 2, 3번인 직원의 매출 최솟값과 최댓값이 출력됨

-- 집계함수, 그룹화가 되어잇는 쿼리에서는 그룹화한 컬럼과 집계 함수를 제외한 컬럼은 SELECT 절에서 선택 불가능
SELECT MIN(amount), MAX(amount), date
FROM sale
GROUP BY employee_number;
-- Error 1055 : 그룹화 GROUP BY가 되어있는 컬럼 employee_number와 MIN(), MAX() 집계함수로 지정되어 있는 컬럼 amount만 호출할 수 있음
-- date는 그룹화도, 집계함수로 지정되지도 않았으니 반환이 불가능

SELECT MIN(amount), MAX(amount), employee_number, date
FROM sale
GROUP BY employee_number, date;
-- 작동함 : employee_number와 date가 그룹화(GROUP BY) 되었으므로 반환 가능

-- 필터링 (HAVING) : 그룹화된 결과에 필터 작업을 수행
-- 결과 및 사용법이 WHERE 절과 비슷하게 보이지만, WHERE 절은 조회할 때 사용, HAVING 절은 조회 후에 사용
SELECT
MIN(amount) '최소',
MAX(amount) '최대',
employee_number '사번'
FROM sale
-- WHERE employee_number = 1
GROUP BY employee_number
HAVING employee_number = 1
;
-- employee_number의 그룹화 이후 employee_number가 1인 직원의 매출 최댓값과 최솟값, 사원번호가 반환됨

SELECT
MIN(amount) '최소',
MAX(amount) '최대',
employee_number '사번'
FROM sale
-- WHERE date = '2025-01-20'
GROUP BY employee_number
HAVING date = '2025-01-20'
;
-- Error 1054 : 이미 GROUP BY를 통해 employee_number만 그룹화한 상황이므로 HAVING으로 date를 필터링할려고 해도 date 컬럼을 출력할 수 없음