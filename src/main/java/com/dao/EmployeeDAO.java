package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.Employee;

public class EmployeeDAO {

    private final String jdbcURL = "jdbc:mysql://localhost:3306/employee";
    private final String jdbcUsername = "root";  // default XAMPP user
    private final String jdbcPassword = "";      // usually empty in XAMPP

    // SQL Queries
    private static final String INSERT_EMPLOYEE_SQL =
            "INSERT INTO emp (Empno, EmpName, DoJ, Gender, Bsalary) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_EMPLOYEE_BY_ID =
            "SELECT * FROM emp WHERE Empno = ?";
    private static final String SELECT_ALL_EMPLOYEES =
            "SELECT * FROM emp";
    private static final String DELETE_EMPLOYEE_SQL =
            "DELETE FROM emp WHERE Empno = ?";
    private static final String UPDATE_EMPLOYEE_SQL =
            "UPDATE emp SET EmpName = ?, DoJ = ?, Gender = ?, Bsalary = ? WHERE Empno = ?";

    // Report Queries
    private static final String SELECT_EMP_BY_NAME_START =
            "SELECT * FROM emp WHERE EmpName LIKE ?";
    private static final String SELECT_EMP_BY_YEARS =
            "SELECT * FROM emp WHERE TIMESTAMPDIFF(YEAR, DoJ, CURDATE()) >= ?";
    private static final String SELECT_EMP_BY_SALARY =
            "SELECT * FROM emp WHERE Bsalary > ?";

    // Establish database connection
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // MySQL 8+ driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL Driver not found.", e);
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Insert new employee record
    public void insertEmployee(Employee employee) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_EMPLOYEE_SQL)) {

            preparedStatement.setInt(1, employee.getEmpno());
            preparedStatement.setString(2, employee.getEmpName());
            preparedStatement.setDate(3, employee.getDoJ());
            preparedStatement.setString(4, employee.getGender());
            preparedStatement.setDouble(5, employee.getBsalary());

            preparedStatement.executeUpdate();
        }
    }


public List<Employee> getAllEmployees() {
    List<Employee> employees = new ArrayList<>();
    String sql = "SELECT * FROM emp";

    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Employee emp = new Employee();
            emp.setEmpno(rs.getInt("empno"));
            emp.setEmpName(rs.getString("empname"));
            emp.setDoj(rs.getDate("doj"));
            emp.setGender(rs.getString("gender"));
            emp.setBsalary(rs.getDouble("bsalary"));

            employees.add(emp);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return employees;
}
    // Select employee by Empno
    public Employee selectEmployee(int empno) throws SQLException {
        Employee employee = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMPLOYEE_BY_ID)) {

            preparedStatement.setInt(1, empno);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("EmpName");
                    Date doj = rs.getDate("DoJ");
                    String gender = rs.getString("Gender");
                    double bsalary = rs.getDouble("Bsalary");
                    employee = new Employee(empno, name, doj, gender, bsalary);
                }
            }
        }
        return employee;
    }
    
    public List<Employee> getFilteredEmployees(String startsWith, int minYears, double minSalary) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM emp WHERE 1=1";

        if (startsWith != null && !startsWith.isEmpty()) {
            sql += " AND empname LIKE ?";
        }
        if (minYears > 0) {
            sql += " AND TIMESTAMPDIFF(YEAR, doj, CURDATE()) >= ?";
        }
        if (minSalary > 0) {
            sql += " AND bsalary > ?";
        }

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            int index = 1;
            if (startsWith != null && !startsWith.isEmpty()) {
                stmt.setString(index++, startsWith + "%");
            }
            if (minYears > 0) {
                stmt.setInt(index++, minYears);
            }
            if (minSalary > 0) {
                stmt.setDouble(index++, minSalary);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setEmpno(rs.getInt("empno"));
                emp.setEmpName(rs.getString("empname"));
                emp.setDoj(rs.getDate("doj"));
                emp.setGender(rs.getString("gender"));
                emp.setBsalary(rs.getDouble("bsalary"));
                employees.add(emp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return employees;
    }


    // Select all employees
    public List<Employee> selectAllEmployees() throws SQLException {
        List<Employee> employees = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_EMPLOYEES);
             ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                int empno = rs.getInt("Empno");
                String name = rs.getString("EmpName");
                Date doj = rs.getDate("DoJ");
                String gender = rs.getString("Gender");
                double bsalary = rs.getDouble("Bsalary");

                employees.add(new Employee(empno, name, doj, gender, bsalary));
            }
        }
        return employees;
    }

    // Delete employee by Empno
//    public boolean deleteEmployee(int empno) throws SQLException {
//        boolean rowDeleted;
//
//        try (Connection connection = getConnection();
//             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_EMPLOYEE_SQL)) {
//
//            preparedStatement.setInt(1, empno);
//            rowDeleted = preparedStatement.executeUpdate() > 0;
//        }
//        return rowDeleted;
//    }
    public boolean deleteEmployee(int empno) {
        boolean rowDeleted = false;
        String sql = "DELETE FROM emp WHERE Empno = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, empno);
            rowDeleted = stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rowDeleted;
    }


    // Update employee details
    public boolean updateEmployee(Employee employee) throws SQLException {
        boolean rowUpdated;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_EMPLOYEE_SQL)) {

            preparedStatement.setString(1, employee.getEmpName());
            preparedStatement.setDate(2, employee.getDoJ());
            preparedStatement.setString(3, employee.getGender());
            preparedStatement.setDouble(4, employee.getBsalary());
            preparedStatement.setInt(5, employee.getEmpno());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    // Reports - Select employees where name starts with a character
    public List<Employee> selectEmployeesByNameStart(char startLetter) throws SQLException {
        List<Employee> employees = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMP_BY_NAME_START)) {

            preparedStatement.setString(1, startLetter + "%");
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    int empno = rs.getInt("Empno");
                    String name = rs.getString("EmpName");
                    Date doj = rs.getDate("DoJ");
                    String gender = rs.getString("Gender");
                    double bsalary = rs.getDouble("Bsalary");

                    employees.add(new Employee(empno, name, doj, gender, bsalary));
                }
            }
        }
        return employees;
    }

    // Reports - Select employees by minimum years of service
    public List<Employee> selectEmployeesByYears(int years) throws SQLException {
        List<Employee> employees = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMP_BY_YEARS)) {

            preparedStatement.setInt(1, years);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    int empno = rs.getInt("Empno");
                    String name = rs.getString("EmpName");
                    Date doj = rs.getDate("DoJ");
                    String gender = rs.getString("Gender");
                    double bsalary = rs.getDouble("Bsalary");

                    employees.add(new Employee(empno, name, doj, gender, bsalary));
                }
            }
        }
        return employees;
    }

    // Reports - Select employees with salary above threshold
    public List<Employee> selectEmployeesBySalary(double salary) throws SQLException {
        List<Employee> employees = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_EMP_BY_SALARY)) {

            preparedStatement.setDouble(1, salary);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    int empno = rs.getInt("Empno");
                    String name = rs.getString("EmpName");
                    Date doj = rs.getDate("DoJ");
                    String gender = rs.getString("Gender");
                    double bsalary = rs.getDouble("Bsalary");

                    employees.add(new Employee(empno, name, doj, gender, bsalary));
                }
            }
        }
        return employees;
    }
}
