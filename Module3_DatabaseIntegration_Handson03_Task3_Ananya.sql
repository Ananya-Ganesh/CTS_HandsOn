DELIMITER $$

CREATE PROCEDURE sp_enroll_student(
    IN p_student_id INT,
    IN p_course_id INT,
    IN p_enrollment_date DATE
)
BEGIN

    IF EXISTS(
        SELECT *
        FROM enrollments
        WHERE student_id=p_student_id
        AND course_id=p_course_id
    )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Student already enrolled in this course';
    ELSE
        INSERT INTO enrollments(
            student_id,
            course_id,
            enrollment_date
        )
        VALUES(
            p_student_id,
            p_course_id,
            p_enrollment_date
        );
    END IF;

END $$

DELIMITER ;
CALL sp_enroll_student(1,3,'2024-01-10');
CALL sp_enroll_student(1,3,'2024-01-10');
CREATE TABLE department_transfer_log
(
    transfer_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    old_department INT,
    new_department INT,
    transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER $$

CREATE PROCEDURE sp_transfer_student(
    IN p_student_id INT,
    IN p_new_department INT
)
BEGIN

    DECLARE old_dept INT;

    START TRANSACTION;

    SELECT department_id
    INTO old_dept
    FROM students
    WHERE student_id=p_student_id;

    UPDATE students
    SET department_id=p_new_department
    WHERE student_id=p_student_id;

    INSERT INTO department_transfer_log(
        student_id,
        old_department,
        new_department
    )
    VALUES(
        p_student_id,
        old_dept,
        p_new_department
    );

    COMMIT;

END $$

DELIMITER ;
CALL sp_transfer_student(1,2);
START TRANSACTION;

UPDATE students
SET department_id=999
WHERE student_id=2;

ROLLBACK;
SELECT *
FROM students
WHERE student_id=2;
START TRANSACTION;
INSERT INTO enrollments
(student_id,course_id,enrollment_date,grade)
VALUES
(9,1,'2024-01-01','A');
SAVEPOINT first_insert;
INSERT INTO enrollments
(student_id,course_id,enrollment_date,grade)
VALUES
(999,2,'2024-01-01','A');
ROLLBACK TO first_insert;
COMMIT;
SELECT *
FROM enrollments
WHERE student_id=9;
SELECT *
FROM enrollments
WHERE student_id = 1
AND course_id = 3;
CALL sp_enroll_student(9,2,'2024-01-10');
SELECT *
FROM enrollments
WHERE student_id = 9
AND course_id = 2;
