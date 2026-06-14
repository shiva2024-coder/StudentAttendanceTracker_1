package com.attendance.dao;

import com.attendance.model.Student;
import com.attendance.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * StudentDAO – Data Access Object for the `students` table.
 *
 * Every method opens its own connection and closes it in a finally block,
 * which is safe and easy to understand for beginners.
 */
public class StudentDAO {

    // ── INSERT ───────────────────────────────────────────────────
    public boolean addStudent(Student s) {
        String sql = "INSERT INTO students (student_id, student_name, department) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, s.getStudentId());
            ps.setString(2, s.getStudentName());
            ps.setString(3, s.getDepartment());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── SELECT ALL ───────────────────────────────────────────────
    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY student_id";
        try (Connection conn = DBConnection.getConnection();
             Statement  st   = conn.createStatement();
             ResultSet  rs   = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(new Student(
                        rs.getString("student_id"),
                        rs.getString("student_name"),
                        rs.getString("department")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── SELECT ONE ───────────────────────────────────────────────
    public Student getStudentById(String id) {
        String sql = "SELECT * FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Student(
                            rs.getString("student_id"),
                            rs.getString("student_name"),
                            rs.getString("department"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── UPDATE ───────────────────────────────────────────────────
    public boolean updateStudent(Student s) {
        String sql = "UPDATE students SET student_name = ?, department = ? WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getDepartment());
            ps.setString(3, s.getStudentId());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── DELETE ───────────────────────────────────────────────────
    public boolean deleteStudent(String id) {
        String sql = "DELETE FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── EXISTS CHECK ─────────────────────────────────────────────
    public boolean studentExists(String id) {
        String sql = "SELECT 1 FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
