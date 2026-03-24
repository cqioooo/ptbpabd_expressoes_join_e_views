1° Questão:

SELECT
i.ID, i.name, count (t.sec_ID) as Number_of_Sections
FROM
instructor i
FULL OUTER JOIN
teaches t ON i.ID = t.ID
GROUP BY
i.ID, i.name;

2° Questão:

SELECT
i.ID, i.name, (SELECT count (t.sec_ID) FROM teaches t WHERE i.ID = t.ID) as Number_of_Sections
FROM
instructor i;

3° Questão:

SELECT
s.course_ID, s.sec_ID, i.ID, s.semester, s.year, COALESCE(i.name, '-') AS name
FROM
section s
LEFT JOIN
teaches t ON s.course_id = t.course_id
AND s.sec_id = t.sec_id
AND s.semester = t.semester
AND s.year = t.year
LEFT JOIN
instructor i ON t.ID = i.ID
WHERE
s.semester = 'Spring' and s.year = 2010;

4° Questão:

SELECT
	s.ID,
	s.name,
	c.title,
	c.dept_name,
	t.grade,
	CASE
		WHEN t.grade = 'A+' THEN 4
		WHEN t.grade = 'A' THEN 3.7
		WHEN t.grade = 'A-' THEN 3.4
		WHEN t.grade = 'B+' THEN 3.1
		WHEN t.grade = 'B' THEN 2.8
		WHEN t.grade = 'B-' THEN 2.5
		WHEN t.grade = 'C+' THEN 2.2
		WHEN t.grade = 'C' THEN 1.9
		WHEN t.grade = 'C-' THEN 1.6
	END AS points,
	c.credits,
	(CASE
		WHEN t.grade = 'A+' THEN 4
		WHEN t.grade = 'A' THEN 3.7
		WHEN t.grade = 'A-' THEN 3.4
		WHEN t.grade = 'B+' THEN 3.1
		WHEN t.grade = 'B' THEN 2.8
		WHEN t.grade = 'B-' THEN 2.5
		WHEN t.grade = 'C+' THEN 2.2
		WHEN t.grade = 'C' THEN 1.9
		WHEN t.grade = 'C-' THEN 1.6
	END) * c.credits AS 'Pontos totais'
FROM
	takes t
JOIN
	student s ON t.ID = s.ID
JOIN
	course c ON t.course_id = c.course_id;

5° Questão:

CREATE VIEW 
	coeficiente_rendimento 
AS
(SELECT
	s.ID,
	s.name,
	c.title,
	c.dept_name,
	t.grade,
	CASE
		WHEN t.grade = 'A+' THEN 4
		WHEN t.grade = 'A' THEN 3.7
		WHEN t.grade = 'A-' THEN 3.4
		WHEN t.grade = 'B+' THEN 3.1
		WHEN t.grade = 'B' THEN 2.8
		WHEN t.grade = 'B-' THEN 2.5
		WHEN t.grade = 'C+' THEN 2.2
		WHEN t.grade = 'C' THEN 1.9
		WHEN t.grade = 'C-' THEN 1.6
	END AS points,
	c.credits,
	(CASE
		WHEN t.grade = 'A+' THEN 4
		WHEN t.grade = 'A' THEN 3.7
		WHEN t.grade = 'A-' THEN 3.4
		WHEN t.grade = 'B+' THEN 3.1
		WHEN t.grade = 'B' THEN 2.8
		WHEN t.grade = 'B-' THEN 2.5
		WHEN t.grade = 'C+' THEN 2.2
		WHEN t.grade = 'C' THEN 1.9
		WHEN t.grade = 'C-' THEN 1.6
	END) * c.credits AS 'Pontos totais'
FROM
	takes t
JOIN
	student s ON t.ID = s.ID
JOIN
	course c ON t.course_id = c.course_id);
