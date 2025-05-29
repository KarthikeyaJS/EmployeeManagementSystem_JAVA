package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DisplayEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() {
        employeeDAO = new EmployeeDAO(); // ensure this has selectEmployee(int empno)
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int empno = Integer.parseInt(request.getParameter("empno"));
            Employee emp = employeeDAO.selectEmployee(empno);

            if (emp != null) {
                request.setAttribute("employee", emp);
            } else {
                request.setAttribute("message", "Employee not found.");
            }

        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("empdisplay.jsp");
        dispatcher.forward(request, response);
    }

    // Optional: redirect GET to JSP if user types URL directly
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("empdisplay.jsp");
    }
}
