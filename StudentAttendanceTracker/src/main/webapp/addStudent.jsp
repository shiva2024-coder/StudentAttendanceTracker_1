<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student – Attendance Tracker</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- ── Header ─────────────────────────────────────────────── -->
<header>
    <a href="index.jsp" class="brand"><span class="icon">🎓</span> Attendance Tracker</a>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="addStudent.jsp" class="active">Add Student</a>
        <a href="studentList.jsp">Student List</a>
        <a href="markAttendance.jsp">Mark Attendance</a>
        <a href="AttendanceServlet?action=report">Report</a>
    </nav>
</header>

<div class="container">
    <div class="page-title">➕ Add New Student</div>

    <%-- Error message (e.g. duplicate ID) --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null && !error.isEmpty()) { %>
        <div class="alert alert-error" data-auto-hide>⚠️ <%= error %></div>
    <% } %>

    <div class="card">
        <form action="StudentServlet" method="post" onsubmit="return validateStudentForm()">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label for="studentId">Student ID <span style="color:#ea4335">*</span></label>
                <input type="text"
                       id="studentId"
                       name="studentId"
                       placeholder="e.g. S006"
                       maxlength="20"
                       value="<%= request.getAttribute("studentId") != null ? request.getAttribute("studentId") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="studentName">Student Name <span style="color:#ea4335">*</span></label>
                <input type="text"
                       id="studentName"
                       name="studentName"
                       placeholder="e.g. Ananya Desai"
                       maxlength="100"
                       value="<%= request.getAttribute("studentName") != null ? request.getAttribute("studentName") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="department">Department <span style="color:#ea4335">*</span></label>
                <input type="text"
                       id="department"
                       name="department"
                       placeholder="e.g. Computer Science"
                       maxlength="100"
                       value="<%= request.getAttribute("department") != null ? request.getAttribute("department") : "" %>"
                       required>
            </div>

            <div class="btn-row">
                <button type="submit"  class="btn btn-primary">💾 Save Student</button>
                <button type="reset"   class="btn btn-secondary">🔄 Reset</button>
                <a href="studentList.jsp" class="btn btn-secondary">← Back to List</a>
            </div>
        </form>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
