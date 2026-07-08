ALTER TABLE students
ADD phone_number VARCHAR(15);

ALTER TABLE courses
ADD maxi_seats INT DEFAULT 60;

ALTER TABLE enrollments
ADD CONSTRAINT check_grade
CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);

ALTER TABLE departments
CHANGE hod_name head_of_dept VARCHAR(100);

ALTER TABLE students
DROP COLUMN phone_number;
DESCRIBE departments;
DESCRIBE courses;
DESCRIBE students;
DESCRIBE enrollments;