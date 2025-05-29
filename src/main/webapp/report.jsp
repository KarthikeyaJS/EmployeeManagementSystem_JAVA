<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.model.Employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Employees | JavaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #2d3748;
            overflow-x: hidden;
        }

        /* Animated background particles */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .bg-animation::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="25" cy="25" r="2" fill="rgba(255,255,255,0.1)"><animate attributeName="opacity" values="0.1;0.3;0.1" dur="3s" repeatCount="indefinite"/></circle><circle cx="75" cy="25" r="1.5" fill="rgba(255,255,255,0.1)"><animate attributeName="opacity" values="0.1;0.4;0.1" dur="2s" repeatCount="indefinite"/></circle><circle cx="50" cy="75" r="1" fill="rgba(255,255,255,0.1)"><animate attributeName="opacity" values="0.1;0.5;0.1" dur="4s" repeatCount="indefinite"/></circle></svg>') repeat;
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% { transform: translateY(0px) rotate(0deg); }
            100% { transform: translateY(-100px) rotate(360deg); }
        }

        /* Header Styles */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo-section img {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(102, 126, 234, 0.3);
            transition: transform 0.3s ease;
        }

        .logo-section img:hover {
            transform: scale(1.1) rotate(5deg);
        }

        .company-name {
            font-family: 'Poppins', sans-serif;
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .home-link {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
            text-decoration: none;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 16px rgba(79, 172, 254, 0.3);
        }

        .home-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
        }

        .refresh-btn {
            background: linear-gradient(135deg, #43e97b, #38f9d7);
            color: white;
            border: none;
            padding: 0.75rem;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 16px rgba(67, 233, 123, 0.3);
        }

        .refresh-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(67, 233, 123, 0.4);
        }

        /* Main Content */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            margin-bottom: 0.5rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 1s ease;
        }

        .page-title p {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
            animation: fadeInUp 1s ease 0.2s both;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideInUp 0.6s ease forwards;
            opacity: 0;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }

        .stat-icon {
            width: 50px;
            height: 50px;
            margin: 0 auto 1rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .stat-card:nth-child(1) .stat-icon {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
        }

        .stat-card:nth-child(2) .stat-icon {
            background: linear-gradient(135deg, #43e97b, #38f9d7);
        }

        .stat-card:nth-child(3) .stat-icon {
            background: linear-gradient(135deg, #fa709a, #fee140);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #718096;
            font-size: 0.9rem;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Table Styles */
        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideInUp 0.6s ease 0.4s both;
            overflow: hidden;
            position: relative;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            margin: 2rem auto 0;
            max-width: fit-content;
            display: flex;
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(-5px);
            color: white;
        }

        .table-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 2px solid rgba(102, 126, 234, 0.1);
            border-radius: 12px;
            font-size: 0.9rem;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
        }

        th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #e2e8f0;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }

        tr:hover td {
            background-color: #f7fafc;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .employee-name {
            font-weight: 600;
            color: #2d3748;
        }

        .employee-id {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-block;
        }

        .salary {
            font-weight: 600;
            color: #38a169;
        }

        .gender-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
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
        
        .gender-male {
            background: rgba(79, 172, 254, 0.1);
            color: #4facfe;
        }

        .gender-female {
            background: rgba(250, 112, 154, 0.1);
            color: #fa709a;
        }

        .no-data {
            text-align: center;
            padding: 4rem 2rem;
            color: white;
            font-size: 1.2rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .no-data-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .company-name {
                font-size: 1.4rem;
            }

            .page-title h1 {
                font-size: 2rem;
            }

            .container {
                padding: 2rem 1rem;
            }

            .table-container {
                padding: 1.5rem;
            }

            .table-header {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            th, td {
                padding: 0.75rem 0.5rem;
                font-size: 0.8rem;
            }
        }

        @media (max-width: 480px) {
            .page-title h1 {
                font-size: 1.8rem;
            }

            .table-container {
                padding: 1rem;
            }
        }

        /* Loading animation */
        .loading {
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .loaded {
            opacity: 1;
        }
    </style>
</head>
<body class="loading">
    <div class="bg-animation"></div>
    
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
        <div class="header-actions">
            <button class="refresh-btn" onclick="location.reload()" title="Refresh Data">
                <i class="fas fa-sync-alt"></i>
            </button>
           
        </div>
    </div>

    <div class="container">
        <div class="page-title">
            <h1>Employee Directory</h1>
            <p>Complete overview of your workforce and team members</p>
        </div>

        <%
        List<Employee> employees = (List<Employee>) request.getAttribute("employees");
        int totalEmployees = (employees != null) ? employees.size() : 0;
        double totalSalary = 0;
        int maleCount = 0, femaleCount = 0;
        
        if (employees != null) {
            for (Employee emp : employees) {
                totalSalary += emp.getBsalary();
                if ("Male".equals(emp.getGender())) maleCount++;
                else if ("Female".equals(emp.getGender())) femaleCount++;
            }
        }
        %>

        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-number"><%= totalEmployees %></div>
                <div class="stat-label">Total Employees</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-number">₹<%= String.format("%.0f", totalSalary/1000) %>K</div>
                <div class="stat-label">Total Salary</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-balance-scale"></i>
                </div>
                <div class="stat-number"><%= maleCount %>/<%= femaleCount %></div>
                <div class="stat-label">Male/Female</div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-header">
                <div class="table-title">
                    <i class="fas fa-table"></i>
                    Employee Report
                </div>
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Search employees..." id="searchInput">
                </div>
            </div>

            <%
            if (employees != null && !employees.isEmpty()) {
            %>
            <div class="table-wrapper">
                <table id="employeeTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-id-badge"></i> Emp No</th>
                            <th><i class="fas fa-user"></i> Name</th>
                            <th><i class="fas fa-calendar-alt"></i> Date of Joining</th>
                            <th><i class="fas fa-venus-mars"></i> Gender</th>
                            <th><i class="fas fa-dollar-sign"></i> Basic Salary</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for (Employee emp : employees) {
                        %>
                        <tr class="employee-row">
                            <td><span class="employee-id"><%= emp.getEmpno() %></span></td>
                            <td><span class="employee-name"><%= emp.getEmpName() %></span></td>
                            <td><%= emp.getDoJ() %></td>
                            <td>
                                <span class="gender-badge <%= emp.getGender().toLowerCase().equals("male") ? "gender-male" : "gender-female" %>">
                                    <%= emp.getGender() %>
                                </span>
                            </td>
                            <td><span class="salary">₹<%= String.format("%,.2f", emp.getBsalary()) %></span></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <%
            } else {
            %>
            <div class="no-data">
                <div class="no-data-icon">
                    <i class="fas fa-users-slash"></i>
                </div>
                <h3>No Employees Found</h3>
                <p>Start by adding some employees to your system.</p>
            </div>
            <%
            }
            %>
        </div>
        <a href="home.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i>
            Back to Home
        </a>
    </div>

    <script>
        // Add loading animation
        window.addEventListener('load', () => {
            document.body.classList.remove('loading');
            document.body.classList.add('loaded');
        });

        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const employeeRows = document.querySelectorAll('.employee-row');

        if (searchInput && employeeRows.length > 0) {
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                
                employeeRows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    if (text.includes(searchTerm)) {
                        row.style.display = '';
                        row.style.animation = 'fadeIn 0.3s ease';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        }

        // Add smooth transitions for navigation
        document.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', function(e) {
                if (this.getAttribute('href').endsWith('.jsp')) {
                    e.preventDefault();
                    document.body.style.opacity = '0';
                    setTimeout(() => {
                        window.location.href = this.getAttribute('href');
                    }, 300);
                }
            });
        });

        // Add fade in animation for search results
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>