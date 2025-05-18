<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4a6bff;
            --primary-light: #e6eaff;
            --secondary-color: #6c757d;
            --success-color: #28a745;
            --success-light: #e6f7ee;
            --danger-color: #dc3545;
            --danger-light: #ffebee;
            --warning-color: #ffc107;
            --warning-light: #fff8e6;
            --info-color: #17a2b8;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
            --sidebar-width: 280px;
            --sidebar-collapsed-width: 80px;
            --header-height: 70px;
            --transition-speed: 0.3s;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            overflow-x: hidden;
            background-image: url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-blend-mode: overlay;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(135deg, #2c3e50, #4a6bff);
            color: white;
            transition: all var(--transition-speed) ease;
            position: fixed;
            height: 100vh;
            z-index: 100;
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.2);
        }

        .sidebar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .logo i {
            margin-right: 10px;
            font-size: 1.8rem;
            color: #fff;
        }

        .sidebar-toggle {
            background: none;
            border: none;
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            display: none;
        }

        .user-profile {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(0, 0, 0, 0.1);
        }

        .avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin: 0 auto 15px;
            overflow: hidden;
            border: 3px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-info h3 {
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .user-role {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.9);
            background: rgba(255, 255, 255, 0.15);
            padding: 3px 10px;
            border-radius: 20px;
            display: inline-block;
        }

        .sidebar-nav {
            padding: 20px 0;
        }

        .sidebar-nav ul {
            list-style: none;
        }

        .sidebar-nav li a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            transition: all 0.3s;
            margin: 5px 10px;
            border-radius: 5px;
        }

        .sidebar-nav li a i {
            margin-right: 10px;
            font-size: 1.1rem;
            width: 24px;
            text-align: center;
        }

        .sidebar-nav li a:hover {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            transform: translateX(5px);
        }

        .sidebar-nav li.active a {
            background: rgba(255, 255, 255, 0.25);
            color: white;
            border-left: 4px solid white;
            font-weight: 500;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: all var(--transition-speed) ease;
        }

        .main-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            height: var(--header-height);
            position: sticky;
            top: 0;
            z-index: 90;
            backdrop-filter: blur(5px);
        }

        .header-left h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark-color);
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            font-size: 0.85rem;
            color: var(--secondary-color);
            margin-top: 5px;
        }

        .breadcrumb a {
            color: var(--secondary-color);
            text-decoration: none;
            transition: all 0.3s;
        }

        .breadcrumb a:hover {
            color: var(--primary-color);
        }

        .breadcrumb span {
            margin: 0 8px;
            color: #ddd;
        }

        .breadcrumb .active {
            color: var(--primary-color);
            font-weight: 500;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .search-box {
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary-color);
        }

        .search-box input {
            padding: 8px 15px 8px 35px;
            border: 1px solid #ddd;
            border-radius: 30px;
            width: 200px;
            transition: all 0.3s;
            background: rgba(255, 255, 255, 0.8);
        }

        .search-box input:focus {
            width: 250px;
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(74, 107, 255, 0.2);
        }

        .notification {
            position: relative;
            cursor: pointer;
        }

        .notification i {
            font-size: 1.2rem;
            color: var(--secondary-color);
            transition: all 0.3s;
        }

        .notification:hover i {
            color: var(--primary-color);
        }

        .notification .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger-color);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: bold;
        }

        .btn-login {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 30px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-login:hover {
            background: #3a5bed;
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(74, 107, 255, 0.3);
        }

        .btn-login i {
            font-size: 0.9rem;
        }

        .content-wrapper {
            padding: 30px;
        }

        /* Stats Section */
        .stats-section {
            margin-bottom: 30px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            transition: all 0.3s;
            border: 1px solid rgba(0, 0, 0, 0.05);
            backdrop-filter: blur(5px);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.5rem;
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .stat-card.primary .stat-icon {
            background: var(--primary-color);
        }

        .stat-card.success .stat-icon {
            background: var(--success-color);
        }

        .stat-card.warning .stat-icon {
            background: var(--warning-color);
        }

        .stat-card.danger .stat-icon {
            background: var(--danger-color);
        }

        .stat-info h3 {
            font-size: 1.8rem;
            margin-bottom: 5px;
            color: var(--dark-color);
        }

        .stat-info p {
            color: var(--secondary-color);
            font-size: 0.9rem;
        }

        /* Tables Section */
        .tables-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.05);
            backdrop-filter: blur(5px);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .section-header h2 {
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            color: var(--dark-color);
        }

        .section-header h2 i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .section-actions {
            display: flex;
            gap: 10px;
        }

        /* Buttons */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            font-size: 0.9rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            font-weight: 500;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
            box-shadow: 0 2px 5px rgba(74, 107, 255, 0.3);
        }

        .btn-primary:hover {
            background: #3a5bed;
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(74, 107, 255, 0.3);
        }

        .btn-secondary {
            background: var(--secondary-color);
            color: white;
            box-shadow: 0 2px 5px rgba(108, 117, 125, 0.3);
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(108, 117, 125, 0.3);
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 0.8rem;
        }

        /* Data Table */
        .table-responsive {
            overflow-x: auto;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .data-table th, .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .data-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: var(--dark-color);
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }

        .data-table tr:hover {
            background: #f9f9f9;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-badge i {
            margin-right: 5px;
            font-size: 0.7rem;
        }

        .status-badge.available {
            background: var(--success-light);
            color: var(--success-color);
        }

        .status-badge.reserved {
            background: var(--danger-light);
            color: var(--danger-color);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-view {
            background: var(--primary-light);
            color: var(--primary-color);
            border: 1px solid rgba(74, 107, 255, 0.2);
        }

        .btn-view:hover {
            background: rgba(74, 107, 255, 0.1);
        }

        .btn-edit {
            background: var(--warning-light);
            color: var(--warning-color);
            border: 1px solid rgba(255, 193, 7, 0.2);
        }

        .btn-edit:hover {
            background: rgba(255, 193, 7, 0.1);
        }

        .btn-delete {
            background: var(--danger-light);
            color: var(--danger-color);
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        .btn-delete:hover {
            background: rgba(220, 53, 69, 0.1);
        }

        /* Customer Dashboard */
        .customer-dashboard {
            margin-bottom: 30px;
        }

        .welcome-banner {
            background: linear-gradient(135deg, var(--primary-color), #6a5acd);
            border-radius: 10px;
            padding: 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            box-shadow: 0 10px 20px rgba(74, 107, 255, 0.3);
            background-image: url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-blend-mode: overlay;
            position: relative;
            overflow: hidden;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(74, 107, 255, 0.9), rgba(106, 90, 205, 0.9));
            z-index: 1;
        }

        .welcome-content {
            position: relative;
            z-index: 2;
            flex: 1;
        }

        .welcome-content h2 {
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .welcome-content p {
            margin-bottom: 20px;
            opacity: 0.9;
            max-width: 600px;
        }

        .welcome-image {
            width: 200px;
            position: relative;
            z-index: 2;
        }

        .welcome-image img {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .available-tables {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.05);
            backdrop-filter: blur(5px);
        }

        .filter-options {
            display: flex;
            gap: 15px;
        }

        .form-control {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9rem;
            background: white;
            transition: all 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(74, 107, 255, 0.2);
        }

        .tables-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .table-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .table-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .table-image {
            position: relative;
            height: 160px;
            overflow: hidden;
        }

        .table-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.5s;
        }

        .table-card:hover .table-image img {
            transform: scale(1.05);
        }

        .capacity-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .table-info {
            padding: 15px;
        }

        .table-info h3 {
            font-size: 1.2rem;
            margin-bottom: 8px;
            color: var(--dark-color);
        }

        .table-location {
            color: var(--secondary-color);
            font-size: 0.9rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .table-location i {
            margin-right: 5px;
        }

        .table-features {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .table-features span {
            font-size: 0.8rem;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            background: #f5f5f5;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .table-features i {
            margin-right: 5px;
        }

        .table-actions {
            padding: 0 15px 15px;
            display: flex;
            gap: 10px;
        }

        .btn-reserve {
            background: var(--primary-color);
            color: white;
            flex: 1;
            box-shadow: 0 2px 5px rgba(74, 107, 255, 0.3);
        }

        .btn-reserve:hover {
            background: #3a5bed;
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(74, 107, 255, 0.3);
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .sidebar {
                width: var(--sidebar-collapsed-width);
            }

            .sidebar-header span,
            .user-info h3,
            .sidebar-nav li a span {
                display: none;
            }

            .sidebar-nav li a {
                justify-content: center;
                margin: 5px;
                padding: 12px 0;
            }

            .sidebar-nav li a i {
                margin-right: 0;
                font-size: 1.3rem;
            }

            .main-content {
                margin-left: var(--sidebar-collapsed-width);
            }

            .sidebar-toggle {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .main-header {
                flex-direction: column;
                align-items: flex-start;
                height: auto;
                padding: 15px;
            }

            .header-left, .header-right {
                width: 100%;
            }

            .header-right {
                margin-top: 15px;
                justify-content: space-between;
            }

            .search-box input {
                width: 150px;
            }

            .welcome-banner {
                flex-direction: column;
                text-align: center;
            }

            .welcome-image {
                margin-top: 20px;
            }

            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .section-actions {
                margin-top: 15px;
                width: 100%;
                justify-content: flex-end;
            }
        }

        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .tables-grid {
                grid-template-columns: 1fr;
            }

            .search-box input {
                width: 120px;
            }

            .header-right {
                gap: 10px;
            }

            .btn-login span {
                display: none;
            }

            .btn-login {
                padding: 8px;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                justify-content: center;
            }

            .btn-login i {
                margin-right: 0;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar Navigation -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="logo">
                <i class="fas fa-utensils"></i>
                <span>RestaurantPro</span>
            </div>
            <button class="sidebar-toggle" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <div class="user-profile">
            <div class="avatar">
                <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&auto=format&fit=crop&w=80&h=80&q=80" alt="User Avatar">
            </div>
            <div class="user-info">
                <h3>John Doe</h3>
                <p class="user-role">Administrator</p>
            </div>
        </div>

        <nav class="sidebar-nav">
            <ul>
                <li class="active">
                    <a href="dashboard.html">
                        <i class="fas fa-home"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="admin.html">
                        <i class="fas fa-cog"></i>
                        <span>Admin Panel</span>
                    </a>
                </li>
                <li>
                    <a href="tables.html">
                        <i class="fas fa-table"></i>
                        <span>Manage Tables</span>
                    </a>
                </li>
                <li>
                    <a href="users.html">
                        <i class="fas fa-users"></i>
                        <span>Manage Users</span>
                    </a>
                </li>
                <li>
                    <a href="reports.html">
                        <i class="fas fa-chart-bar"></i>
                        <span>Reports</span>
                    </a>
                </li>
                <li>
                    <a href="profile.html">
                        <i class="fas fa-user"></i>
                        <span>My Profile</span>
                    </a>
                </li>
                <li>
                    <a href="login.html">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content Area -->
    <main class="main-content">
        <header class="main-header">
            <div class="header-left">
                <h1>Dashboard Overview</h1>
                <nav class="breadcrumb">
                    <a href="#">Home</a>
                    <span>/</span>
                    <a href="#" class="active">Dashboard</a>
                </nav>
            </div>
            <div class="header-right">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>
                <div class="notification">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <button class="btn-login">
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Login</span>
                </button>
            </div>
        </header>

        <div class="content-wrapper">
            <section class="welcome-banner">
                <div class="welcome-content">
                    <h2>Welcome to RestaurantPro</h2>
                    <p>Manage your restaurant tables, reservations, and customers with our powerful dashboard. Get real-time updates and analytics to optimize your operations.</p>
                    <button class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Table
                    </button>
                </div>
                <div class="welcome-image">
                    <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80" alt="Restaurant Interior">
                </div>
            </section>

            <section class="stats-section">
                <div class="stats-grid">
                    <div class="stat-card primary">
                        <div class="stat-icon">
                            <i class="fas fa-table"></i>
                        </div>
                        <div class="stat-info">
                            <h3>24</h3>
                            <p>Total Tables</p>
                        </div>
                    </div>
                    <div class="stat-card success">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-info">
                            <h3>18</h3>
                            <p>Available Tables</p>
                        </div>
                    </div>
                    <div class="stat-card warning">
                        <div class="stat-icon">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="stat-info">
                            <h3>6</h3>
                            <p>Reserved Tables</p>
                        </div>
                    </div>
                    <div class="stat-card danger">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3>24</h3>
                            <p>Active Customers</p>
                        </div>
                    </div>
                </div>
            </section>

            <section class="tables-section">
                <div class="section-header">
                    <h2><i class="fas fa-table"></i> Table Status</h2>
                    <div class="section-actions">
                        <button class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Table
                        </button>
                        <button class="btn btn-secondary">
                            <i class="fas fa-sync-alt"></i> Refresh
                        </button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Table ID</th>
                            <th>Capacity</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>T-101</td>
                            <td>4 persons</td>
                            <td>Main Hall</td>
                            <td>
                                <span class="status-badge available">
                                    <i class="fas fa-check-circle"></i>
                                    Available
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn btn-sm btn-view">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>T-102</td>
                            <td>6 persons</td>
                            <td>Patio</td>
                            <td>
                                <span class="status-badge reserved">
                                    <i class="fas fa-times-circle"></i>
                                    Reserved
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn btn-sm btn-view">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>T-103</td>
                            <td>2 persons</td>
                            <td>Window Side</td>
                            <td>
                                <span class="status-badge available">
                                    <i class="fas fa-check-circle"></i>
                                    Available
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn btn-sm btn-view">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>T-104</td>
                            <td>8 persons</td>
                            <td>Private Room</td>
                            <td>
                                <span class="status-badge reserved">
                                    <i class="fas fa-times-circle"></i>
                                    Reserved
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn btn-sm btn-view">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </main>
</div>

<script>
    // Toggle sidebar on mobile
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');

        if (sidebar.style.width === 'var(--sidebar-collapsed-width)') {
            sidebar.style.width = 'var(--sidebar-width)';
            mainContent.style.marginLeft = 'var(--sidebar-width)';
        } else {
            sidebar.style.width = 'var(--sidebar-collapsed-width)';
            mainContent.style.marginLeft = 'var(--sidebar-collapsed-width)';
        }
    });

    // Table actions
    document.querySelectorAll('.btn-view').forEach(btn => {
        btn.addEventListener('click', function() {
            alert('View table details');
        });
    });

    document.querySelectorAll('.btn-edit').forEach(btn => {
        btn.addEventListener('click', function() {
            alert('Edit table');
        });
    });

    document.querySelectorAll('.btn-delete').forEach(btn => {
        btn.addEventListener('click', function() {
            if (confirm('Are you sure you want to delete this table?')) {
                alert('Table deleted');
            }
        });
    });

    // Login button action
    document.querySelector('.btn-login').addEventListener('click', function() {
        alert('Login button clicked');
    });

    // Responsive adjustments
    function handleResponsive() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        if (window.innerWidth < 992) {
            document.querySelector('.sidebar').style.width = 'var(--sidebar-collapsed-width)';
            document.querySelector('.main-content').style.marginLeft = 'var(--sidebar-collapsed-width)';
            sidebarToggle.style.display = 'block';
        } else {
            document.querySelector('.sidebar').style.width = 'var(--sidebar-width)';
            document.querySelector('.main-content').style.marginLeft = 'var(--sidebar-width)';
            sidebarToggle.style.display = 'none';
        }
    }

    // Run on load and resize
    window.addEventListener('load', handleResponsive);
    window.addEventListener('resize', handleResponsive);

    // Notification click
    document.querySelector('.notification').addEventListener('click', function() {
        alert('You have 3 new notifications');
    });

    // Search functionality
    const searchInput = document.querySelector('.search-box input');
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            alert(`Searching for: ${this.value}`);
            this.value = '';
        }
    });

    // Add table button
    document.querySelectorAll('.btn-primary').forEach(btn => {
        if (btn.textContent.includes('Add Table') || btn.textContent.includes('Add New Table')) {
            btn.addEventListener('click', function() {
                alert('Add new table form will open');
            });
        }
    });

    // Refresh button
    document.querySelector('.btn-secondary').addEventListener('click', function() {
        if (this.textContent.includes('Refresh')) {
            alert('Refreshing table data...');
            // In a real app, you would fetch new data here
        }
    });

    // Welcome banner button
    document.querySelector('.welcome-content .btn-primary').addEventListener('click', function() {
        alert('Opening table creation form');
    });

    // Simulate loading data
    setTimeout(() => {
        console.log('Dashboard data loaded');
    }, 1000);
</script>
</body>
</html>