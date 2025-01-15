-- 축구 경기 데이터베이스 (footer_ball)

-- 참가팀(team) [국가명(nation), 조(seed), 감독(manager), 피파랭킹(lanking)]
-- 선수(player) [이름(name), 생년월일(birth), 포지션(position), 등번호(uniform_number), 국가(country)]
-- 경기장(stadium) [이름(name), 주소(address), 좌석(seats)]
-- 심판(referee) [이름(name), 생년월일(birth), 국가(country), 포지션(position)]

-- 사용자1 : football_developer @ %  / foot!@
-- 사용자2 : football_broadcast @ % / foot#$

-- 참가팀 [대한민국, A, 홍길동, 30]
-- 선수 [이성계, 19, 1998-01-15, 공격수, 10, 대한민국]
-- 경기장 [한양메인스타디움, 대한민국 서울특별시 강남구, 2000]
-- 심판 [이방원, 1994-06-08, 대한민국, 주심]

CREATE DATABASE footer_ball;
USE footer_ball;
CREATE TABLE team (
nation VARCHAR(15),
seed VARCHAR(3),
manager VARCHAR(45),
lanking INT
);
CREATE TABLE player (name VARCHAR(100), birth VARCHAR(10), position VARCHAR(12), uniform_number INT, country VARCHAR(60));
CREATE TABLE stadium (name VARCHAR(30), address TEXT, seats INT);
CREATE TABLE referee (name VARCHAR(100), birth VARCHAR(10), country VARCHAR(60), position VARCHAR(6));
CREATE USER 'football_developer'@'%' IDENTIFIED BY 'foot!@';
CREATE USER 'football_broadcast'@'%' IDENTIFIED BY 'foot#$';
ALTER TABLE player MODIFY COLUMN birth DATE;
ALTER TABLE referee CHANGE birth birth DATE;