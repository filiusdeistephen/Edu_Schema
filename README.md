Educational Management System
This is a simple command-line based Educational Management System written in Python, utilizing MySQL for database management. The system allows users to manage courses, students, instructors, enrollments, assessments, and grades. Additionally, it supports the archiving of deleted entities for data integrity and auditing purposes.

Features
-> Courses Management
Add a course
Update course description
Remove a course (archived before deletion)
Search courses
Sort courses by start date

->Student Management
Add a student
Delete a student (archived before deletion)
View all students

-> Instructor Management
Add an instructor
Delete an instructor (archived before deletion)
View all instructors
Assign instructor to a course
View which instructor is assigned to which course

-> Enrollment Management
Enroll student to a course
Track student progress

-> Assessment Management
Create an assessment
Delete an assessment (archived before deletion)

->Grade Management
Add a grade
Delete a grade (archived before deletion)
View grades
Auditing and Data Integrity
Track recent deletions of courses, students, instructors, assessments, and grades.
Database Schema

-> The database consists of the following tables:
Courses
Students
Instructors
Enrollments
Assessments
Grades
Archive tables for each main entity to store deleted records DeletedItems table to log all deletions with timestamps

-> Prerequisites
Python 3.x
MySQL server
MySQL connector for Python (mysql-connector-python package)

-> Setup
Clone the repository:
git clone https://github.com/yourusername/edu-management-system.git
cd edu-management-system

Install required Python packages:
pip install mysql-connector-python

Set up the MySQL database with the necessary tables. You can use the following SQL script to create the schema:

CREATE DATABASE Edu_Schema;

USE Edu_Schema;

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    course_description TEXT,
    start_date DATE,
    end_date DATE
);

CREATE TABLE Courses_Archive (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    course_description TEXT,
    start_date DATE,
    end_date DATE
);

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    date_of_birth DATE
);

CREATE TABLE Students_Archive (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    date_of_birth DATE
);

CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    bio TEXT,
    experience INT
);

CREATE TABLE Instructors_Archive (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    bio TEXT,
    experience INT
);

CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATETIME,
    status ENUM('Enrolled', 'Completed', 'Dropped'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    assessment_name VARCHAR(255),
    assessment_type ENUM('Quiz', 'Assignment', 'Exam'),
    due_date DATE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Assessments_Archive (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    assessment_name VARCHAR(255),
    assessment_type ENUM('Quiz', 'Assignment', 'Exam'),
    due_date DATE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id INT,
    student_id INT,
    grade VARCHAR(10),
    feedback TEXT,
    FOREIGN KEY (assessment_id) REFERENCES Assessments(assessment_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE Grades_Archive (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id INT,
    student_id INT,
    grade VARCHAR(10),
    feedback TEXT,
    FOREIGN KEY (assessment_id) REFERENCES Assessments(assessment_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE DeletedItems (
    entity_type VARCHAR(50),
    entity_id INT,
    deletion_time DATETIME
);

Update the database connection settings in the Python script (host, database, user, password) to match your MySQL configuration.

-> Usage
Run the script:
python edu_management_system.py
Follow the on-screen prompts to manage courses, students, instructors, enrollments, assessments, grades, and view recent deletions.

Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.
