package com.attendance.model;

/**
 * Holds computed attendance statistics for a single student.
 * Used only for the Attendance Report page – not a database table.
 */
public class AttendanceReport {

    private String studentId;
    private String studentName;
    private int    presentCount;
    private int    absentCount;
    private double percentage;

    // ── Constructors ────────────────────────────────────────────
    public AttendanceReport() {}

    public AttendanceReport(String studentId, String studentName,
                            int presentCount, int absentCount) {
        this.studentId    = studentId;
        this.studentName  = studentName;
        this.presentCount = presentCount;
        this.absentCount  = absentCount;

        int total = presentCount + absentCount;
        this.percentage = (total == 0) ? 0.0
                : Math.round((presentCount * 100.0 / total) * 100.0) / 100.0;
    }

    // ── Getters ─────────────────────────────────────────────────
    public String getStudentId()    { return studentId; }
    public String getStudentName()  { return studentName; }
    public int    getPresentCount() { return presentCount; }
    public int    getAbsentCount()  { return absentCount; }
    public double getPercentage()   { return percentage; }

    /** Returns true when attendance is below the 75 % threshold. */
    public boolean isLowAttendance() { return percentage < 75.0; }
}
