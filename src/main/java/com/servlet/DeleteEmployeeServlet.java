package com.servlet;

import com.dao.EmployeeDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteEmployeeServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int empno = Integer.parseInt(request.getParameter("empno"));

        try {
            boolean deleted = employeeDAO.deleteEmployee(empno);
            if(deleted) {
                response.sendRedirect("empdisplay.jsp");
            } else {
                response.getWriter().println("Employee deletion failed");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
