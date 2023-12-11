-- 1. 테이블에 값 삽입; insert into (table) values (tuple)
-- INSERT into Student VALUES (264,' Jiho', 4.5, 3000)

-- 2. 간단한 조건문;
-- SELECT sID, sName, GPA
-- FROM Student
-- WHERE GPA > 3.6

-- 3. CS이고 합격한사람
-- SELECT distinct sName from Student, Apply
-- WHERE major='CS' and decision='Y' and Student.sID = Apply.sID

-- 4.이름에 j들어간 학생
-- select * from Student WHERE sName like '%J%'

-- 5. sid 끝자리가 9
-- select sid from student where sid like '__9'

-- 6. sort
-- SELECT * from Student order by sid ASC

-- 7. alias : 
-- select * from Student S
-- select s.sName as dja, sName, GPA, sizeHS from Student as s
-- select * from student s(idid, sName, GPA, sizeHS) 
-- 이거 왜 안됨?

-- 8. selete에서 산술연산
-- SELECT *, GPA*sizeHS/1000 as 'Scaled GPA'
-- from Student

-- 9. gpa 같은 순서쌍
-- SELECT DISTINCT s1.sName, s2.sName, s1.GPA, s2.GPA
-- from Student s1, Student s2
-- WHERE s1.GPA = s2.GPA  AND s1.sName < s2.sName
-- ORDER by s1.GPA

-- 10. 학교이름 + 학생이름 집합
-- union is not necessary ()
-- SELECT sName as name from Student union SELECT cName as name from College ORDER by name

-- 11. CS지원학생 + EE지원학생 
-- SELECT sID, sName from Student
-- WHERE sID in 
-- (SELECT sID from Apply where major='CS' UNION SELECT sID from Apply WHERE major='EE')

-- 12. CS지원한 학생을 WITHOUT JOIN
-- SELECT * from Student WHERE sID in (
-- SELECT sID FROM Apply WHERE major='CS')

-- CS에 지원한 학생들의 gpa만을 구할 때, DISTINCT하면 7개에서 5개가 돼야하는데 key기준이 아니라 4개 됨.
-- SELECT  GPA from Student, Apply 
-- WHERE Student.sID = Apply.sID and major='CS'

-- 이렇게 고쳐야 정상적으로 나옴
-- SELECT GPA from Student WHERE sID in (
-- SELECT distinct Student.sID from Student, Apply 
-- WHERE Student.sID = Apply.sID and major='CS')

-- 13. CS에는 지원하고 EE에는 지원하지 않은 학생의 sid, sName (use EXCEPT, 중복제거)
-- SELECT Student.sID, sName from Student, Apply  WHERE Student.sID = Apply.sID AND major='CS' 
-- except 
-- SELECT Student.sID, sName from Student, Apply  WHERE Student.sID = Apply.sID AND major='EE'

-- 14. CS에는 지원하고 EE에는 지원하지 않은 학생의 sid, sName (use not in )
-- 	SELECT distinct Student.sID, sName FROM Student, Apply
-- 	WHERE Student.sID=Apply.sID and major='CS' AND Student.sID not in 
-- 		(SELECT sID from Apply WHERE major='EE')

-- 	SELECT sid from Student WHERE
-- 	sid in (SELECT sid from Apply where major='CS') AND
-- 	sid not in (SELECT sID FROM Apply WHERE major='EE')

-- 15.  same state에 다른 대학이 있는 대학의 cName, state
-- SELECT c1.cName, c1.state from College c1, College c2
-- WHERE c1.cName != c2.cName AND c1.state = c2.state

-- 16. 학생 수 가장 많은 대학교
-- SELECT * from College WHERE enrollment in (SELECT max(enrollment) from College)

-- 17. gpa제일 높은 학생 찾기
-- -- 제일 높은 gpa찾아서 그 값을 가진 학생 return
-- SELECT * from Student where GPA is (SELECT max(gpa) from Student)
-- --더 높은 gpa를 가진 사람은 없다는 식
-- SELECT * from Student s1 WHERE not EXISTS(
-- SELECT * from Student s2 WHERE s1.GPA < s2.GPA)

-- 18. gpa 평균
-- SELECT avg(gpa) from Student

-- 19. CS 지원자중 gpa 꼴등
-- SELECT min(gpa), * from Student, Apply where major='CS' and Student.sID = Apply.sid

-- 20. gpa가 3.6이상인 학생 수
-- SELECT count(gpa) from Student WHERE gpa>=3.6

-- 21. 각 대학교 별 apply 건 수
-- SELECT cname, count(*)
-- from Apply
-- group by cName

-- 22. 각 state별 등록학생 수의 합
-- SELECT state, sum(enrollment)
-- from College
-- group by state

-- 23. 대학별의 전공별 지원자의 최대 및 최소 GPA -- 이거 어려움
-- SELECT cName, major, min(gpa), max(gpa) from Student, Apply
-- where Student.sID = Apply.sID 
-- group by cname, major
-- >>>이거틀렷음. 버클리 CS에서 반례나옴.

-- 24. 각 학생별 sID, sName과 지원한 총 원서 수
-- SELECT Student.sID, sName, count(*) from Apply, Student
-- where Student.sID = Apply.sID
-- group by Student.sID

-- 25. 각 학생별 sID, sName과 각 대학별 지원한 원서 수
-- SELECT Student.sID, sName, cName, count(*) from Student, Apply
-- WHERE Student.sID=Apply.sID
-- group by Student.sID, cName -- group by 2개로 해줘야함.

-- 26. 지원서의 숫자가 5보다 작은 대학의 이름
-- -- where은 return된 tuple에 대한 조건
-- SELECT cName, cnt 
-- from (SELECT cName, count(*) as cnt from Apply group by cName) 
-- where cnt < 5

-- -- having은 group에 대한 조건
-- SELECT cName, count(*)
-- FROM Apply
-- GROUP by cName
-- HAVING count(*) < 5

-- 27. applied sID 5명 이하인 학교이름 -- 지원서 수를 구할 떄 쓴 sid에 distinct 걸어야함. 타 전공 지원했기때문.
-- SELECT cName, count(distinct sid) from Apply group by cName having count(distinct sid)<5

-- 28. finding NULL
--  SELECT * from Student WHERE  sName is NOT NULL

-- 29. insert VALUES
-- insert into College values ('INU', 'IN', 20000)

-- 30. delete
-- insert into Student values ('544', 'Wns', 4.4, NULL)
-- delete from Student where sizeHS is NULL

-- 31. 어느 대학에도 지원하지 않은 학생의 정보
-- SELECT sID from Student 
-- where sID not in (SELECT sID from Apply)

-- 32. 어느 대학에도 지원하지 않은 학생을 강제로 CMU의 CS에 지원하고 decision은 null로 추가
-- DELETE from Apply WHERE decision is NULL
-- 	insert into Apply VALUES(
-- 	(SELECT sID FROM Student 
-- 	where sID not in (SELECT sID from Apply)),
-- 	 'CMU', 'CS', NULL)
-- 	 이거 하위쿼리 결과 head()한개만 실행됨. 결과대로 다 추가하려면 다른 방식으로 해야함.

-- 	 INSERT into Apply 
-- 		SELECT sID, 'CMU', 'CS', NULL
-- 		from Student
-- 		where sID not in (SELECT sID from Apply)
-- 	이렇게 실행해야 한 번에 다 들어감.
	
-- 33.  타 대학 EE에 지원했지만, 떨어진 사람을 cmu ee에 합격시키셈
-- insert into Apply
-- 	SELECT sID, 'CMU', 'EE', 'Y'
-- 	from Apply WHERE major='EE' and decision='N'

-- 34. 2개보다 많은 전공에 지원한 학생을 student에서 지우시오
-- DELETE from Student WHERE sid in (
-- SELECT sID , from Apply 
-- group by sID HAVING count(distinct major) >2)

-- 35. update
-- update Student set sid = 888  where sName = 'Gary'

-- 36. 이중쿼리 alias
-- 전체 cs합격생 중, 스탠포드 합격자 구하기
-- SELECT Student.sID, Student.sName from Student, 
-- 	(SELECT * from Apply WHERE major='CS' and decision = 'Y') as CSOK
-- WHERE CSOK.cName = 'Stanford'

-- 37. MIT 합격자 view 만들기
-- create view goMIT as 
-- SELECT Student.sID, sName, major from Student, Apply WHERE cName='MIT' and decision='Y'

-- 38. drop view; 
-- drop view gomit

-- 39. mega TABLE
-- CREATE view mega as
-- SELECT Student.sID, sName, College.cName, GPA, sizeHS, enrollment, major, decision
-- from Student, Apply, College
-- SELECT * from mega

-- 40. mit cs합격생구하기 
-- SELECT DISTINCT * from mega
-- WHERE cName= 'MIT' and decision= 'Y' and major='CS'



-- Path: studyfinalexam.sql
-- SELECT Student.sID, sName, count(*) from Apply, Student
-- where Student.sID = Apply.sID
-- group by Student.sID

-- 각 학생별 풀정보 및 지원한 원서 수
-- SELECT Student.sid, count(*)  from Student, Apply where Student.sID=Apply.sID group by Apply.sID

-- 각 학생의 학교별 지원원서 수 
-- SELECT Student.sID, sName, cName,  count(*) 
-- from Student, Apply
-- WHERE Student.sID=Apply.sID
-- group by Student.sID, cName

-- select s.sID as ooo, sName, GPA, sizeHS
-- from student as s, Apply
-- WHERE ooo = Apply.sID

-- stanford 합격자 평균 gpa보다 높은 gpa소유자
-- SELECT *  from Student 
-- where GPA > (	
-- 		SELECT avg(gpa) as avgpa from Student, Apply 
-- 		where Student.sID = Apply.sID AND cName='Stanford' and decision='Y')   		

-- 동명이인 중 더 높은 gpa가진사람의 sid, GPA
-- SELECT Student.sID, Student.sName, max(Student.GPA)
-- from Student
-- where Student.sName in
-- 	(SELECT s1.sName 
-- 	from Student s1, Student s2
-- 	WHERE s1.sName=s2.sName and s1.sID < s2.sID)
-- group by Student.sName


-- Apply 3회 이상 한 사람
-- SELECT sName, count(*)
-- from Student, Apply
-- WHERE Student.sID = Apply.sID
-- GROUP by Student.sID
-- having count(*)>2