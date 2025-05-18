<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amali Restaurant - Dashboard</title>
    <link rel="stylesheet" href="Restaurant/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Amali Restaurant</h2>
            <p>Admin Dashboard</p>
        </div>
        <nav class="sidebar-nav">
            <ul>
                <li class="active">
                    <a href="#">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Reservations</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-users"></i>
                        <span>Customers</span>
                    </a>
                </li>
                <li>
                    <a href="Restaurant/page/menu.jsp">
                        <i class="fas fa-utensils"></i>
                        <span>Menu Items</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-cog"></i>
                        <span>Settings</span>
                    </a>
                </li>
                <li>
                    <a href="login.jsp">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <div class="restaurant-status">
                <div class="status-indicator online"></div>
                <span>Restaurant Open</span>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Navigation -->
        <header class="top-nav">
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search...">
            </div>
            <div class="user-profile">
                <div class="notifications">
                    <i class="fas fa-bell"></i>
                    <span class="notification-count">3</span>
                </div>
                <div class="profile">
                    <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Admin">
                    <span>Admin User</span>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            <h2>Dashboard Overview</h2>

            <!-- Stats Cards -->
            <div class="stats-cards">
                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #3498db;">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Today's Reservations</h3>
                        <p class="stat-value">24</p>
                        <p class="stat-change positive">+12% from yesterday</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #2ecc71;">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Total Customers</h3>
                        <p class="stat-value">1,245</p>
                        <p class="stat-change positive">+5% this month</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #e74c3c;">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Menu Items</h3>
                        <p class="stat-value">58</p>
                        <p class="stat-change">No change</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="background-color: #f39c12;">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Average Rating</h3>
                        <p class="stat-value">4.7</p>
                        <p class="stat-change positive">+0.2 this month</p>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-section">
                <div class="chart-card">
                    <h3>Reservations This Week</h3>
                    <div class="chart-container">
                        <canvas id="reservationsChart"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3>Revenue Overview</h3>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Recent Reservations -->
            <div class="recent-reservations">
                <div class="section-header">
                    <h3>Recent Reservations</h3>
                    <a href="#" class="view-all">View All</a>
                </div>
                <div class="reservations-table">
                    <table>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Date & Time</th>
                            <th>Guests</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#1254</td>
                            <td>
                                <div class="customer-info">
                                    <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Customer">
                                    <span>Sarah Johnson</span>
                                </div>
                            </td>
                            <td>Today, 7:30 PM</td>
                            <td>4</td>
                            <td><span class="status confirmed">Confirmed</span></td>
                            <td>
                                <button class="action-btn view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>#1253</td>
                            <td>
                                <div class="customer-info">
                                    <img src="https://randomuser.me/api/portraits/men/22.jpg" alt="Customer">
                                    <span>Michael Brown</span>
                                </div>
                            </td>
                            <td>Today, 6:00 PM</td>
                            <td>2</td>
                            <td><span class="status confirmed">Confirmed</span></td>
                            <td>
                                <button class="action-btn view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>#1252</td>
                            <td>
                                <div class="customer-info">
                                    <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Customer">
                                    <span>Emily Davis</span>
                                </div>
                            </td>
                            <td>Tomorrow, 8:00 PM</td>
                            <td>6</td>
                            <td><span class="status pending">Pending</span></td>
                            <td>
                                <button class="action-btn view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>#1251</td>
                            <td>
                                <div class="customer-info">
                                    <img src="https://randomuser.me/api/portraits/men/75.jpg" alt="Customer">
                                    <span>Robert Wilson</span>
                                </div>
                            </td>
                            <td>Tomorrow, 7:00 PM</td>
                            <td>3</td>
                            <td><span class="status cancelled">Cancelled</span></td>
                            <td>
                                <button class="action-btn view"><i class="fas fa-eye"></i></button>
                                <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
<script src="Restaurant/js/dashboard.js"></script>
</body>
</html>
