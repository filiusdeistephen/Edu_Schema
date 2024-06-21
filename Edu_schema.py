import mysql.connector
from mysql.connector import Error

def create_connection():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='Edu_Schema',
            user='root',
            password='root',
            auth_plugin='mysql_native_password'
        )
        if connection.is_connected():
            print("Connected to the database")
            return connection
    except Error as e:
        print("Error while connecting to MySQL", e)
        return None

def close_connection(connection):
    if connection.is_connected():
        connection.close()
        print("MySQL connection is closed")

def add_course(connection):
    cursor = connection.cursor()
    course_name = input("Enter course name: ")
    course_description = input("Enter course description: ")
    start_date = input("Enter start date (YYYY-MM-DD): ")
    end_date = input("Enter end date (YYYY-MM-DD): ")

    query = """INSERT INTO Courses (course_name, course_description, start_date, end_date)
               VALUES (%s, %s, %s, %s)"""
    values = (course_name, course_description, start_date, end_date)
    cursor.execute(query, values)
    connection.commit()
    print("Course added successfully!")

def update_course_description(connection):
    cursor = connection.cursor()
    course_id = input("Enter course ID to update: ")
    new_description = input("Enter new course description: ")

    query = """UPDATE Courses
               SET course_description = %s
               WHERE course_id = %s"""
    values = (new_description, course_id)
    cursor.execute(query, values)
    connection.commit()
    print("Course updated successfully!")

def remove_course(connection):
    cursor = connection.cursor()
    course_id = input("Enter course ID to remove: ")

    try:
        cursor.execute("""INSERT INTO Courses_Archive (course_name, course_description, start_date, end_date)
                          SELECT course_name, course_description, start_date, end_date FROM Courses WHERE course_id=%s""", (course_id,))
        cursor.execute("DELETE FROM Courses WHERE course_id=%s", (course_id,))
        cursor.execute("""INSERT INTO DeletedItems (entity_type, entity_id, deletion_time)
                          VALUES ('Course', %s, NOW())""", (course_id,))
        connection.commit()
        print("Course removed and archived successfully!")
    except Error as e:
        print(f"Error deleting course: {e}")

def search_courses(connection):
    cursor = connection.cursor()
    keyword = input("Enter keyword to search courses: ")

    query = "SELECT * FROM Courses WHERE course_name LIKE %s"
    cursor.execute(query, ("%" + keyword + "%",))
    results = cursor.fetchall()
    for row in results:
        print(row)

def sort_courses(connection):
    cursor = connection.cursor()

    query = "SELECT * FROM Courses ORDER BY start_date DESC"
    cursor.execute(query)
    results = cursor.fetchall()
    for row in results:
        print(row)

def add_student(connection):
    cursor = connection.cursor()
    first_name = input("Enter first name: ")
    last_name = input("Enter last name: ")
    email = input("Enter email: ")
    date_of_birth = input("Enter date of birth (YYYY-MM-DD): ")

    query = """INSERT INTO Students (first_name, last_name, email, date_of_birth)
               VALUES (%s, %s, %s, %s)"""
    values = (first_name, last_name, email, date_of_birth)
    cursor.execute(query, values)
    connection.commit()
    print("Student added successfully!")

def delete_student(connection):
    cursor = connection.cursor()
    student_id = input("Enter student ID to delete: ")

    try:
        cursor.execute("""INSERT INTO Students_Archive (first_name, last_name, email, date_of_birth)
                          SELECT first_name, last_name, email, date_of_birth FROM Students WHERE student_id=%s""", (student_id,))
        cursor.execute("DELETE FROM Students WHERE student_id=%s", (student_id,))
        cursor.execute("""INSERT INTO DeletedItems (entity_type, entity_id, deletion_time)
                          VALUES ('Student', %s, NOW())""", (student_id,))
        connection.commit()
        print("Student removed and archived successfully!")
    except Error as e:
        print(f"Error deleting student: {e}")

def add_instructor(connection):
    cursor = connection.cursor()
    first_name = input("Enter first name: ")
    last_name = input("Enter last name: ")
    email = input("Enter email: ")
    bio = input("Enter bio: ")
    experience = input("Enter experience (in years): ")

    query = """INSERT INTO Instructors (first_name, last_name, email, bio, experience)
               VALUES (%s, %s, %s, %s, %s)"""
    values = (first_name, last_name, email, bio, experience)
    cursor.execute(query, values)
    connection.commit()
    print("Instructor added successfully!")

def delete_instructor(connection):
    cursor = connection.cursor()
    instructor_id = input("Enter instructor ID to delete: ")

    try:
        cursor.execute("""INSERT INTO Instructors_Archive (first_name, last_name, email, bio, experience)
                          SELECT first_name, last_name, email, bio, experience FROM Instructors WHERE instructor_id=%s""", (instructor_id,))
        cursor.execute("DELETE FROM Instructors WHERE instructor_id=%s", (instructor_id,))
        cursor.execute("""INSERT INTO DeletedItems (entity_type, entity_id, deletion_time)
                          VALUES ('Instructor', %s, NOW())""", (instructor_id,))
        connection.commit()
        print("Instructor removed and archived successfully!")
    except Error as e:
        print(f"Error deleting instructor: {e}")

def assign_instructor_to_course(connection):
    cursor = connection.cursor()
    course_id = input("Enter course ID: ")
    instructor_id = input("Enter instructor ID: ")

    query = """INSERT INTO CourseInstructors (course_id, instructor_id)
               VALUES (%s, %s)"""
    values = (course_id, instructor_id)
    cursor.execute(query, values)
    connection.commit()
    print("Instructor assigned to course successfully!")

def enroll_student_to_course(connection):
    cursor = connection.cursor()
    student_id = input("Enter student ID: ")
    course_id = input("Enter course ID: ")
    enrollment_date = input("Enter enrollment date (YYYY-MM-DD HH:MM:SS): ")
    status = input("Enter status (Enrolled/Completed/Dropped): ")

    query = """INSERT INTO Enrollments (student_id, course_id, enrollment_date, status)
               VALUES (%s, %s, %s, %s)"""
    values = (student_id, course_id, enrollment_date, status)
    cursor.execute(query, values)
    connection.commit()
    print("Student enrolled in course successfully!")

def track_student_progress(connection):
    cursor = connection.cursor()
    student_id = input("Enter student ID to track: ")

    query = """SELECT s.first_name, s.last_name, c.course_name, e.status
               FROM Enrollments e
               JOIN Students s ON e.student_id = s.student_id
               JOIN Courses c ON e.course_id = c.course_id
               WHERE s.student_id = %s"""
    cursor.execute(query, (student_id,))
    results = cursor.fetchall()
    for row in results:
        print(row)

def create_assessment(connection):
    cursor = connection.cursor()
    course_id = input("Enter course ID: ")
    assessment_name = input("Enter assessment name: ")
    assessment_type = input("Enter assessment type (Quiz/Assignment/Exam): ")
    due_date = input("Enter due date (YYYY-MM-DD): ")

    query = """INSERT INTO Assessments (course_id, assessment_name, assessment_type, due_date)
               VALUES (%s, %s, %s, %s)"""
    values = (course_id, assessment_name, assessment_type, due_date)
    cursor.execute(query, values)
    connection.commit()
    print("Assessment created successfully!")

def delete_assessment(connection):
    cursor = connection.cursor()
    assessment_id = input("Enter assessment ID to delete: ")

    try:
        cursor.execute("""INSERT INTO Assessments_Archive (course_id, assessment_name, assessment_type, due_date)
                          SELECT course_id, assessment_name, assessment_type, due_date FROM Assessments WHERE assessment_id=%s""", (assessment_id,))
        cursor.execute("DELETE FROM Assessments WHERE assessment_id=%s", (assessment_id,))
        cursor.execute("""INSERT INTO DeletedItems (entity_type, entity_id, deletion_time)
                          VALUES ('Assessment', %s, NOW())""", (assessment_id,))
        connection.commit()
        print("Assessment removed and archived successfully!")
    except Error as e:
        print(f"Error deleting assessment: {e}")

def add_grade(connection):
    cursor = connection.cursor()
    assessment_id = input("Enter assessment ID: ")
    student_id = input("Enter student ID: ")
    grade = input("Enter grade: ")
    feedback = input("Enter feedback: ")

    query = """INSERT INTO Grades (assessment_id, student_id, grade, feedback)
               VALUES (%s, %s, %s, %s)"""
    values = (assessment_id, student_id, grade, feedback)
    cursor.execute(query, values)
    connection.commit()
    print("Grade added successfully!")

def delete_grade(connection):
    cursor = connection.cursor()
    grade_id = input("Enter grade ID to delete: ")

    try:
        cursor.execute("""INSERT INTO Grades_Archive (assessment_id, student_id, grade, feedback)
                          SELECT assessment_id, student_id, grade, feedback FROM Grades WHERE grade_id=%s""", (grade_id,))
        cursor.execute("DELETE FROM Grades WHERE grade_id=%s", (grade_id,))
        cursor.execute("""INSERT INTO DeletedItems (entity_type, entity_id, deletion_time)
                          VALUES ('Grade', %s, NOW())""", (grade_id,))
        connection.commit()
        print("Grade removed and archived successfully!")
    except Error as e:
        print(f"Error deleting grade: {e}")

def view_grades(connection):
    cursor = connection.cursor()
    student_id = input("Enter student ID to view grades: ")

    query = """SELECT s.first_name, s.last_name, a.assessment_name, g.grade, g.feedback
               FROM Grades g
               JOIN Students s ON g.student_id = s.student_id
               JOIN Assessments a ON g.assessment_id = a.assessment_id
               WHERE s.student_id = %s"""
    cursor.execute(query, (student_id,))
    results = cursor.fetchall()
    for row in results:
        print(row)

def get_recent_deletions(connection):
    cursor = connection.cursor()
    try:
        query = """SELECT entity_type, entity_id, deletion_time
                   FROM DeletedItems
                   ORDER BY deletion_time DESC
                   LIMIT 10"""  # Adjust limit as needed
        cursor.execute(query)
        results = cursor.fetchall()
        print("\nRecent deletions:")
        for row in results:
            print(f"{row[0]} ID {row[1]} deleted at {row[2]}")
    except Error as e:
        print(f"Error retrieving recent deletions: {e}")

def view_all_students(connection):
    cursor = connection.cursor()
    query = "SELECT * FROM Students"
    cursor.execute(query)
    results = cursor.fetchall()
    for row in results:
        print(row)

def view_all_instructors(connection):
    cursor = connection.cursor()
    query = "SELECT * FROM Instructors"
    cursor.execute(query)
    results = cursor.fetchall()
    for row in results:
        print(row)

def view_all_courses(connection):
    cursor = connection.cursor()
    query = "SELECT * FROM Courses"
    cursor.execute(query)
    results = cursor.fetchall()
    for row in results:
        print(row)

def view_instructors_assigned_to_courses(connection):
    cursor = connection.cursor()
    query = """SELECT c.course_name, i.first_name, i.last_name
               FROM CourseInstructors ci
               JOIN Courses c ON ci.course_id = c.course_id
               JOIN Instructors i ON ci.instructor_id = i.instructor_id"""
    cursor.execute(query)
    results = cursor.fetchall()
    for row in results:
        print(f"Course: {row[0]}, Instructor: {row[1]} {row[2]}")

def main():
    connection = create_connection()
    if connection is None:
        return

    while True:
        print("\nOptions:")
        print("1. Add a course")
        print("2. Update course description")
        print("3. Remove a course")
        print("4. Search courses")
        print("5. Sort courses by start date")
        print("6. Add a student")
        print("7. Delete a student")
        print("8. Add an instructor")
        print("9. Delete an instructor")
        print("10. Assign instructor to a course")
        print("11. Enroll student to a course")
        print("12. Track student progress")
        print("13. Create an assessment")
        print("14. Delete an assessment")
        print("15. Add a grade")
        print("16. Delete a grade")
        print("17. View grades")
        print("18. Recent deletions")
        print("19. View all students")
        print("20. View all instructors")
        print("21. View all courses")
        print("22. View which instructor is assigned to which course")
        print("23. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            add_course(connection)
        elif choice == '2':
            update_course_description(connection)
        elif choice == '3':
            remove_course(connection)
        elif choice == '4':
            search_courses(connection)
        elif choice == '5':
            sort_courses(connection)
        elif choice == '6':
            add_student(connection)
        elif choice == '7':
            delete_student(connection)
        elif choice == '8':
            add_instructor(connection)
        elif choice == '9':
            delete_instructor(connection)
        elif choice == '10':
            assign_instructor_to_course(connection)
        elif choice == '11':
            enroll_student_to_course(connection)
        elif choice == '12':
            track_student_progress(connection)
        elif choice == '13':
            create_assessment(connection)
        elif choice == '14':
            delete_assessment(connection)
        elif choice == '15':
            add_grade(connection)
        elif choice == '16':
            delete_grade(connection)
        elif choice == '17':
            view_grades(connection)
        elif choice == '18':
            get_recent_deletions(connection)
        elif choice == '19':
            view_all_students(connection)
        elif choice == '20':
            view_all_instructors(connection)
        elif choice == '21':
            view_all_courses(connection)
        elif choice == '22':
            view_instructors_assigned_to_courses(connection)
        elif choice == '23':
            break
        else:
            print("Invalid choice. Please try again.")

    close_connection(connection)

if __name__ == "__main__":
    main()
