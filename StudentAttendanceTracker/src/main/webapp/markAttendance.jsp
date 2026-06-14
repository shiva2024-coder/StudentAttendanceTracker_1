<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.attendance.dao.StudentDAO, com.attendance.model.Student, java.util.List, java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance – Attendance Tracker</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- ── Header ─────────────────────────────────────────────── -->
<header>
    <a href="index.jsp" class="brand"><span class="icon">🎓</span> Attendance Tracker</a>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="addStudent.jsp">Add Student</a>
        <a href="studentList.jsp">Student List</a>
        <a href="markAttendance.jsp" class="active">Mark Attendance</a>
        <a href="AttendanceServlet?action=report">Report</a>
    </nav>
</header>

<div class="container">
    <div class="page-title">✅ Mark Attendance</div>

    <%-- Flash messages --%>
    <%
        String successMsg = (String) session.getAttribute("successMsg");
        String errorMsg   = (String) session.getAttribute("errorMsg");
        session.removeAttribute("successMsg");
        session.removeAttribute("errorMsg");
        if (successMsg != null && !successMsg.isEmpty()) {
    %>
        <div class="alert alert-success" data-auto-hide>✅ <%= successMsg %></div>
    <% }
       if (errorMsg != null && !errorMsg.isEmpty()) {
    %>
        <div class="alert alert-error" data-auto-hide>⚠️ <%= errorMsg %></div>
    <% } %>

    <%
        StudentDAO studentDAO = new StudentDAO();
        List<Student> students = studentDAO.getAllStudents();
        String today = LocalDate.now().toString();
    %>

    <div class="alert alert-info">
        📅 Marking attendance for: <strong><%= today %></strong>
    </div>

    <% if (students.isEmpty()) { %>
        <div class="card" style="text-align:center;padding:40px;">
            <div style="font-size:3rem;margin-bottom:12px;">📭</div>
            <p>No students available. <a href="addStudent.jsp" style="color:#1a73e8;">Add a student first.</a></p>
        </div>
    <% } else { %>
        <form action="AttendanceServlet" method="post">
            <input type="hidden" name="action" value="mark">

            <%-- Quick-select all buttons --%>
            <div style="display:flex;gap:12px;margin-bottom:16px;flex-wrap:wrap;">
                <button type="button" class="btn btn-success btn-sm"
                        onclick="selectAll('Present')">✅ Mark All Present</button>
                <button type="button" class="btn btn-danger btn-sm"
                        onclick="selectAll('Absent')">❌ Mark All Absent</button>
            </div>

            <div class="card" style="padding:0;">
                <%-- Header row --%>
                <div style="display:flex;justify-content:space-between;align-items:center;
                            padding:12px 16px;background:#f8f9fa;border-bottom:2px solid #e8eaed;
                            font-weight:700;font-size:0.88rem;color:#555;border-radius:12px 12px 0 0;">
                    <span>STUDENT</span>
                    <span style="margin-right:40px;">ATTENDANCE</span>
                </div>

                <%  int row = 0;
                    for (Student s : students) {
                        String rowStyle = (row % 2 == 0) ? "" : "background:#fafafa;";
                        row++;
                %>
                <div class="attendance-row" style="<%= rowStyle %>">
                    <div>
                        <div class="student-info"><%= s.getStudentName() %></div>
                        <div class="student-id">ID: <%= s.getStudentId() %></div>
                    </div>
                    <div class="radio-group">
                        <label class="radio-option present">
                            <input type="radio"
                                   name="status_<%= s.getStudentId() %>"
                                   value="Present"
                                   checked>
                            ✅ Present
                        </label>
                        <label class="radio-option absent">
                            <input type="radio"
                                   name="status_<%= s.getStudentId() %>"
                                   value="Absent">
                            ❌ Absent
                        </label>
                    </div>
                </div>
                <% } %>
            </div>

            <div class="btn-row" style="margin-top:20px;">
                <button type="submit" class="btn btn-primary">📤 Submit Attendance</button>
                <a href="index.jsp" class="btn btn-secondary">✖ Cancel</a>
            </div>
        </form>
    <% } %>
</div>

<script src="js/script.js"></script>
</body>
</html>
