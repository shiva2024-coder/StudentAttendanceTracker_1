package com.attendance.model;

/**
 * Plain Java class (POJO) that represents one row in the `students` table.
 */
public class Student {

    private String studentId;
    private String studentName;
    private String department;

    // ── Constructors ────────────────────────────────────────────
    public Student() {}

    public Student(String studentId, String studentName, String department) {
        this.studentId   = studentId;
        this.studentName = studentName;
        this.department  = department;
    }

    // ── Getters & Setters ───────────────────────────────────────
    public String getStudentId()   { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getDepartment()  { return department; }
    public void setDepartment(String department) { this.department = department; }

    @Override
    public String toString() {
        return "Student{id=" + studentId + ", name=" + studentName + ", dept=" + department + "}";
    }
}
