package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class UpdateEmployeeServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int empno = Integer.parseInt(request.getParameter("empno"));
        String empName = request.getParameter("empName");
        Date doj = Date.valueOf(request.getParameter("doj"));
        String gender = request.getParameter("gender");
        double bsalary = Double.parseDouble(request.getParameter("bsalary"));

        Employee employee = new Employee(empno, empName, doj, gender, bsalary);

        try {
            boolean updated = employeeDAO.updateEmployee(employee);
            if(updated) {
                response.sendRedirect("empdisplay.jsp");
            } else {
                response.getWriter().println("Employee update failed");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
