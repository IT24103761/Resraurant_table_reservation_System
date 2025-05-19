<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amali Restaurant - Login</title>
    <link rel="stylesheet" href="Restaurant/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="login-background">
    <div class="login-container">
        <div class="login-card">
            <div class="logo">
                <img src="https://graphicsfamily.com/wp-content/uploads/edd/2023/02/Restaurant-Logo-Design-2-2048x1152.jpg" alt="Amali Restaurant Logo">
                <h2>Welcome Back</h2>
                <p>Sign in to continue to your account</p>
            </div>

            <%-- Error message display --%>
            <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span><%= request.getAttribute("error") %></span>
            </div>
            <% } %>

            <%-- Success message display --%>
            <% if(request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span><%= request.getAttribute("success") %></span>
            </div>
            <% } %>

            <form id="loginForm" class="login-form" method="POST" action="login">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>
                    <span class="input-error" id="email-error"></span>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                        <i class="fas fa-eye toggle-password" id="togglePassword"></i>
                    </div>
                    <span class="input-error" id="password-error"></span>
                </div>

                <div class="form-options">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="forgot-password.jsp" class="forgot-password">Forgot password?</a>
                </div>

                <button type="submit" class="login-btn" id="loginBtn">
                    <span class="btn-text">Login</span>
                    <div class="spinner hidden">
                        <i class="fas fa-spinner fa-spin"></i>
                    </div>
                </button>
            </form>

            <div class="divider">
                <span>or continue with</span>
            </div>

            <div class="social-login">
                <a href="#" class="social-btn google">
                    <i class="fab fa-google"></i> Google
                </a>
                <a href="#" class="social-btn facebook">
                    <i class="fab fa-facebook-f"></i> Facebook
                </a>
            </div>

            <div class="register-link">
                Don't have an account? <a href="register.jsp">Create account</a>
            </div>
        </div>
    </div>
</div>

<script src="Restaurant/js/login.js"></script>
</body>
</html>