-- edit 시도
--INSERT into Student values (111, 'jiho',4.9,1000);
--UPDATE Student set sid=100 where sid=123
-- set to valuse from Where value

-- get GPA > 3.6인 id, name, gpa
-- SELECT sID, sName, GPA
-- FROM Student
-- WHERE GPA>3.6

-- cs에 합격한 학생의 id
-- SELECT sID
-- from Apply
-- where decision='Y' AND major='CS'

-- JOIN
-- SELECT *
-- from Student, Apply
-- WHERE Student.sID = Apply.sID

-- 지원한 학생의 sid, name, gpa, uni name, uni's enrollment
-- SELECT Student.sID, Student.sName, Student.GPA, College.cName, College.enrollment
-- from Student, Apply, College
-- WHERE Student.sID = Apply.sID AND Apply.cName = College.cName

-- str  patten
-- 거주 도시가 휴스턴, 텍사스인 모든 종업원
--WHERE ADDRESS LIKE '%휴스턴, 텍사스%'

-- bio 관련 학과에 지원한 학생의 id, major
-- 해당 자리에 제시한 char가 있는지 검색
-- SELECT sID, major
-- FROM Apply
-- WHERE major like 'C_'

-- QUERY 결과의 sort
-- DESC : descending (Z - A)
-- ASC : Ascending (A- Z)
-- ex) ORDER BY DNAME, LNAME ASC, FNAME ASC
-- SELECT 
-- FROM
-- WHERE
-- ORDER BY 

-- alias : sub name
-- rename 2번 쓴 것. can't replacable
-- FROM EMPLOYEE E, EMPLOYEE S
-- FROM EMPLOYEE AS E(FN, MI, LN, ~~~~~~~~~~~~~)

-- scaledGPA를 구하시오
-- SELECT sID, sName, GPA, sizeHS, GPA*(sizeHS/1000) as scaledGPA
-- FROM Student

-- rename 써서 3개의 조인 출력
-- SELECT S.sID, S.GPA, A.cName, C. enrollment
-- FROM Student AS S, Apply AS A, College AS C
-- WHERE S.sID = A.sID AND A.cName = C.cName

-- gpa가 같은 학생의 쌍
 -- 학생1의 id, name, 학생2의 id, name, GPA
--  SELECT s1.sID, s1.sName, s2.sID, s2.sName, s1.GPA
--  FROM Student AS S1, Student AS S2
--  WHERE S1.GPA = S2.GPA AND S1.sID < S2.sID
--  ORDER BY S1.sID ASC;

-- 집합
-- (____) UNION (_____)
-- 자동으로 중복 제거함.
-- SELECT sName AS NAME FROM Student
-- UNION
-- SELECT cName AS NAME FROM College
-- ORDER BY NAME;

-- CS, EE에 모두 지원한 학생 id
-- SELECT sID AS NAME
-- FROM Apply
-- WHERE major='CS'
-- UNION
-- SELECT sID AS NAME
-- FROM Apply
-- WHERE major='EE'

-- SELECT DISTINCT A1.sID
-- FROM Apply AS A1, Apply AS A2
-- WHERE A1.sID = A2.sID AND A1.major='CS' AND A2.major='EE' 


-- cs에는 지원하고 ee에는 지원하지 않은 학생들
-- SELECT sID AS NAME
-- FROM Apply
-- WHERE major='CS'
-- EXCEPT
-- SELECT sID AS NAME
-- FROM Apply
-- WHERE major='EE'

-- Thu Nov 16
-- CS에 지원한 학생의 ID, name을 구하시오 WITH JOIN
-- SELECT DISTINCT Student.sID,Student. sName
-- FROM Apply, Student
-- WHERE Apply.sID = Student.sID

-- CS에 지원한 학생의 ID, name을 구하시오 WITHOUT JOIN
-- 중첩질의
-- SELECT sID, sName
-- FROM Student
-- WHERE	sID IN (SELECT sID FROM Apply WHERE major='CS')

-- CS에 지원한 학생의 GPA WITH JOIN -- 7개 출력, DISTINCT하면 오히려 4개가 되어버림 ; sID가 아니라 GPA같은 경우를 지워버림
-- SELECT Student.GPA
-- FROM Student, Apply
-- WHERE Student.sID = Apply.sID AND Apply.major = 'CS'


-- CS에 지원한 학생의 GPA WITHOUT JOIN -- 5개 출력; DISTINCT 이후 4개. 
-- SELECT DISTINCT GPA
-- FROM Student
-- WHERE sID IN (SELECT sID FROM Apply WHERE major = 'CS')

-- CS에는 지원하고, EE에는 지원하지 않은 학생의 sID, sName with EXCEPT
-- SELECT Student.sID, Student.sName
-- FROM Student, Apply
-- WHERE Apply.major='CS'  AND Student.sID = Apply.sID
-- EXCEPT -- 자동으로 중복 제거됨
-- SELECT Student.sID, Student.sName
-- FROM Student, Apply
-- WHERE Apply.major='EE'  AND Student.sID = Apply.sID

-- CS에는 지원하고, EE에는 지원하지 않은 학생의 sID, sName with in or not in
-- SELECT sID, sName
-- FROM Student
-- WHERE sID 
-- IN (SELECT sID FROM Apply WHERE major='CS') AND
-- sID NOT IN (SELECT sID FROM Apply WHERE major='EE')

-- same state에 다른 대학이 있는 대학의 이름과 state
-- SELECT cName, state
-- FROM College C1
-- WHERE EXISTS (
-- 	SELECT * 
-- 	FROM College	C2
-- 	WHERE C1.state = C2.state AND C1.cName <> C2.cName
-- 	-- <> : not equal
-- 	)
-- 	-- not EXISTS 하면, 반대 쌍인 대학이 나옴

-- College's enrollment가 가장많은 대학의 이름
-- SELECT cName
-- FROM College as c1
-- WHERE NOT EXISTS (
-- 	SELECT *
-- 	FROM College as c2
-- 	WHERE c1.enrollment < c2.enrollment
-- 	)

--- GPA가 가장 높은 학생의 이름과 GPA
-- SELECT  sName, GPA, sID
-- FROM Student as s1
-- WHERE NOT EXISTS(
-- 	SELECT *
-- 	FROM Student as s2
-- 	WHERE s1.GPA < s2.GPA
-- 	)

-- 모든 학생의 gpa의 평균을 구하시오
-- SELECT avg(GPA), max(GPA), min(GPA), sum(GPA)
-- FROM Student

-- CS지원자 중 성적 제일 낮은 GPA
-- SELECT min(Student.GPA)
-- FROM Apply, Student
-- WHERE Apply.sID = Student.sID AND Apply.major = 'CS'

-- 2023.11.22
-- 2명 이상의 부양가족을 갖는 직원의 이름을 찾는 쿼리
-- SELECT LNAME, FNAME
-- FROM EMPLOYEE
-- WHERE(SELECT COUNT(*) FROM DEPENDENT WHERE SSN=ESSN)>=2

-- CS 에 지원한 학생 중 가장 낮은 gpa
-- SELECT min(GPA)
-- FROM Student, Apply
-- WHERE Student.sID = Apply.sID AND Apply.major='CS'

-- cs에 지원한 학생의 gpa 평균
-- SELECT avg(gpa)
-- from (SELECT DISTINCT sName, GPA, major
-- FROM Student, Apply
-- WHERE Student.sID = Apply.sID AND major = 'CS')

-- 등록학생이 15k보다 큰 대학의 숫자를 구하시오 (count)사용
-- SELECT count(ENROLLMENT)
-- FROM(
-- SELECT enrollment
-- FROM College
-- WHERE enrollment>15000)

-- 'cornell'대학에 지원한 학생의 숫자
-- SELECT COUNT(sid)
-- FROM (
-- SELECT DISTINCT sID
-- FROM Apply
-- WHERE cName='Cornell')

-- 각 대학별로 지원 수를 구하시오
-- SELECT cName, count(*)
-- FROM Apply
-- GROUP by	cName

-- 각 state별로 등록생 수의 합
-- SELECT state, sum(enrollment)
-- FROM College
-- GROUP by state

-- 대학, 전공 별로 지원자의 최대 GPA,  최소 GPA를 구하시오
-- SELECT cName, major, max(gpa), min(gpa), avg(gpa)
-- FROM Apply, Student
-- WHERE Apply.sID = Student.sID
-- GROUP by cName, major

-- 각 학생id, 이름,  지원한 대학의 숫자를 구하시오
-- 이건 동일 대학 을 다른 것으로 인식해버림.
-- SELECT Apply.sID, Student.sName, count(*)
-- FROM Apply, Student
-- WHERE Apply.sID = Student.sID
-- GROUP by  Apply.sID

-- SELECT Student.sID, sName, count(DISTINCT CNAME) 
-- FROM Student, Apply
-- WHERE Student.sID = Apply.sID
-- GROUP BY Student.sID
-- UNION
-- SELECT sID, sName, 0
-- FROM Student
-- WHERE sID not in (SELECT sID FROM Apply)

-- 지원서의 숫자가 5보다 작은 대학의 이름을 구하시오
-- SELECT cName
-- FROM
-- (SELECT cName, count(*) as cnt
-- FROM Apply
-- GROUP by cName) as new
-- WHERE new.cnt < 5

-- SELECT cName, count(*)
-- FROM Apply
-- GROUP by cName
-- HAVING count(*) < 5

-- 지원학생이 5명 미만인 대학의 이름
-- SELECT cName, count(DISTINCT sID)
-- FROM Apply
-- GROUP by cName
-- HAVING count(DISTINCT sID)< 5

-- null 찾기
-- WHERE sname is NULL

-- INSERT INTO Student VALUES (431, 'kevin', NULL, 1500);
-- INSERT INTO Student VALUES (432, 'junsick', NULL, 2500);
------------------------------------------------------------------------------------------------------------------------------------------------------
-- GPA가 3.5이상인 sid, sname, GPA
-- SELECT sID, sName, GPA
-- FROM Student
-- WHERE GPA < 3.5
-- UNION
-- SELECT sID, sName, GPA
-- FROM Student
-- WHERE GPA >= 3.5
------------------------------------------------------------------------------------------------------------------------------------------------------
-- SELECT sID, sName, GPA
-- FROM Student
-- WHERE GPA >= 3.5 or GPA < 3.5 or GPA is NULL

-- DELETE 
-- FROM Student
-- WHERE GPA is NULL

-- INSERT into College VALUES ('CMU', 'PA', 11500)
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 어느 대학에도 지원하지 않은 학생의 sID를 구한 뒤, cmu - cs에 지원했는데 결과는 정해지지 않음을 Apply 에 추가

-- INSERT into Apply VALUES(
-- 	(SELECT sID
-- 	FROM Student
-- 	WHERE sID not in (SELECT sID FROM Apply))
-- 	, 'CMU', 'CS', NULL)

------------------------------------------------------------------------------------------------------------------------------------------------------
-- INSERT INTO Apply 
-- 	SELECT sID, 'CMU', 'CS', NULL
-- 	FROM Student
-- 	WHERE sID not in (SELECT sID FROM Apply)
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 다른 대학 ee에 지원했으나 떨어진 학생을 cmu ee에 합격한 것으로 처리하시오
-- SELECT sID, 'CMU', 'EE', 'Y'
-- FROM Student
-- WHERE sID not in (SELECT sID FROM Apply WHERE decision = 'N' AND major = 'EE')
------------------------------------------------------------------------------------------------------------------------------------------------------
--INSERT INTO Apply
--    SELECT sID, 'CMU', 'EE', 'Y'
--    FROM Apply
--    WHERE major= 'EE' AND decision = 'N';

------------------------------------------------------------------------------------------------------------------------------------------------------
-- DELETE 
-- FROM College
-- WHERE cName = 'CMU'
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2개 보다 많은 전공에 지원한 학생 Student에서 지우시오
-- DELETE
-- FROM Student
-- WHERE sID in 
-- (
-- 	SELECT sID
-- 	FROM Apply
-- 	GROUP by sID
-- 	HAVING count(distinct major) > 2
-- )

------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE Student
-- SET sID = '111'
-- WHERE sName = 'Bob'
------------------------------------------------------------------------------------------------------------------------------------------------------
-- cs에 지원하고 합격한 사람의 id, 대학이름을 구하시오
-- CREATE VIEW CSaccept as 
-- 	SELECT sID, cName
-- 	FROM Apply
-- 	WHERE major = 'CS' AND decision = 'Y'

------------------------------------------------------------------------------------------------------------------------------------------------------
-- the sid, sname, gpa of stanford & CS = Y & GPA > 3.8
-- SELECT Student.sID, CSaccept.cName, Student.GPA
-- FROM CSaccept, Student
-- WHERE Student.GPA < 3.8 AND cName = 'Stanford' AND Student.sID = CSaccept.sID

-- SELECT Student.sID, CSaccept.cName, Student.GPA
-- FROM Student, 
-- (
-- 	SELECT sID, cName
-- 	FROM Apply
-- 	WHERE major = 'CS' AND decision = 'Y'
-- 
-- ) as CSaccept
-- WHERE Student.GPA < 3.8 AND cName = 'Stanford' AND Student.sID = CSaccept.sID

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Berkeley 대학에 합격한 학생의 sID
-- CREATE VIEW CSBerkAccept as
-- SELECT Student.sID, Student.sName, Student.GPA
-- FROM Student, Apply
-- WHERE Student.sID = Apply.sID AND Apply.cName = 'Berkeley' AND Apply.decision = 'Y'

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Berkeley CS = Y & GPA > 3.8
-- SELECT sID, sName, GPA
-- FROM Student, 
-- 	(SELECT sID, sName, GPA
-- 	FROM 
-- 		(SELECT sID, sName, cName
-- 		FROM Apply
-- 		WHERE major = 'CS' AND decision = 'Y' )as CSaccept
-- 	WHERE cName = 'Berkeley') as CSBerkAccept
-- WHERE GPA > 3.8

-- drop view CSBerkAccept3

--INSERT INTO CSaccept VALUES (491, 'dja', 'ddd')
-- result : can not modify csaccpet because it is a view

-- CREATE mega
-- CREATE VIEW Mega as
-- SELECT Student.sID, sName, GPA, sizeHS, College.cName, state, enrollment, major, decision
-- FROM Student, Apply, College
-- WHERE Student.sID = Apply.sID AND Apply.cName = College.cName

-- GPA > 3.5 , cs, enrollment > 15k인 학생의 sID, sName, cName
-- SELECT sID, sName, cName
-- FROM Mega
-- WHERE GPA > 3.5 AND major = 'CS' AND enrollment > 15000

-- DROP VIEW CSBerkAccept

