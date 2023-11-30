--12. Grades of students in a certain group in a certain subject in the last lesson.
WITH StudentGrades AS (
	SELECT st.group_id,
		sub.name AS subject, 
		g.grade_date,
		g.grade,
		max(g.grade_date) over (partition by st.group_id, sub.id) AS last_lesson_date
	FROM grades AS g
	JOIN students AS st ON st.id = g.student_id
	JOIN subjects AS sub ON sub.id = g.subject_id
	WHERE st.group_id = 1 -- The group for which you want to find the last grade
    	AND sub.id = 1) -- The subject for which you want to find the last grade
SELECT group_id, subject, grade_date, grade
FROM StudentGrades
WHERE grade_date = last_lesson_date;