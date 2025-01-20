Use practice_sql;

-- 트랜잭션 (Transaction) : SQL의 작업 단위를 하나로 묶어서 처리하는 기능
-- 데이터 무결성을 보장, 잘못된 데이터 처리가 발생했을 때 롤백을 가능하게 해줌

-- ACID 특성
-- Atomicity (원자성) : 하나의 트랜잭션은 모두 성공하거나 모두 실패해야 함
-- Consistency (일관성) : 트랜잭션이 완료되면 데이터베이스 상태가 일관성을 유지해야 함
-- Isolation (독립성) : 하나의 트랜잭션은 다른 트랜잭션에 영향을 받지 않아야 함
-- Durability (지속성) : 트랜잭션이 성공적으로 완료되면 데이터는 영구히 저장되어야 함

-- START TRANSCTION : 트랜잭션
-- COMMIT : 트랜잭션의 변경 사항을 데이터베이스에 영구히 반영
-- ROLLBACK : 트랜잭션의 작업 내용을 이전 상태로 복원
-- SAVEPOINT : 트랜잭션 내부에서 롤백 시 돌아올 위치 지정
-- SET AUTOCOMMIT : 자동 커밋 (1: 활성화, 0: 비활성화)

CREATE USER 't_user'@'localhost' IDENTIFIED BY 'qwer1234';
GRANT ALL ON practice_sql.*TO 't_user'@'localhost';

START TRANSACTION;
UPDATE sale SET amount = 99999 WHERE sequence_number = 1;
SELECT * FROM sale;
ROLLBACK;
SAVEPOINT A;
UPDATE sale SET amount = 0 WHERE sequence_number = 2;
SELECT * FROM sale;
ROLLBACK TO A;
COMMIT;
SELECT * FROM sale;