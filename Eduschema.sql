Create database Edu_Schema;
use  Edu_Schema;
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT,
    start_date DATE,
    end_date DATE,
    course_status ENUM('Active', 'Inactive') DEFAULT 'Active',
    UNIQUE (course_name)
);
CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    bio TEXT,
    experience INT NOT NULL
);t
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE CourseInstructors (
    course_id INT,
    instructor_id INT,
    PRIMARY KEY (course_id, instructor_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Enrolled', 'Completed', 'Dropped') DEFAULT 'Enrolled',
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    assessment_name VARCHAR(100) NOT NULL,
    assessment_type ENUM('Quiz', 'Assignment', 'Exam') NOT NULL,
    due_date DATE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id INT,
    student_id INT,
    grade DECIMAL(5,2),
    feedback TEXT,
    graded_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assessment_id) REFERENCES Assessments(assessment_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE DeletedItems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type VARCHAR(50) NOT NULL,
    entity_id INT NOT NULL,
    deletion_time DATETIME NOT NULL
);


CREATE TABLE Courses_Archive (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    course_description TEXT,
    start_date DATE,
    end_date DATE,
    duration VARCHAR(50)
);

CREATE TABLE Students_Archive (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    date_of_birth DATE
);

CREATE TABLE Instructors_Archive (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    bio TEXT,
    experience INT
);

CREATE TABLE Assessments_Archive (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    assessment_name VARCHAR(255) NOT NULL,
    assessment_type VARCHAR(50),
    due_date DATE
);

CREATE TABLE Grades_Archive (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id INT NOT NULL,
    student_id INT NOT NULL,
    grade VARCHAR(10),
    feedback TEXT
);

------------------------------------------------------------------------------------------------------------------------
#inputing courses
INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Advanced SQL', 'Deep dive into SQL and database optimization', '2024-08-01', '2024-12-15');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Data Structures in Python', 'Learn about various data structures using Python', '2024-07-15', '2024-11-15');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Machine Learning Basics', 'Introduction to machine learning concepts and algorithms', '2024-09-01', '2025-01-31');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Web Development with JavaScript', 'Learn to build interactive websites using JavaScript', '2024-07-10', '2024-12-10');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Introduction to Data Science', 'Foundations of data science and data analysis', '2024-08-15', '2024-12-20');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Cloud Computing with AWS', 'Learn the basics of cloud computing and AWS services', '2024-10-01', '2025-03-01');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Cybersecurity Fundamentals', 'Introduction to cybersecurity principles and practices', '2024-07-20', '2024-11-20');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Project Management Essentials', 'Learn the fundamentals of project management', '2024-09-10', '2025-01-10');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Introduction to Artificial Intelligence', 'Basics of AI and its applications', '2024-08-01', '2024-12-01');

INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Database Design and Management', 'Comprehensive course on designing and managing databases', '2024-09-15', '2025-02-15');

select * from Courses

------------------------------------------------------------------------------------------------------------------------
#inserting  into instructors
INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Rajesh', 'Kumar', 'rajesh.kumar@gmail.com', 'Rajesh specializes in database management and SQL optimization.', 10);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Priya', 'Sharma', 'priya.sharma@gmail.com', 'Priya is an expert in Python programming and data structures.', 8);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Suresh', 'Gupta', 'suresh.gupta@gmail.com', 'Suresh has extensive experience in machine learning and AI.', 7);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Meera', 'Patel', 'meera.patel@gmail.com', 'Meera is skilled in web development and creating dynamic websites.', 6);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Prakash', 'Raj', 'prakash.shah@gmail.com', 'Prakash is a data scientist with expertise in data analysis and visualization.', 9);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Divya', 'Chopra', 'divya.chopra@gmail.com', 'Divya is a cloud computing specialist with proficiency in AWS services.', 5);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Karthik', 'Rao', 'karthik.rao@gmail.com', 'Karthik has a strong background in cybersecurity and information security.', 11);
INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Amit', 'Singh', 'amit.singh@gmail.com', 'Amit specializes in project management and has managed various successful projects.', 12);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Neha', 'Yadav', 'neha.yadav@gmail.com', 'Neha is an AI expert focusing on practical applications of artificial intelligence.', 7);

INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Vikram', 'Sharma', 'vikram.sharma@gmail.com', 'Vikram is proficient in database design and management.', 10);

select * from Instructors
#
------------------------------------------------------------------------------------------------------------------------
# insert into students

INSERT INTO Students (first_name, last_name, email, date_of_birth)
VALUES
    ('Yashas', 'Manjunath', 'yashas.manjunath@gmail.com', '1995-04-10'),
    ('Trush', 'shashank', 'trush.shashank@gmail.com', '1996-07-15'),
    ('Raghav', 'Dabral', 'raghav.dabral@gmail.com', '1997-09-21'),
    ('Priya', 'Singh', 'priya.singh@gmail.com', '1998-11-05'),
    ('Sanjay', 'Rao', 'sanjay.rao@gmail.com', '1999-02-18'),
    ('Arun', 'Kumar', 'arun.kumar@gmail.com', '1994-03-22'),
    ('Deepa', 'Menon', 'deepa.menon@gmail.com', '1995-06-30'),
    ('Ravi', 'Nair', 'ravi.nair@gmail.com', '1996-08-25'),
    ('Lakshmi', 'Iyer', 'lakshmi.iyer@gmail.com', '1997-11-12'),
    ('Suresh', 'Reddy', 'suresh.reddy@gmail.com', '1998-01-19');

select * from Students

------------------------------------------------------------------------------------------------------------------------
# Assign instructor to a course:

INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (1, 3);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (2, 7);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (3, 1);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (4, 6);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (5, 2);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (6, 9);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (7, 4);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (8, 10);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (9, 5);
INSERT INTO CourseInstructors (course_id, instructor_id) VALUES (10, 8);

select * from CourseInstructors

------------------------------------------------------------------------------------------------------------------------
# creating enrolments


INSERT INTO Enrollments (student_id, course_id, enrollment_date, status)
VALUES (1, 3, '2024-06-01 10:00:00', 'Enrolled');

INSERT INTO Enrollments (student_id, course_id, enrollment_date, status)
VALUES (2, 7, '2024-06-02 11:30:00', 'Completed');

INSERT INTO Enrollments (student_id, course_id, enrollment_date, status)
VALUES (3, 1, '2024-06-03 09:45:00', 'Dropped');

INSERT INTO Enrollments (student_id, course_id, enrollment_date, status)
VALUES (4, 6, '2024-06-04 14:20:00', 'Enrolled');

INSERT INTO Enrollments (student_id, course_id, enrollment_date, status)
VALUES (5, 2, '2024-06-05 16:50:00', 'Completed');

select * from Enrollments

------------------------------------------------------------------------------------------------------------------------

#adding Assingments

INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
VALUES (1, 'Quiz 1', 'Quiz', '2024-06-15');

INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
VALUES (2, 'Assignment 1', 'Assignment', '2024-06-20');

INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
VALUES (3, 'Midterm Exam', 'Exam', '2024-06-25');

INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
VALUES (4, 'Quiz 2', 'Quiz', '2024-07-01');

INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
VALUES (5, 'Final Project', 'Assignment', '2024-07-10');

INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
VALUES (7, 'mini Project', 'Assignment', '2024-07-30');

select * from Assessments

-----------------------------------------------------------------------------------------------------------------------

# Adding Grades

INSERT INTO Grades (assessment_id, student_id, grade, feedback)
VALUES (1, 1, 85.50, 'Good effort overall, but could improve on accuracy.');

INSERT INTO Grades (assessment_id, student_id, grade, feedback)
VALUES (4, 2, 92.75, 'Excellent work,');

select * from Grades

-----------------------------------------------------------------------------------------------------------------------

# -> Course managment
# (a) adding a course
INSERT INTO Courses (course_name, course_description, start_date, end_date)
VALUES ('Introduction Neural Networks', 'learn about the basics of neural networks ', '2024-10-01', '2025-03-01');

#(b) Updating a course
UPDATE Courses
SET course_description = 'learn basics of SQL'
WHERE course_id = 1;

#(c) Remove a course
DELETE FROM Courses
WHERE course_id = 12;

#(d) Search Courses
SELECT * FROM Courses
WHERE course_name LIKE '%Python%';

#(e) Sorting Courses
SELECT * FROM Courses
ORDER BY start_date DESC;

-----------------------------------------------------------------------------------------------------------------------

# -> Instructor Management

#(a) Adding Instructor
INSERT INTO Instructors (first_name, last_name, email, bio, experience)
VALUES ('Rahul', 'Ram', 'Rahul.ram@gmail.com', 'rahul is proficient in neural networks and management.', 4);

#(b) Assigning the Instructor to a course
INSERT INTO CourseInstructors (course_id, instructor_id)
VALUES (12, 11);

------------------------------------------------------------------------------------------------------------------------

#-> Student Enrolment

#(a) Enroll a student into a course
INSERT INTO Enrollments (student_id, course_id, enrollment_date, status)
VALUES (7, 5, '2024-06-05', 'Enrolled');

#(b) Track student progress
SELECT s.first_name, s.last_name, c.course_name, e.status
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_id = 1;

------------------------------------------------------------------------------------------------------------------------

# -> Assesments and Grades

#(a) Creating an Assesment
INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
VALUES (6, 'Quiz 3', 'Quiz', '2024-09-30');

#(b) Input Grades
INSERT INTO Grades (assessment_id, student_id, grade, feedback)
VALUES (6, 3, 98.25, 'Excellent work,');

#(c) View Grades
SELECT s.first_name, s.last_name, a.assessment_name, g.grade, g.feedback
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
JOIN Assessments a ON g.assessment_id = a.assessment_id
WHERE s.student_id = 1;

select * from DeletedItems
select * from Courses
select * from Courses_Archive
select * from Students
show tables
select * from Grades
select * from Assessments
select * from Instructors