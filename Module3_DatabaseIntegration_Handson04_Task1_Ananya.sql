USE college_db;
EXPLAIN FORMAT=JSON
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM enrollments e
JOIN students s
    ON s.student_id = e.student_id
JOIN courses c
    ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;
EXPLAIN
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM enrollments e
JOIN students s
    ON s.student_id = e.student_id
JOIN courses c
    ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;
/*
Task 1 Observation

EXPLAIN Results:
- Students table: Full Table Scan (type = ALL)
- Enrollments table: Index/Join scan
- Courses table: Primary key lookup

Rows examined:
(Check the "rows" column from your EXPLAIN output.)

Conclusion:
Since no index exists on students.enrollment_year,
MySQL performs a Full Table Scan to locate students enrolled in 2022.
*/