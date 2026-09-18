-- ============================================================================
-- Seed Data: Student Information Management System (SIMS)
-- Author: Albar Rahman A
-- ============================================================================

USE sims_db;

-- Default Users (Default password for both is 'password')
-- bcrypt hash for 'password': .Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi
INSERT INTO users (username, password, role) VALUES
('staff1', '.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'staff'),
('student1', '.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'student'),
('student2', '.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'student');

-- Faculty / Staff Records
INSERT INTO staff (user_id, staff_id, first_name, last_name, email, phone, department, designation) VALUES
(1, 'STF001', 'John', 'Smith', 'john.smith@college.edu', '9876543210', 'Computer Science', 'Professor');

-- Student Records
INSERT INTO students (user_id, student_id, first_name, last_name, email, phone, dob, gender, address, department, semester, year_of_admission) VALUES
(2, 'STU001', 'Alice', 'Johnson', 'alice.johnson@student.edu', '9876543211', '2002-05-15', 'Female', '123 College Street, City', 'Electronics & Communication', 4, 2022),
(3, 'STU002', 'Bob', 'Williams', 'bob.williams@student.edu', '9876543212', '2002-08-20', 'Male', '456 University Avenue, City', 'Electronics & Communication', 4, 2022);

-- Academic Subjects
INSERT INTO subjects (subject_code, subject_name, credits, department) VALUES
('CS101', 'Introduction to Programming', 4, 'Computer Science'),
('CS102', 'Data Structures', 4, 'Computer Science'),
('CS103', 'Database Management Systems', 3, 'Computer Science'),
('MATH101', 'Engineering Mathematics', 4, 'Mathematics'),
('PHY101', 'Engineering Physics', 3, 'Physics');

-- Examination Marks
INSERT INTO marks (student_id, subject_id, internal_marks, external_marks, total_marks, grade, semester, exam_year) VALUES
(1, 1, 35.00, 55.00, 90.00, 'A+', 1, 2022),
(1, 2, 30.00, 50.00, 80.00, 'A', 1, 2022),
(1, 3, 30.00, 50.00, 80.00, 'A', 4, 2024),
(1, 4, 32.00, 48.00, 80.00, 'A', 1, 2022),
(1, 5, 25.00, 42.00, 67.00, 'B', 2, 2023),
(2, 3, 28.00, 47.00, 75.00, 'B+', 4, 2024);

-- Attendance Records
INSERT INTO attendance (student_id, subject_id, date, status, marked_by) VALUES
(1, 1, '2024-01-15', 'Present', 1),
(1, 1, '2024-01-16', 'Present', 1),
(1, 1, '2024-01-17', 'Absent', 1),
(1, 3, '2024-01-15', 'Present', 1),
(1, 3, '2024-01-16', 'Present', 1),
(1, 3, '2024-01-17', 'Present', 1),
(2, 3, '2024-01-15', 'Present', 1),
(2, 3, '2024-01-16', 'Late', 1);