package com.attendance.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection – central place for JDBC connection setup.
 *
 * Change DB_URL / DB_USER / DB_PASS to match your MySQL setup.
 */
public class DBConnection {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/attendance_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Shivaleela@2003";   // ← change to your MySQL password

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("MySQL Driver not found: " + e.getMessage());
        }
    }

    /** Returns a new JDBC connection. Caller is responsible for closing it. */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }
}
