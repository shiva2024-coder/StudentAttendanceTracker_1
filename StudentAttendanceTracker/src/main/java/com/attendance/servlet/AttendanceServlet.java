package com.attendance.servlet;

import com.attendance.dao.AttendanceDAO;
import com.attendance.dao.StudentDAO;
import com.attendance.model.AttendanceReport;
import com.attendance.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AttendanceServlet – handles marking attendance and showing the report.
 *
 * URL mapping : /AttendanceServlet
 *
 * action param values:
 *   mark   – POST: save today's attendance
 *   report – GET : load the attendance report page
 */
@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final StudentDAO    studentDAO    = new StudentDAO();

    // ── POST – save attendance ───────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("mark".equals(action)) {

            List<Student>     students = studentDAO.getAllStudents();
            Map<String,String> map     = new HashMap<>();

            for (Student s : students) {
                String status = req.getParameter("status_" + s.getStudentId());
                // Default to Absent if nothing was selected
                map.put(s.getStudentId(), (status != null) ? status : "Absent");
            }

            String today   = LocalDate.now().toString();   // "yyyy-MM-dd"
            boolean success = attendanceDAO.markAttendance(map, today);

            if (success) {
                req.getSession().setAttribute("successMsg", "Attendance marked successfully for " + today + "!");
            } else {
                req.getSession().setAttribute("errorMsg", "Failed to save attendance. Please try again.");
            }
            resp.sendRedirect("markAttendance.jsp");

        } else {
            resp.sendRedirect("index.jsp");
        }
    }

    // ── GET – attendance report ───────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("report".equals(action)) {
            List<AttendanceReport> reports = attendanceDAO.getAttendanceReport();
            req.setAttribute("reports", reports);
            req.getRequestDispatcher("attendanceReport.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("index.jsp");
        }
    }
}
