-- 1NF:
-- Every column stores atomic values only.
-- Example violation: storing multiple phone numbers in one field.

-- 2NF:
-- All non-key attributes depend on the full primary key.
-- In enrollments, student_id and course_id determine grade and enrollment_date.

-- 3NF:
-- No transitive dependencies exist.
-- dept_name is stored only in departments table.
-- Storing dept_name in students would violate 3NF.