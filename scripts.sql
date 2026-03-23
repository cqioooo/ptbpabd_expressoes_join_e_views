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
    t.ID, 
    t.course_id, 
    t.sec_id, 
    t.semester, 
    t.year, 
    (c.credits * gp.points) AS total_course_points
FROM 
    takes t
JOIN 
    course c ON t.course_id = c.course_id
JOIN 
    grade_points gp ON t.grade = gp.grade;

5° Questão:

CREATE VIEW coeficiente_rendimento AS
SELECT 
    t.ID, 
    s.name,
    SUM(c.credits * gp.points) AS total_points,
    SUM(c.credits) AS total_credits_attempted,
    -- Opcional: Cálculo da média (CR)
    CASE 
        WHEN SUM(c.credits) > 0 THEN SUM(c.credits * gp.points) / SUM(c.credits)
        ELSE 0 
    END AS gpa
FROM 
    takes t
JOIN 
    student s ON t.ID = s.ID
JOIN 
    course c ON t.course_id = c.course_id
JOIN 
    grade_points gp ON t.grade = gp.grade
GROUP BY 
    t.ID, s.name;