<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.attendance.dao.StudentDAO, com.attendance.model.Student, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List – Attendance Tracker</title>
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

<div class="container">
    <div class="page-title">📋 Student List</div>

    <%-- Flash messages from session --%>
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

    <%-- Action bar --%>
    <div style="display:flex;justify-content:flex-end;margin-bottom:16px;">
        <a href="addStudent.jsp" class="btn btn-primary">➕ Add New Student</a>
    </div>

    <%-- Load students --%>
    <%
        StudentDAO studentDAO = new StudentDAO();
        List<Student> students = studentDAO.getAllStudents();
    %>

    <div class="card" style="padding:0;">
        <% if (students.isEmpty()) { %>
            <div style="padding:40px;text-align:center;color:#888;">
                <div style="font-size:3rem;margin-bottom:12px;">📭</div>
                <p>No students found. <a href="addStudent.jsp" style="color:#1a73e8;">Add the first student</a></p>
            </div>
        <% } else { %>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Student ID</th>
                            <th>Student Name</th>
                            <th>Department</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int i = 1;
                           for (Student s : students) { %>
                        <tr>
                            <td><%= i++ %></td>
                            <td><strong><%= s.getStudentId() %></strong></td>
                            <td><%= s.getStudentName() %></td>
                            <td><span class="badge badge-warning"><%= s.getDepartment() %></span></td>
                            <td>
                                <a href="StudentServlet?action=edit&id=<%= s.getStudentId() %>"
                                   class="btn btn-warning btn-sm">✏️ Edit</a>
                                <a href="StudentServlet?action=delete&id=<%= s.getStudentId() %>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirmDelete('<%= s.getStudentId() %>', '<%= s.getStudentName() %>')">
                                   🗑️ Delete</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <div style="padding:12px 16px;font-size:0.82rem;color:#888;border-top:1px solid #e8eaed;">
                Total: <strong><%= students.size() %></strong> student(s)
            </div>
        <% } %>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
