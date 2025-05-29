package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ReportFilterServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String startsWith = request.getParameter("startsWith");
        String minYearsStr = request.getParameter("minYears");
        String minSalaryStr = request.getParameter("minSalary");
        boolean showAll = "true".equals(request.getParameter("showAll"));

        List<Employee> employees;

        if (showAll) {
            employees = employeeDAO.getAllEmployees();
        } else {
            int minYears = (minYearsStr != null && !minYearsStr.isEmpty()) ? Integer.parseInt(minYearsStr) : 0;
            double minSalary = (minSalaryStr != null && !minSalaryStr.isEmpty()) ? Double.parseDouble(minSalaryStr) : 0;
            employees = employeeDAO.getFilteredEmployees(startsWith, minYears, minSalary);
        }

        request.setAttribute("filteredEmployees", employees);
        RequestDispatcher dispatcher = request.getRequestDispatcher("report_result.jsp");
        dispatcher.forward(request, response);
    }
}
