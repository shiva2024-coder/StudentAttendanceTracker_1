package com.attendance.dao;

import com.attendance.model.AttendanceReport;
import com.attendance.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * AttendanceDAO – Data Access Object for the `attendance` table.
 */
public class AttendanceDAO {

    /**
     * Saves or updates today's attendance for a map of
     * { studentId → "Present" | "Absent" }.
     */
    public boolean markAttendance(Map<String, String> attendanceMap, String date) {
        /*
         * INSERT … ON DUPLICATE KEY UPDATE handles the UNIQUE(student_id, attend_date)
         * constraint – re-submitting the form on the same day simply overwrites.
         */
        String sql = "INSERT INTO attendance (student_id, attend_date, status) "
                   + "VALUES (?, ?, ?) "
                   + "ON DUPLICATE KEY UPDATE status = VALUES(status)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (Map.Entry<String, String> entry : attendanceMap.entrySet()) {
                ps.setString(1, entry.getKey());
                ps.setString(2, date);
                ps.setString(3, entry.getValue());
                ps.addBatch();
            }
            ps.executeBatch();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Returns attendance statistics for every student.
     * Students with zero attendance records are included with 0 / 0 / 0 %.
     */
    public List<AttendanceReport> getAttendanceReport() {
        List<AttendanceReport> reports = new ArrayList<>();

        /*
         * LEFT JOIN ensures students with no attendance records still appear.
         * SUM(status = 'Present') is a MySQL shortcut: boolean true = 1, false = 0.
         */
        String sql =
            "SELECT s.student_id, s.student_name, "
          + "       SUM(a.status = 'Present') AS present_count, "
          + "       SUM(a.status = 'Absent')  AS absent_count "
          + "FROM students s "
          + "LEFT JOIN attendance a ON s.student_id = a.student_id "
          + "GROUP BY s.student_id, s.student_name "
          + "ORDER BY s.student_id";

        try (Connection conn = DBConnection.getConnection();
             Statement  st   = conn.createStatement();
             ResultSet  rs   = st.executeQuery(sql)) {

            while (rs.next()) {
                reports.add(new AttendanceReport(
                        rs.getString("student_id"),
                        rs.getString("student_name"),
                        rs.getInt("present_count"),
                        rs.getInt("absent_count")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    /** Checks whether attendance has already been recorded for a given date. */
    public boolean isAttendanceMarked(String date) {
        String sql = "SELECT 1 FROM attendance WHERE attend_date = ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, date);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
