<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.attendance.model.AttendanceReport, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Report – Attendance Tracker</title>
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
        <a href="markAttendance.jsp">Mark Attendance</a>
        <a href="AttendanceServlet?action=report" class="active">Report</a>
    </nav>
</header>

<div class="container">
    <div class="page-title">📊 Attendance Report</div>

    <%
        @SuppressWarnings("unchecked")
        List<AttendanceReport> reports = (List<AttendanceReport>) request.getAttribute("reports");

        // Count low attendance students
        int lowCount = 0;
        if (reports != null) {
            for (AttendanceReport r : reports) {
                if (r.isLowAttendance() && (r.getPresentCount() + r.getAbsentCount()) > 0) lowCount++;
            }
        }
    %>

    <% if (lowCount > 0) { %>
    <div class="alert alert-error">
        ⚠️ <strong><%= lowCount %> student(s)</strong> have attendance below 75%. Please review.
    </div>
    <% } %>

    <% if (reports == null || reports.isEmpty()) { %>
        <div class="card" style="text-align:center;padding:40px;">
            <div style="font-size:3rem;margin-bottom:12px;">📭</div>
            <p>No data available. Add students and mark attendance to see the report.</p>
        </div>
    <% } else { %>
        <div class="card" style="padding:0;">
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Student Name</th>
                            <th>Present</th>
                            <th>Absent</th>
                            <th>Attendance %</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        int i = 1;
                        for (AttendanceReport r : reports) {
                            int total = r.getPresentCount() + r.getAbsentCount();
                            double pct = r.getPercentage();
                            boolean isLow = r.isLowAttendance() && total > 0;
                            String fillClass = isLow ? "low" : "good";
                    %>
                        <tr>
                            <td><%= i++ %></td>
                            <td><strong><%= r.getStudentName() %></strong></td>
                            <td>
                                <span class="badge badge-success"><%= r.getPresentCount() %></span>
                            </td>
                            <td>
                                <span class="badge badge-danger"><%= r.getAbsentCount() %></span>
                            </td>
                            <td>
                                <% if (total == 0) { %>
                                    <span style="color:#aaa;font-size:0.85rem;">No records</span>
                                <% } else { %>
                                    <div style="display:flex;align-items:center;gap:8px;">
                                        <div class="progress-bar-wrap">
                                            <div class="progress-bar-fill <%= fillClass %>"
                                                 data-width="<%= (int) Math.min(pct, 100) %>"
                                                 style="width:0%">
                                            </div>
                                        </div>
                                        <strong style="min-width:44px;">
                                            <%= String.format("%.1f", pct) %>%
                                        </strong>
                                    </div>
                                <% } %>
                            </td>
                            <td>
                                <% if (total == 0) { %>
                                    <span class="badge badge-warning">No Data</span>
                                <% } else if (isLow) { %>
                                    <span class="low-warning">⚠️ Low Attendance</span>
                                <% } else { %>
                                    <span class="badge badge-success">✅ Good</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <%-- Summary footer --%>
            <div style="padding:14px 16px;background:#f8f9fa;border-top:1px solid #e8eaed;
                        border-radius:0 0 12px 12px;display:flex;gap:24px;flex-wrap:wrap;font-size:0.85rem;color:#555;">
                <span>Total Students: <strong><%= reports.size() %></strong></span>
                <span style="color:#1e7e34;">
                    Good Attendance: <strong><%= reports.size() - lowCount %></strong>
                </span>
                <% if (lowCount > 0) { %>
                <span style="color:#c62828;">
                    Low Attendance: <strong><%= lowCount %></strong>
                </span>
                <% } %>
                <span style="color:#888;">Threshold: &lt; 75% = Low</span>
            </div>
        </div>

        <div style="text-align:right;margin-top:16px;">
            <a href="markAttendance.jsp" class="btn btn-primary">✅ Mark Today's Attendance</a>
        </div>
    <% } %>
</div>

<script src="js/script.js"></script>
</body>
</html>
