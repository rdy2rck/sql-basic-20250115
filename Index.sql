USE practice_sql;

-- 인덱스 (Index) : 테이블에서 원하는 컬럼을 빠르게 조회하기 위해 사용하는 구조

-- 인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(컬럼, ...);
CREATE INDEX trade_amount_idx ON transaction (amount);
CREATE INDEX trade_amount_tax_idx ON trade (amount, tax);
-- 입력 후 해당 테이블 오른쪽의 렌치 버튼을 누른 뒤 indexes 탭에서 확인
CREATE INDEX trade_tax_amount_idx ON trade (tax, amount);
-- 같은 이름을 가진 인덱스는 생성 불가능
CREATE INDEX trade_amount_desc_idx ON trade (amount DESC);
-- 기능 : 인덱스 결과를 내림차순 출력

-- UNIQUE나 PRIMARY KEY, FOREIGN KEY 제약설정을 걸 경우 해당 컬럼에는 인덱스가 자동으로 생성됨

-- 테이블에 인덱스 추가
-- ALTER TABLE 테이블명 ADD INDEX 인덱스이름(컬럼명);
ALTER TABLE employee ADD INDEX employee_name_idx (name);

-- CREATE INDEX ~ : 테이블 구조를 변경하지 않음
-- ALTER TABLE ~ : 테이블 구조를 변경함

-- 인덱스 삭제
-- DROP INDEX 인덱스명 ON 테이블명;
DROP INDEX trade_amount_desc_idx ON trade;

-- 테이블에서 인덱스 삭제
-- ALTER TABLE 인덱스명 DROP INDEX 인덱스명;
ALTER TABLE trade DROP INDEX trade_amount_idx;

-- 뷰 (VIew) : 물리적으로 존재하지 않는 읽기 전용의 가상 테이블
-- 조회문을 미리 작성해서 재사용하는 용도, 컬럼에 대한 제한된 보기를 제공하는 용도

-- 뷰 생성
-- CREATE VIEW 뷰이름 AS 조회문;
USE school;

CREATE VIEW class_summary AS SELECT
C.class_code '수업 코드',
C.name '수업 이름',
T.name '담당교사 이름',
T.position '담당교사 직급',
SUB.min '최저 점수',
SUB.max '최대 점수'
FROM class C
LEFT JOIN teacher T ON C.charge_teacher = T.teacher_number
LEFT JOIN (
SELECT 
class_code
MIN(score) 'min',
MAX(score) 'max'
FROM class_regist
GROUP BY class_code
) SUB
ON C.class_code = SUB.class_code;
-- 결과 : class 테이블의 class_code(수업 코드)와 name(수업 이름), class_regist 테이블의 score 테이블의 '최대 점수'와 score의 최솟값, teacher 테이블의 name(담당교사 이름)과 position(담당교사 직급) 컬럼을 출력하는 뷰 'class_summary' 생성

SELECT * FROM class_summary;
SELECT * FROM class_summary WHERE '최저 점수' >= 70;

-- VIEW는 물리적인 저장 공간이 존재하지 않기 때문에
-- INSERT, UPDATE, DELETE 및 INDEX 생성 불가능

-- 테이블 접근 및 컬럼 접근 권한에 대한 제어를 쉽게 할 수 있음
CREATE VIEW teacher_summary AS
SELECT teacher_number, name, position
FROM teacher;

SELECT * FROM teacher_summary;

GRANT SELECT
ON school.teacher_summary
TO 사용자@호스트명;
-- 사용자@호스트명에게 뷰 teacher_summary를 조회할 권한 부여

-- VIEW 수정
-- ALTER VIEW 뷰이름 AS 조회문 ~
ALTER VIEW teacher_summary AS
SELECT name, position
FROM teacher;
-- 뷰 teacher_summary가 name, position 컬럼만 조회하도록 변경

SELECT * FROM teacher_summary;

-- VIEW 삭제
-- DROP VIEW 뷰이름
DROP VIEW teacher_summary;