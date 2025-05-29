<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Report | JavaTech</title>
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

        .back-btn {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            box-shadow: 0 4px 16px rgba(79, 172, 254, 0.3);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
        }

        .back-btn:active {
            transform: translateY(0);
        }

        /* Main Content */
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 3rem 2rem;
        }

        .page-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title h2 {
            font-family: 'Poppins', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            margin-bottom: 1rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 1s ease;
        }

        .page-title p {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
            animation: fadeInUp 1s ease 0.2s both;
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

        /* Form Container */
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideInUp 0.6s ease forwards;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.5s;
        }

        .form-container:hover::before {
            left: 100%;
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

        .form-icon {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-icon i {
            font-size: 3rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Form Styles */
        form {
            position: relative;
            z-index: 1;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        label {
            display: block;
            font-weight: 500;
            color: #4a5568;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 2px solid rgba(102, 126, 234, 0.1);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        input::placeholder {
            color: #a0aec0;
            font-style: italic;
        }

        /* Checkbox Styles */
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.5rem;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            border-radius: 12px;
            margin-bottom: 2rem;
            transition: all 0.3s ease;
        }

        .checkbox-group:hover {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.15), rgba(118, 75, 162, 0.15));
            transform: translateY(-2px);
        }

        .checkbox-wrapper {
            position: relative;
        }

        input[type="checkbox"] {
            appearance: none;
            width: 24px;
            height: 24px;
            border: 2px solid #667eea;
            border-radius: 6px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        input[type="checkbox"]:checked {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-color: #667eea;
        }

        input[type="checkbox"]:checked::before {
            content: '✓';
            position: absolute;
            color: white;
            font-size: 14px;
            font-weight: bold;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .checkbox-label {
            font-size: 1.1rem;
            font-weight: 500;
            color: #2d3748;
            cursor: pointer;
            margin: 0;
            text-transform: none;
            letter-spacing: normal;
        }

        /* Button Styles */
        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .submit-btn {
            background: linear-gradient(135deg, #43e97b, #38f9d7);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 16px rgba(67, 233, 123, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(67, 233, 123, 0.4);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .reset-btn {
            background: linear-gradient(135deg, #ff9a9e, #fecfef);
            color: #2d3748;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 16px rgba(255, 154, 158, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .reset-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 154, 158, 0.4);
        }

        .reset-btn:active {
            transform: translateY(-1px);
        }

        /* Back Link */
        .back-link-section {
            text-align: center;
            margin-top: 3rem;
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

        .back-link:active {
            transform: translateY(0);
        }

        /* Info Cards */
        .info-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .info-card {
            background: rgba(255, 255, 255, 0.5);
            padding: 1rem;
            border-radius: 12px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .info-card i {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: #667eea;
        }

        .info-card h4 {
            font-size: 0.9rem;
            color: #4a5568;
            margin-bottom: 0.25rem;
        }

        .info-card p {
            font-size: 0.8rem;
            color: #718096;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header {
                padding: 1rem;
            }

            .company-name {
                font-size: 1.4rem;
            }

            .page-title h2 {
                font-size: 2rem;
            }

            .container {
                padding: 2rem 1rem;
            }

            .form-container {
                padding: 2rem;
                border-radius: 16px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .btn-group {
                flex-direction: column;
            }

            .submit-btn,
            .reset-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .page-title h2 {
                font-size: 1.8rem;
            }

            .page-title p {
                font-size: 1rem;
            }

            .form-container {
                padding: 1.5rem;
            }

            .info-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
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
        
       
    </div>

    <div class="container">
        <div class="page-title">
            <h2>Generate Employee Report</h2>
            <p>Create customized reports with advanced filtering options</p>
        </div>

        <div class="info-cards">
            <div class="info-card">
                <i class="fas fa-filter"></i>
                <h4>Smart Filtering</h4>
                <p>Use multiple criteria to find specific employees</p>
            </div>
            <div class="info-card">
                <i class="fas fa-chart-line"></i>
                <h4>Detailed Reports</h4>
                <p>Generate comprehensive employee analytics</p>
            </div>
            <div class="info-card">
                <i class="fas fa-download"></i>
                <h4>Export Ready</h4>
                <p>Reports ready for printing and sharing</p>
            </div>
        </div>

        <div class="form-container">
            <div class="form-icon">
                <i class="fas fa-chart-bar"></i>
            </div>

            <form action="reportFilter" method="post" id="reportForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="startsWith">
                            <i class="fas fa-font"></i> Start Name With:
                        </label>
                        <input type="text" id="startsWith" name="startsWith" maxlength="1" 
                               placeholder="e.g., A" style="text-transform: uppercase;" />
                    </div>

                    <div class="form-group">
                        <label for="minYears">
                            <i class="fas fa-calendar-alt"></i> Years of Service (≥):
                        </label>
                        <input type="number" id="minYears" name="minYears" min="0" 
                               placeholder="e.g., 5" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="minSalary">
                        <i class="fas fa-rupee-sign"></i> Minimum Salary (>):
                    </label>
                    <input type="number" id="minSalary" name="minSalary" min="0" step="0.01" 
                           placeholder="e.g., 30000" />
                </div>

                <div class="checkbox-group">
                    <div class="checkbox-wrapper">
                        <input type="checkbox" id="showAll" name="showAll" value="true" />
                    </div>
                    <label for="showAll" class="checkbox-label">
                        <i class="fas fa-users"></i> Show All Employees (Ignore all filters)
                    </label>
                </div>

                <div class="btn-group">
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-chart-line"></i> Generate Report
                    </button>
                    <button type="reset" class="reset-btn">
                        <i class="fas fa-undo"></i> Reset Filters
                    </button>
                </div>
            </form>
        </div>

        <div class="back-link-section">
            <a href="home.jsp" class="back-link">
                <i class="fas fa-home"></i> Back to Home
            </a>
        </div>
    </div>

    <script>
        // Form validation and enhancements
        const form = document.getElementById('reportForm');
        const showAllCheckbox = document.getElementById('showAll');
        const formInputs = document.querySelectorAll('input[type="text"], input[type="number"]');

        // Handle show all checkbox
        showAllCheckbox.addEventListener('change', function() {
            formInputs.forEach(input => {
                if (this.checked) {
                    input.disabled = true;
                    input.style.opacity = '0.5';
                } else {
                    input.disabled = false;
                    input.style.opacity = '1';
                }
            });
        });

        // Auto-uppercase for name starts with
        document.getElementById('startsWith').addEventListener('input', function() {
            this.value = this.value.toUpperCase();
        });

        // Form submission validation
        form.addEventListener('submit', function(e) {
            if (!showAllCheckbox.checked) {
                const hasFilters = Array.from(formInputs).some(input => input.value.trim() !== '');
                if (!hasFilters) {
                    e.preventDefault();
                    alert('Please apply at least one filter or select "Show All Employees"');
                    return;
                }
            }
            
            // Add loading state
            const submitBtn = document.querySelector('.submit-btn');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Generating...';
            submitBtn.disabled = true;
        });

        // Add smooth scroll behavior
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Add loading animation
        window.addEventListener('load', () => {
            document.body.style.opacity = '1';
            document.body.style.transition = 'opacity 0.5s ease';
        });

        // Format salary input with commas
        document.getElementById('minSalary').addEventListener('input', function() {
            let value = this.value.replace(/,/g, '');
            if (value && !isNaN(value)) {
                this.value = Number(value).toLocaleString('en-IN');
            }
        });

        // Remove commas before form submission
        form.addEventListener('submit', function() {
            const salaryInput = document.getElementById('minSalary');
            salaryInput.value = salaryInput.value.replace(/,/g, '');
        });
    </script>
</body>
</html>