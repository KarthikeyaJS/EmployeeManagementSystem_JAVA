<%@ page import="com.model.Employee" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Employee | JavaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 0;
        }

        .header {
            display: flex;
            align-items: center;
            gap: 10px;
            background-color: #0077b6;
            color: white;
            padding: 20px;
            justify-content: center;
        }

        .form-container {
            background: white;
            max-width: 500px;
            margin: 40px auto;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #0077b6;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 20px;
        }

        label {
            font-weight: 500;
        }

        input[type="text"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        input[type="submit"] {
            background-color: #0077b6;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
        }
        .logo-section {
            display: flex;
            align-items: center;
            gap: 1rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo-container {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 
                0 8px 20px rgba(102, 126, 234, 0.3),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .logo::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #667eea, #764ba2, #667eea);
            border-radius: 18px;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .logo:hover::before {
            opacity: 0.7;
        }

        .logo:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 
                0 12px 30px rgba(102, 126, 234, 0.4),
                0 0 0 1px rgba(255, 255, 255, 0.3);
        }

        .logo i {
            font-size: 1.5rem;
            color: white;
            z-index: 1;
        }

        .company-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .company-name {
            font-size: 1.75rem;
            font-weight: 700;
            color: #1a202c;
            letter-spacing: -0.025em;
            line-height: 1.2;
            transition: color 0.3s ease;
        }

        .company-name:hover {
            color: #667eea;
        }

        .company-tagline {
            font-size: 0.875rem;
            color: #64748b;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        input[type="submit"]:hover {
            background-color: #023e8a;
        }

        .message {
            margin-top: 15px;
            padding: 10px;
            background-color: #f8d7da;
            color: #842029;
            border-radius: 6px;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        table tr:last-child td {
            border-bottom: none;
        }

        h3 {
            margin-top: 30px;
            color: #023e8a;
        }

        .back-link {
            display: block;
            text-align: center;
            margin: 30px auto;
            color: #0077b6;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="header">
        <div class="logo-section">
            <div class="logo-container">
                <div class="logo">
                    <i class="fas fa-shield-alt"></i>
                </div>
            </div>
            <div class="company-info">
                <div class="company-name">NexusCore</div>
                <div class="company-tagline">Enterprise Solutions</div>
            </div>
        </div>
    </div>

    <div class="form-container">
        <h2>Display Employee</h2>
        <form method="post" action="displayEmployee">
            <label>Enter Employee Number (Empno):</label>
            <input type="text" name="empno" required />
            <input type="submit" value="Display" />
        </form>

        <%
            Employee emp = (Employee) request.getAttribute("employee");
            String message = (String) request.getAttribute("message");

            if (message != null) {
        %>
            <div class="message"><%= message %></div>
        <%
            }

            if (emp != null) {
        %>
            <h3>Employee Details:</h3>
            <table>
                <tr><td><strong>Emp No</strong></td><td><%= emp.getEmpno() %></td></tr>
                <tr><td><strong>Name</strong></td><td><%= emp.getEmpName() %></td></tr>
                <tr><td><strong>Date of Joining</strong></td><td><%= emp.getDoJ() %></td></tr>
                <tr><td><strong>Gender</strong></td><td><%= emp.getGender() %></td></tr>
                <tr><td><strong>Basic Salary</strong></td><td><%= emp.getBsalary() %></td></tr>
            </table>
        <%
            }
        %>
    </div>

    <a href="home.jsp" class="back-link">← Back to Home</a>

</body>
</html>
