<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.attendance.model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student – Attendance Tracker</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- ── Header ─────────────────────────────────────────────── -->
<header>
    <a href="index.jsp" class="brand"><span class="icon">🎓</span> Attendance Tracker</a>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="addStudent.jsp">Add Student</a>
        <a href="studentList.jsp" class="active">Student List</a>
        <a href="markAttendance.jsp">Mark Attendance</a>
        <a href="AttendanceServlet?action=report">Report</a>
    </nav>
</header>

<%
    Student student = (Student) request.getAttribute("student");
    if (student == null) {
        response.sendRedirect("studentList.jsp");
        return;
    }
%>

<div class="container">
    <div class="page-title">✏️ Edit Student</div>

    <div class="card">
        <form action="StudentServlet" method="post" onsubmit="return validateStudentForm()">
            <input type="hidden" name="action"    value="update">
            <input type="hidden" name="studentId" value="<%= student.getStudentId() %>">

            <div class="form-group">
                <label>Student ID</label>
                <%-- ID is read-only during edit; shown as plain text --%>
                <input type="text"
                       value="<%= student.getStudentId() %>"
                       disabled
                       style="background:#f0f4f8;color:#888;cursor:not-allowed;">
            </div>

            <div class="form-group">
                <label for="studentName">Student Name <span style="color:#ea4335">*</span></label>
                <input type="text"
                       id="studentName"
                       name="studentName"
                       value="<%= student.getStudentName() %>"
                       maxlength="100"
                       required>
            </div>

            <div class="form-group">
                <label for="department">Department <span style="color:#ea4335">*</span></label>
                <input type="text"
                       id="department"
                       name="department"
                       value="<%= student.getDepartment() %>"
                       maxlength="100"
                       required>
            </div>

            <div class="btn-row">
                <button type="submit" class="btn btn-success">💾 Update Student</button>
                <a href="studentList.jsp" class="btn btn-secondary">✖ Cancel</a>
            </div>
        </form>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
