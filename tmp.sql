-- 제일 밑에줄에 query 있어야 실행됨.

--INSERT into Student values (111, 'jiho',4.9,1000);
--UPDATE Student set sid=100 where sid=123
-- set to valuse from Where value

-- get GPA &gt; 3.6인 id, name, gpa
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

-- str  patten
-- 거주 도시가 휴스턴, 텍사스인 모든 종업원
--WHERE ADDRESS LIKE '%휴스턴, 텍사스%'

-- bio 관련 학과에 지원한 학생의 id, major
-- 해당 자리에 제시한 char가 있는지 검색
-- SELECT sID, major
-- FROM Apply
-- WHERE major like 'C_'

-- 지원한 학생의 sid, name, gpa, uni name, uni's enrollment
-- SELECT Student.sID, Student.sName, Student.GPA, College.cName, College.enrollment
-- from Student, Apply, College
-- WHERE Student.sID = Apply.sID AND Apply.cName = College.cName

-- "productX" 프로젝트에 참여가는 모든 사원의 급여를 10% 올린 경우의 급여를 검색하라