-- ============================================================
--  Student Attendance Tracker – Database Setup
--  Run this file once to create the database and tables.
-- ============================================================

CREATE DATABASE IF NOT EXISTS attendance_db;
USE attendance_db;

-- ── Students table ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS students (
    student_id   VARCHAR(20)  NOT NULL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department   VARCHAR(100) NOT NULL
);

-- ── Attendance table ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS attendance (
    id           INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_id   VARCHAR(20)  NOT NULL,
    attend_date  DATE         NOT NULL,
    status       ENUM('Present','Absent') NOT NULL,
    CONSTRAINT fk_student FOREIGN KEY (student_id)
        REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT uq_daily UNIQUE (student_id, attend_date)
);

-- ── Sample data (optional – remove if not needed) ────────────
INSERT IGNORE INTO students VALUES
    ('S001', 'Aarav Sharma',   'Computer Science'),
    ('S002', 'Priya Nair',     'Electronics'),
    ('S003', 'Rohan Mehta',    'Mechanical'),
    ('S004', 'Sneha Pillai',   'Civil'),
    ('S005', 'Kiran Reddy',    'Information Technology');
