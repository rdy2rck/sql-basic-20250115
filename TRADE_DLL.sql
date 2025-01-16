USE practice_sql;

-- 거래내역 테이블
-- 거래번호 정수(INT)
-- 거래일자 날짜(DATE)
-- 거래구분 가변문자열 10자리(VARCHAR(10))
-- 내역 장문의문자열(TEXT)
-- 금액 실수(FLOAT)
-- 세금 실수(FLOAT)
-- 비고 장문의문자열(TEXT)

CREATE TABLE trade (
trade_number INT,
trade_date DATE,
trade_type VARCHAR(10),
trade_log TEXT,
amount FLOAT,
tax FLOAT,
note TEXT
);

INSERT INTO trade VALUES (1, '2025-01-16', '구매', '기타자재', 100000, 10000, null);

INSERT INTO trade VALUES (2, '2025-01-16', '판매', '영양제', 70000, 7000, '종합 비타민');

INSERT INTO trade VALUES (3, '2025-01-17', '판매', '영양제', 120000, 12000, '종합 비타민');

INSERT INTO trade VALUES (4, '2025-01-17', '구매', '책상', 400000, 40000, '4개 구매');

INSERT INTO trade VALUES (5, '2025-01-17', '구매', '의자', 200000, 20000, '4개 구매');

INSERT INTO trade VALUES (6, '2025-01-20', '판매', '의약품', 100000, 10000, '소염진통제');

INSERT INTO trade VALUES (7, '2025-01-20', '판매', '의약품', 50000, 5000, '소염진통제');

INSERT INTO trade VALUES (8, '2025-01-21', '구매', '기타자재', 10000, 1000, '볼펜 및 노트');

INSERT INTO trade VALUES (9, '2025-01-24', '판매', '의료기기', 800000, 80000, '휠체어');

INSERT INTO trade VALUES (10, '2025-01-25', '판매', '의료기기', 50000, 5000, '체온계');

SELECT * FROM trade;

-- 연산자

-- 산술 연산자
-- +, -, *, /, %
SELECT amount + tax FROM trade;

-- 비교 연산자
-- 좌항과 우항을 비교
-- WHERE 절에서 자주 사용됨, 원하는 레코드를 정확히 조회하는 데 중요한 역할을 수행함

-- = : 좌항과 우항이 같으면 true 반환
SELECT * FROM trade WHERE trade_type = '구매';

-- <> & != : 좌항과 우항이 다르면 true 반환
SELECT * FROM trade WHERE trade_type <> '판매';
SELECT * FROM trade WHERE trade_type != '구매';

ALTER TABLE trade ADD complete boolean;

SELECT * FROM trade;

UPDATE trade SET complete = true WHERE (trade_number % 3) = 1;

UPDATE trade SET complete = false WHERE (trade_number % 3) = 2;

UPDATE trade SET note = null WHERE trade_number = 6;

-- <=> : 좌항이 우항과 모두 null이면 true 반환
SELECT * FROM trade WHERE note <=> complete;

-- IS : 좌항과 우항이 같으면 true (키워드)
-- IS NOT : 좌항과 우항이 다르면 true (키워드)
SELECT * FROM trade WHERE complete IS TRUE;
SELECT * FROM trade WHERE complete IS NOT NULL;

-- BETWEEN min AND max : 좌항이 min보다 크거나 같으면서 max보다 작을 경우 true 반환
-- NOT BETWEEN min AND max : 좌항이 min보다 작거나 max보다 클 경우 true 반환
SELECT * FROM trade WHERE trade_date BETWEEN '2025-01-18' AND '2025-01-22';
SELECT * FROM trade WHERE amount NOT BETWEEN 70000 AND 200000;

-- IN() : 주어진 리스트 중에 하나라도 일치하면 true 반환
-- NOT IN() : 주어진 리스트 중에 하나라도 일치하지 않으면 true 반환
SELECT * FROM trade WHERE trade_log IN('영양제', '의약품');
SELECT * FROM trade WHERE trade_log NOT IN('영양제', '의약품');

-- 논리 연산자
-- AND, && : 좌항과 우항이 모두 true일 경우 true 반환
SELECT * FROM trade WHERE trade_type = '구매' AND amount > 100000;

-- OR, || : 좌항과 우항 중 하나라도 true일 경우 true 반환
SELECT * FROM trade WHERE trade_type = '구매' OR amount > 100000;

-- XOR : 좌항과 우항이 서로 다르면 true 반환
SELECT * FROM trade 
-- WHERE trade_date >= '2025-01-20' XOR trade_log = '기타자재';
WHERE trade_date >= '2025-01-20' AND trade_log != '기타자재'
OR trade_date < '2025-01-20' AND trade_log = '기타자재';

-- NOT, ! : 우항이 true면 false, false면 true
SELECT * FROM trade WHERE NOT (trade_type = '구매');

-- LIKE 연산자 : 문자열을 패턴으로 기준으로 비교하고자 할 때 사용
-- _ : 임의의 한 문자 표현
-- % : 임의의 문자 표현 (0 ~ 무한대)
SELECT * FROM trade WHERE trade_date LIKE '2025-01-__';
SELECT * FROM trade WHERE trade_date LIKE '2025-01-%';
SELECT * FROM trade WHERE trade_log LIKE '의_';
SELECT * FROM trade WHERE trade_log LIKE '의%';

-- 정렬
-- ORDER BY : 조회 결과를 특정 컬럼 기준으로 정렬
-- ASC : 오름차순(작은값 → 큰값) 정렬 / DESC : 내림차순(큰값 → 작은값) 정렬 (지정을 하지 않을 경우 자동으로 ASC 처리)
SELECT * FROM trade ORDER BY amount ASC;
SELECT * FROM trade ORDER BY amount DESC;
SELECT * FROM trade ORDER BY trade_type, amount DESC;

-- 중복제거
-- DISTINCT : SELECT 결과 테이블에서 컬럼 조합의 중복을 제거함
SELECT DISTINCT trade_type FROM trade;
SELECT DISTINCT trade_type, trade_log FROM trade;