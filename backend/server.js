// ============================================================================
// Student Information Management System (SIMS) - Express REST API
// Author: Albar Rahman A
// ============================================================================

const express = require('express');
const cors = require('cors');
const path = require('path');
const db = require('./db');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '../public')));

// 1. Health Check
app.get('/api/health', (req, res) => {
  res.json({ status: 'healthy', system: 'Student Information Management System', author: 'Albar Rahman A' });
});

// 2. Authentication Route
app.post('/api/auth/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
    if (rows.length === 0) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }
    const user = rows[0];
    // In production verify bcrypt hash; for testing:
    res.json({ message: 'Login successful', role: user.role, userId: user.id });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 3. Students Management API
app.get('/api/students', async (req, res) => {
  try {
    const [students] = await db.execute('SELECT * FROM students ORDER BY id DESC');
    res.json(students);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.post('/api/students', async (req, res) => {
  const { user_id, student_id, first_name, last_name, email, phone, dob, gender, address, department, semester, year_of_admission } = req.body;
  try {
    const [result] = await db.execute(
      'INSERT INTO students (user_id, student_id, first_name, last_name, email, phone, dob, gender, address, department, semester, year_of_admission) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [user_id, student_id, first_name, last_name, email, phone, dob, gender, address, department, semester, year_of_admission]
    );
    res.status(201).json({ message: 'Student created successfully', id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 4. Examination Marks API
app.get('/api/marks/:studentId', async (req, res) => {
  try {
    const [marks] = await db.execute(
      SELECT m.*, sub.subject_code, sub.subject_name, sub.credits
      FROM marks m
      JOIN subjects sub ON m.subject_id = sub.id
      WHERE m.student_id = ?
    , [req.params.studentId]);
    res.json(marks);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 5. Attendance API
app.get('/api/attendance/:studentId', async (req, res) => {
  try {
    const [attendance] = await db.execute(
      SELECT a.*, sub.subject_name
      FROM attendance a
      JOIN subjects sub ON a.subject_id = sub.id
      WHERE a.student_id = ?
      ORDER BY a.date DESC
    , [req.params.studentId]);
    res.json(attendance);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log('SIMS Server running on http://localhost:' + PORT);
});