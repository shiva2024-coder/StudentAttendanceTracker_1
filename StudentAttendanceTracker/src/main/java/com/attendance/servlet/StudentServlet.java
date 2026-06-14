package com.attendance.servlet;

import com.attendance.dao.StudentDAO;
import com.attendance.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * StudentServlet – handles all student CRUD operations.
 *
 * URL mapping : /StudentServlet
 *
 * action param values:
 *   add    – insert a new student
 *   update – save edited student
 *   delete – remove a student
 *   edit   – load edit form pre-filled with student data
 */
@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(req, resp);
        } else if ("update".equals(action)) {
            handleUpdate(req, resp);
        } else {
            resp.sendRedirect("studentList.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            handleDelete(req, resp);
        } else if ("edit".equals(action)) {
            handleEdit(req, resp);
        } else {
            resp.sendRedirect("studentList.jsp");
        }
    }

    // ── Add ──────────────────────────────────────────────────────
    private void handleAdd(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String id   = req.getParameter("studentId").trim();
        String name = req.getParameter("studentName").trim();
        String dept = req.getParameter("department").trim();

        if (studentDAO.studentExists(id)) {
            req.setAttribute("error", "Student ID '" + id + "' already exists. Please use a unique ID.");
            req.setAttribute("studentId",   id);
            req.setAttribute("studentName", name);
            req.setAttribute("department",  dept);
            req.getRequestDispatcher("addStudent.jsp").forward(req, resp);
            return;
        }

        boolean success = studentDAO.addStudent(new Student(id, name, dept));
        if (success) {
            req.getSession().setAttribute("successMsg", "Student added successfully!");
            resp.sendRedirect("studentList.jsp");
        } else {
            req.setAttribute("error", "Failed to add student. Please try again.");
            req.getRequestDispatcher("addStudent.jsp").forward(req, resp);
        }
    }

    // ── Update ───────────────────────────────────────────────────
    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String id   = req.getParameter("studentId").trim();
        String name = req.getParameter("studentName").trim();
        String dept = req.getParameter("department").trim();

        boolean success = studentDAO.updateStudent(new Student(id, name, dept));
        if (success) {
            req.getSession().setAttribute("successMsg", "Student updated successfully!");
        } else {
            req.getSession().setAttribute("errorMsg", "Update failed. Please try again.");
        }
        resp.sendRedirect("studentList.jsp");
    }

    // ── Delete ───────────────────────────────────────────────────
    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String id = req.getParameter("id");
        studentDAO.deleteStudent(id);
        req.getSession().setAttribute("successMsg", "Student deleted successfully.");
        resp.sendRedirect("studentList.jsp");
    }

    // ── Edit (load form) ─────────────────────────────────────────
    private void handleEdit(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String  id      = req.getParameter("id");
        Student student = studentDAO.getStudentById(id);

        if (student == null) {
            resp.sendRedirect("studentList.jsp");
            return;
        }
        req.setAttribute("student", student);
        req.getRequestDispatcher("editStudent.jsp").forward(req, resp);
    }
}
