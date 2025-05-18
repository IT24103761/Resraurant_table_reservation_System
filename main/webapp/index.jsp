<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amali Restaurant - Fine Dining Experience</title>
    <link rel="stylesheet" href="Restaurant/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<!-- Header with Navigation -->
<header class="header">
    <div class="container">
        <nav class="navbar">
            <div class="logo">
                <h1>Amali Restaurant</h1>
            </div>
            <ul class="nav-links">
                <li><a href="index.jsp" class="active">Home</a></li>
                <li><a href="Restaurant/page/menu.jsp">Menu</a></li>
                <li><a href="page/about.jsp">About</a></li>
                <li><a href="page/contact.jsp">Contact</a></li>
            </ul>
            <div class="auth-buttons">
                <% if (session.getAttribute("username") == null) { %>
                <div class="auth-buttons">
                    <a href="login.jsp" class="btn btn-login">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                    <a href="signUp.jsp" class="btn btn-signup">
                        <i class="fas fa-user-plus"></i> Sign Up
                    </a>
                </div>
                <% } else { %>
                <div class="user-profile">
                    <img src="img/user-icon.png" alt="User" width="30">
                    <span><%= session.getAttribute("username") %></span>
                    <a href="logout.jsp" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </div>
                <% } %>
            </div>
        </nav>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-content">
            <h2>Experience Culinary Excellence</h2>
            <p>Discover the art of fine dining at Amali Restaurant</p>
            <a href="Restaurant/page/reserve.jsp" class="btn btn-primary">Reserve a Table</a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="container">
        <h2 class="section-title">Why Choose Amali</h2>
        <div class="features-grid">
            <div class="feature-card">
                <i class="fas fa-utensils"></i>
                <h3>Gourmet Cuisine</h3>
                <p>Exquisite dishes prepared by our award-winning chefs using locally sourced ingredients</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-wine-glass-alt"></i>
                <h3>Fine Wines</h3>
                <p>Extensive selection of premium wines curated by our expert sommeliers</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-heart"></i>
                <h3>Romantic Ambiance</h3>
                <p>Perfect setting for special occasions and romantic evenings with elegant decor</p>
            </div>
        </div>
    </div>
</section>

<!-- Special Dishes Section -->
<section class="special-dishes">
    <div class="container">
        <h2 class="section-title">Our Signature Dishes</h2>
        <div class="dishes-grid">
            <div class="dish-card">
                <div class="dish-image" style="background-image: url('https://images.unsplash.com/photo-1559847844-5315695dadae?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80')"></div>
                <h3>Grilled Salmon</h3>
                <p>Fresh Atlantic salmon with lemon butter sauce</p>
            </div>
            <div class="dish-card">
                <div class="dish-image" style="background-image: url('https://images.unsplash.com/photo-1544025162-d76694265947?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80')"></div>
                <h3>Beef Wellington</h3>
                <p>Premium beef tenderloin wrapped in puff pastry</p>
            </div>
            <div class="dish-card">
                <div class="dish-image" style="background-image: url('https://images.unsplash.com/photo-1563805042-7684c019e1cb?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80')"></div>
                <h3>Chocolate Soufflé</h3>
                <p>Decadent chocolate dessert with vanilla ice cream</p>
            </div>
        </div>
        <div class="text-center">
            <a href="Restaurant/page/menu.jsp" class="btn btn-secondary">View Full Menu</a>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="testimonials">
    <div class="container">
        <h2 class="section-title">What Our Guests Say</h2>
        <div class="testimonials-slider">
            <div class="testimonial active">
                <div class="testimonial-content">
                    <p>"The best dining experience I've had in years. The food was exceptional and the service impeccable."</p>
                    <div class="guest-info">
                        <img src="https://randomuser.me/api/portraits/women/45.jpg" alt="Sarah Johnson">
                        <div>
                            <h4>Sarah Johnson</h4>
                            <span>Food Critic</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="testimonial">
                <div class="testimonial-content">
                    <p>"Amali Restaurant exceeded all our expectations. Perfect for our anniversary dinner!"</p>
                    <div class="guest-info">
                        <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Michael Chen">
                        <div>
                            <h4>Michael Chen</h4>
                            <span>Regular Guest</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="testimonial">
                <div class="testimonial-content">
                    <p>"The wine pairing was exceptional. Will definitely be coming back for more!"</p>
                    <div class="guest-info">
                        <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Emily Rodriguez">
                        <div>
                            <h4>Emily Rodriguez</h4>
                            <span>Wine Enthusiast</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="slider-controls">
            <button class="slider-prev"><i class="fas fa-chevron-left"></i></button>
            <div class="slider-dots"></div>
            <button class="slider-next"><i class="fas fa-chevron-right"></i></button>
        </div>
    </div>
</section>

<!-- Reservation CTA Section -->
<section class="reservation-cta">
    <div class="container">
        <div class="cta-content">
            <h2>Ready for an unforgettable dining experience?</h2>
            <p>Book your table now and let us take care of the rest</p>
            <a href="Restaurant/page/reserve.jsp" class="btn btn-primary">Make a Reservation</a>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h3>Amali Restaurant</h3>
                <p>123 Gourmet Avenue</p>
                <p>Foodie City, FC 12345</p>
            </div>
            <div class="footer-section">
                <h3>Hours</h3>
                <p>Monday - Friday: 11am - 10pm</p>
                <p>Saturday - Sunday: 10am - 11pm</p>
            </div>
            <div class="footer-section">
                <h3>Contact</h3>
                <p>reservations@amali.com</p>
                <p>(123) 456-7890</p>
            </div>
            <div class="footer-section">
                <h3>Follow Us</h3>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 Amali Restaurant. All rights reserved.</p>
            <div class="footer-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
            </div>
        </div>
    </div>
</footer>

<!-- Login Modal -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Login to Your Account</h2>
        <form id="loginForm" class="auth-form" action="login" method="POST">
            <div class="form-group">
                <label for="login-email">Email</label>
                <input type="email" id="login-email" name="email" required>
            </div>
            <div class="form-group">
                <label for="login-password">Password</label>
                <input type="password" id="login-password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
            <p class="auth-alternate">Don't have an account? <a href="page/register.jsp" id="switchToSignup">Sign up</a></p>
        </form>
    </div>
</div>

<script src="Restaurant/js/script.js"></script>
</body>
</html>