SELECT c.course_name,
COUNT(e.enrollment_id) AS enrollment_count
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_name;
SELECT d.dept_name,
ROUND(AVG(p.salary),2) AS avg_salary
FROM departments d
LEFT JOIN professors p
ON d.department_id=p.department_id
GROUP BY d.dept_name;
SELECT dept_name,
budget
FROM departments
WHERE budget>600000;
SELECT grade,
COUNT(*) AS total_students
FROM enrollments e
JOIN courses c
ON e.course_id=c.course_id
WHERE c.course_code='CS101'
GROUP BY grade;
SELECT d.dept_name,
COUNT(e.enrollment_id) AS total_enrollments
FROM departments d
JOIN students s
ON d.department_id=s.department_id
JOIN enrollments e
ON s.student_id=e.student_id
GROUP BY d.dept_name
HAVING COUNT(e.enrollment_id)>2;
