# 🎓 Student Attendance Tracker

A beginner-friendly Java web application to manage student records and track daily attendance.

---

## 📁 Project Structure

```
StudentAttendanceTracker/
├── pom.xml                                    ← Maven build file
├── sql/
│   └── schema.sql                             ← Database setup
└── src/main/
    ├── java/com/attendance/
    │   ├── dao/
    │   │   ├── StudentDAO.java                ← DB operations for students
    │   │   └── AttendanceDAO.java             ← DB operations for attendance
    │   ├── model/
    │   │   ├── Student.java                   ← Student data class
    │   │   └── AttendanceReport.java          ← Report data class
    │   ├── servlet/
    │   │   ├── StudentServlet.java            ← Handles add/edit/delete
    │   │   └── AttendanceServlet.java         ← Handles mark & report
    │   └── util/
    │       └── DBConnection.java              ← JDBC connection helper
    └── webapp/
        ├── index.jsp                          ← Home page
        ├── addStudent.jsp                     ← Add student form
        ├── studentList.jsp                    ← Student list table
        ├── editStudent.jsp                    ← Edit student form
        ├── markAttendance.jsp                 ← Mark Present/Absent
        ├── attendanceReport.jsp               ← Attendance % report
        ├── css/
        │   └── style.css                      ← All styles
        ├── js/
        │   └── script.js                      ← Client-side JS
        └── WEB-INF/
            └── web.xml                        ← Servlet config
```

---

## ✅ Prerequisites

| Tool            | Version         | Download |
|-----------------|-----------------|----------|
| Java JDK        | 11 or higher    | https://adoptium.net |
| Apache Tomcat   | 9 or 10         | https://tomcat.apache.org |
| MySQL Server    | 8.0+            | https://dev.mysql.com |
| Maven           | 3.6+            | https://maven.apache.org |
| IDE (optional)  | IntelliJ / Eclipse | — |

---

## 🚀 Setup & Run

### Step 1 – Set up the Database

1. Open MySQL Workbench or the MySQL command line.
2. Run the SQL script:

```sql
SOURCE /path/to/StudentAttendanceTracker/sql/schema.sql;
```

This creates the `attendance_db` database with the `students` and `attendance` tables, plus 5 sample students.

---

### Step 2 – Configure Database Credentials

Open `src/main/java/com/attendance/util/DBConnection.java` and update:

```java
private static final String DB_URL  = "jdbc:mysql://localhost:3306/attendance_db?useSSL=false&serverTimezone=UTC";
private static final String DB_USER = "root";        // ← your MySQL username
private static final String DB_PASS = "root";        // ← your MySQL password
```

---

### Step 3 – Build the Project

```bash
cd StudentAttendanceTracker
mvn clean package
```

This produces `target/StudentAttendanceTracker.war`.

---

### Step 4 – Deploy to Tomcat

**Option A – Copy WAR file:**
1. Copy `target/StudentAttendanceTracker.war` into Tomcat's `webapps/` folder.
2. Start Tomcat: `bin/startup.sh` (Linux/Mac) or `bin/startup.bat` (Windows).

**Option B – IntelliJ IDEA:**
1. Open the project as a Maven project.
2. Add a Tomcat Run Configuration.
3. Select the WAR artifact for deployment.
4. Click Run ▶.

---

### Step 5 – Open in Browser

```
http://localhost:8080/StudentAttendanceTracker/
```

---

## 📖 Pages & Features

| Page                | URL / Action                          | Feature |
|---------------------|---------------------------------------|---------|
| Home                | `/index.jsp`                          | Navigation hub |
| Add Student         | `/addStudent.jsp`                     | Form to add a student |
| Student List        | `/studentList.jsp`                    | Table with Edit & Delete |
| Edit Student        | `/StudentServlet?action=edit&id=...`  | Pre-filled edit form |
| Mark Attendance     | `/markAttendance.jsp`                 | Radio buttons: Present / Absent |
| Attendance Report   | `/AttendanceServlet?action=report`    | % + Low Attendance warning |

---

## 🗄️ Database Tables

### `students`
| Column       | Type        | Notes          |
|--------------|-------------|----------------|
| student_id   | VARCHAR(20) | Primary Key    |
| student_name | VARCHAR(100)| —              |
| department   | VARCHAR(100)| —              |

### `attendance`
| Column      | Type                  | Notes                        |
|-------------|-----------------------|------------------------------|
| id          | INT AUTO_INCREMENT    | Primary Key                  |
| student_id  | VARCHAR(20)           | FK → students.student_id     |
| attend_date | DATE                  | yyyy-MM-dd                   |
| status      | ENUM('Present','Absent') | —                         |

Unique constraint on `(student_id, attend_date)` prevents duplicate entries for the same day.

---

## 💡 Key Concepts Used

- **JDBC** – `DriverManager`, `Connection`, `PreparedStatement`, `ResultSet`
- **Servlets** – `HttpServlet`, `doGet`, `doPost`, `@WebServlet`
- **JSP** – Scriptlets, EL-like patterns, `request.setAttribute`, `session`
- **DAO Pattern** – Separate class for each table's DB operations
- **MVC-lite** – Servlet = Controller, DAO/Model = Model, JSP = View
- **MySQL** – DDL, DML, `INSERT … ON DUPLICATE KEY UPDATE`, `LEFT JOIN`

---

## ⚠️ Low Attendance Warning

On the Attendance Report page, any student with **< 75% attendance** is flagged with a red **"⚠️ Low Attendance"** badge and included in the summary warning at the top.

---

## 🛠️ Troubleshooting

| Problem | Fix |
|---------|-----|
| `ClassNotFoundException: com.mysql.cj.jdbc.Driver` | Add `mysql-connector-java` JAR to project |
| `Access denied for user 'root'@'localhost'` | Check DB_USER / DB_PASS in DBConnection.java |
| 404 on `/StudentAttendanceTracker/` | Ensure WAR deployed correctly & Tomcat is running |
| Blank page on report | No attendance data yet – mark attendance first |
