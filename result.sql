CREATE DATABASE result;
USE result;

-- Create a different tables and insert data
CREATE TABLE students(
	student_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO students(student_id, name)
VALUES
(101, "Alice"),
(102, "Bob"),
(103, "Charlie"),
(104, "Dom"),
(105, "Rob"),
(106, "Tom"),
(107, "Janie"),
(108, "Alexa"),
(109, "Roman"),
(110, "David");


CREATE TABLE physics(
	student_id INT,
    physics_marks INT,
    FOREIGN KEY(student_id) REFERENCES students(student_id)
);

INSERT INTO physics(student_id, physics_marks)
VALUES
(101, 45),
(102, 53),
(103, 38),
(104, 70),
(105, 38),
(106, 82),
(107, 48),
(108, 63),
(109, 52),
(110, 49);

CREATE TABLE chemistry(
	student_id INT,
    chemistry_marks INT,
    FOREIGN KEY(student_id) REFERENCES students(student_id)
);

INSERT INTO chemistry(student_id, chemistry_marks)
VALUES
(101, 42),
(102, 57),
(103, 27),
(104, 60),
(105, 30),
(106, 49),
(107, 40),
(108, 51),
(109, 42),
(110, 38);

CREATE TABLE maths(
	student_id INT,
    maths_marks INT,
    FOREIGN KEY(student_id) REFERENCES students(student_id)
);

INSERT INTO maths(student_id, maths_marks)
VALUES
(101, 50),
(102, 61),
(103, 38),
(104, 68),
(105, 40),
(106, 54),
(107, 48),
(108, 59),
(109, 46),
(110, 40);

-- Passed students in physics
SELECT * 
FROM students AS s
INNER JOIN physics AS p
ON s.student_id = p.student_id
WHERE p.physics_marks >= 40
ORDER BY p.physics_marks DESC;

-- Count the passed student in physics
SELECT COUNT(p.student_id) 
FROM physics AS p
INNER JOIN students AS s ON s.student_id = p.student_id
WHERE p.physics_marks >= 40;

-- Passed student in Chemistry
SELECT * 
FROM students AS s
INNER JOIN chemistry AS c
ON s.student_id = c.student_id
WHERE c.chemistry_marks >= 40
ORDER BY c.chemistry_marks DESC;

-- Count the passed student in Chemistry
SELECT COUNT(c.student_id)
FROM chemistry AS c
INNER JOIN students AS s ON s.student_id = c.student_id
WHERE c.chemistry_marks >= 40;

-- Passed student in Maths
SELECT * 
FROM students AS s
INNER JOIN maths AS m
ON s.student_id = m.student_id
WHERE m.maths_marks >= 40
ORDER BY m.maths_marks DESC;

-- Count the passed student in Maths
SELECT COUNT(m.student_id) 
FROM maths AS m
INNER JOIN students AS s ON s.student_id = m.student_id
WHERE m.maths_marks >= 40;

-- Overall performance of students in all subjects (physics, chemistry, maths)
SELECT s.student_id, s.name, p.physics_marks, c.chemistry_marks, m.maths_marks,
		ROUND((p.physics_marks + c.chemistry_marks + m.maths_marks) / 3.0, 2) AS average_marks
FROM students AS s
INNER JOIN physics AS p ON s.student_id = p.student_id 
INNER JOIN chemistry AS c ON s.student_id = c.student_id
INNER JOIN maths AS m ON s.student_id = m.student_id;

-- Passed students
SELECT s.student_id, s.name, p.physics_marks, c.chemistry_marks, m.maths_marks,
		ROUND((p.physics_marks + c.chemistry_marks + m.maths_marks) / 3.0, 2) AS average_marks
FROM students AS s
INNER JOIN physics AS p ON s.student_id = p.student_id 
INNER JOIN chemistry AS c ON s.student_id = c.student_id
INNER JOIN maths AS m ON s.student_id = m.student_id
WHERE p.physics_marks >= 40
			AND 
			c.chemistry_marks >= 40
			AND 
			m.maths_marks >= 40;

-- Failed students
SELECT s.student_id, s.name, p.physics_marks, c.chemistry_marks, m.maths_marks
FROM students AS s
LEFT JOIN physics AS p ON s.student_id = p.student_id 
LEFT JOIN chemistry AS c ON s.student_id = c.student_id
LEFT JOIN maths AS m ON s.student_id = m.student_id
WHERE p.physics_marks < 40
		OR 
		c.chemistry_marks < 40
		OR 
		m.maths_marks < 40;

-- Failed in All three Subjects
SELECT s.student_id, s.name, p.physics_marks, c.chemistry_marks, m.maths_marks
FROM students AS s
LEFT JOIN physics AS p ON s.student_id = p.student_id 
LEFT JOIN chemistry AS c ON s.student_id = c.student_id
LEFT JOIN maths AS m ON s.student_id = m.student_id
WHERE p.physics_marks < 40
		AND 
		c.chemistry_marks < 40
		AND 
		m.maths_marks < 40;

-- Scholarship for the first three students according to their overall performance
SELECT s.student_id, s.name,
		ROUND((p.physics_marks + c.chemistry_marks + m.maths_marks) / 3.0, 2) AS average_marks
FROM students AS s
INNER JOIN physics AS p ON s.student_id = p.student_id
INNER JOIN chemistry AS c ON s.student_id = c.student_id
INNER JOIN maths AS m ON s.student_id = m.student_id
ORDER BY average_marks DESC
LIMIT 3;