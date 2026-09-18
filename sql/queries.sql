-- ============================================================================
-- Useful Analytical SQL Queries: SIMS
-- Author: Albar Rahman A
-- ============================================================================

USE sims_db;

-- 1. Retrieve complete profile of a student with their registered user account
SELECT s.student_id, s.first_name, s.last_name, s.email, s.department, s.semester, u.username
FROM students s
JOIN users u ON s.user_id = u.id
WHERE s.student_id = 'STU001';

-- 2. Calculate overall attendance percentage for each student
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    COUNT(a.id) AS total_classes,
    SUM(CASE WHEN a.status IN ('Present', 'Late') THEN 1 ELSE 0 END) AS attended_classes,
    ROUND((SUM(CASE WHEN a.status IN ('Present', 'Late') THEN 1 ELSE 0 END) / COUNT(a.id)) * 100, 2) AS attendance_percentage
FROM students s
LEFT JOIN attendance a ON s.id = a.student_id
GROUP BY s.id, s.student_id, s.first_name, s.last_name;

-- 3. Student Semester Mark Sheet with Subject Details
SELECT 
    sub.subject_code,
    sub.subject_name,
    sub.credits,
    m.internal_marks,
    m.external_marks,
    m.total_marks,
    m.grade,
    m.semester
FROM marks m
JOIN subjects sub ON m.subject_id = sub.id
JOIN students s ON m.student_id = s.id
WHERE s.student_id = 'STU001' AND m.semester = 4;

-- 4. Calculate Average Score per Student
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(m.id) AS subjects_evaluated,
    ROUND(AVG(m.total_marks), 2) AS average_score
FROM students s
JOIN marks m ON s.id = m.student_id
GROUP BY s.id, s.student_id, s.first_name, s.last_name;

-- 5. Staff Overview with Department Student Counts
SELECT 
    st.staff_id,
    CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
    st.department,
    st.designation,
    (SELECT COUNT(*) FROM students s WHERE s.department = st.department) AS total_students_in_dept
FROM staff st;