# 1.Query the existence of 1 course
SELECT * FROM course WHERE id=1;

# 2.Query the presence of both 1 and 2 courses
SELECT * FROM course WHERE id=1 OR id=2;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
SELECT a.id, a.name, b.avg_score
FROM student AS a JOIN 
(SELECT studentId, AVG(score) AS avg_score 
FROM student_course 
GROUP BY studentId HAVING avg_score>60 OR avg_score=60) AS b
ON a.id = b.studentId;

# 4.Query the SQL statement of student information that does not have grades in the student_course table
SELECT DISTINCT id, name, age, sex
FROM student LEFT OUTER JOIN student_course ON student.id = student_course.studentId
WHERE student_course.score IS NULL;

# 5.Query all SQL with grades
SELECT DISTINCT id, name, age, sex
FROM student JOIN student_course ON student.id = student_course.studentId;

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
SELECT id, name, age, sex
FROM student JOIN student_course ON student.id = student_course.studentId
WHERE student.id=1 AND student_course.courseId=2;

# 7.Retrieve 1 student score with less than 60 scores in descending order
SELECT id, name, age, sex, score 
FROM student JOIN student_course ON student.id = student_course.studentId
WHERE score<60 OR score=60
ORDER BY score DESC LIMIT 1;

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
SELECT a.id, a.name, b.avg_score
FROM course AS a JOIN 
(SELECT courseId, AVG(score) AS avg_score 
FROM student_course 
GROUP BY courseId) AS b ON a.id = b.courseId
ORDER BY b.avg_score DESC, b.courseId ASC;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
SELECT a.name, b.score
FROM (student AS a JOIN student_course AS b ON a.id=b.studentId) JOIN course AS c ON b.courseId=c.id
WHERE c.name="Math" AND b.score<60;
