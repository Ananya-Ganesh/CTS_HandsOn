USE college_db;

CREATE INDEX idx_students_enrollment_year
ON students(enrollment_year);
SHOW INDEX FROM students;
CREATE UNIQUE INDEX idx_unique_enrollment
ON enrollments(student_id, course_id);
SHOW INDEX FROM enrollments;
INSERT INTO enrollments
(student_id, course_id, enrollment_date, grade)
VALUES
(1,1,'2024-01-01','A');
CREATE INDEX idx_course_code
ON courses(course_code);
SHOW INDEX FROM courses;
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
/*
Task 2 Observation

Before Index:
- Students table performed a Full Table Scan (type = ALL).

After Index:
- MySQL uses idx_students_enrollment_year.
- The execution plan shows an index lookup instead of scanning the entire students table.
- The composite UNIQUE index prevents duplicate student-course enrollments.
- Query performance improves because fewer rows are scanned.
*/
CREATE INDEX idx_enrollment_grade_student
ON enrollments(grade, student_id);
SHOW INDEX FROM enrollments;
/*
Task 55 Observation

MySQL does not support partial indexes using WHERE conditions.
Instead, a regular composite index (grade, student_id) was created
to improve queries filtering on grade (including grade IS NULL).
*/