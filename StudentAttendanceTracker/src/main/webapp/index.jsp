<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Attendance Tracker</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- ── Header ─────────────────────────────────────────────── -->
<header>
    <a href="index.jsp" class="brand">
        <span class="icon">🎓</span> Attendance Tracker
    </a>
    <nav>
        <a href="index.jsp"          class="active">Home</a>
        <a href="addStudent.jsp">Add Student</a>
        <a href="studentList.jsp">Student List</a>
        <a href="markAttendance.jsp">Mark Attendance</a>
        <a href="AttendanceServlet?action=report">Report</a>
    </nav>
</header>

<!-- ── Hero ───────────────────────────────────────────────── -->
<div class="container">
    <div class="card home-hero">
        <h1>🎓 Student Attendance Tracker</h1>
        <p>A simple system to manage students and track daily attendance with ease.</p>

        <div class="nav-grid">

            <a href="addStudent.jsp" class="nav-card blue">
                <span class="nav-icon">➕</span>
                <div class="nav-label">Add Student</div>
                <div class="nav-desc">Register a new student with ID, name, and department</div>
            </a>

            <a href="studentList.jsp" class="nav-card green">
                <span class="nav-icon">📋</span>
                <div class="nav-label">Student List</div>
                <div class="nav-desc">View, edit, or delete student records</div>
            </a>

            <a href="markAttendance.jsp" class="nav-card orange">
                <span class="nav-icon">✅</span>
                <div class="nav-label">Mark Attendance</div>
                <div class="nav-desc">Record today's Present / Absent status</div>
            </a>

            <a href="AttendanceServlet?action=report" class="nav-card red">
                <span class="nav-icon">📊</span>
                <div class="nav-label">Attendance Report</div>
                <div class="nav-desc">View attendance percentage and low-attendance alerts</div>
            </a>

        </div>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
