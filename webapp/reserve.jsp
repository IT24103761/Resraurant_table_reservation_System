<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gourmet Haven - Table Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/reserve.css">
</head>
<body>
<div class="reservation-container">
    <div class="reservation-header">
        <div class="header-overlay"></div>
        <h1>Reserve Your Table</h1>
        <p>Experience culinary excellence in our elegant dining space</p>
    </div>

    <div class="reservation-form-container">
        <form id="reservationForm" action="ReservationServlet" method="POST">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" required placeholder="Enter your full name">
                <i class="fas fa-user"></i>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
                <i class="fas fa-envelope"></i>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" required placeholder="Enter your phone number">
                <i class="fas fa-phone"></i>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="date">Reservation Date</label>
                    <input type="date" id="date" name="date" required>
                    <i class="fas fa-calendar-alt"></i>
                </div>

                <div class="form-group">
                    <label for="time">Time</label>
                    <input type="time" id="time" name="time" required>
                    <i class="fas fa-clock"></i>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="guests">Number of Guests</label>
                    <select id="guests" name="guests" required>
                        <option value="" disabled selected>Select guests</option>
                        <option value="1">1 Person</option>
                        <option value="2">2 People</option>
                        <option value="3">3 People</option>
                        <option value="4">4 People</option>
                        <option value="5">5 People</option>
                        <option value="6">6 People</option>
                        <option value="7">7 People</option>
                        <option value="8">8 People</option>
                        <option value="9">9+ People</option>
                    </select>
                    <i class="fas fa-users"></i>
                </div>

                <div class="form-group">
                    <label for="tableType">Table Preference</label>
                    <select id="tableType" name="tableType">
                        <option value="" disabled selected>Select table type</option>
                        <option value="standard">Standard</option>
                        <option value="window">Window View</option>
                        <option value="booth">Booth</option>
                        <option value="outdoor">Outdoor</option>
                        <option value="private">Private Room</option>
                    </select>
                    <i class="fas fa-chair"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="specialRequests">Special Requests</label>
                <textarea id="specialRequests" name="specialRequests" rows="3" placeholder="Any special requests?"></textarea>
                <i class="fas fa-comment-alt"></i>
            </div>

            <div class="form-submit">
                <button type="submit" class="submit-btn">Reserve Table</button>
            </div>
        </form>

        <div class="restaurant-info">
            <div class="info-card">
                <div class="info-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="info-content">
                    <h3>Location</h3>
                    <p>123 Gourmet Street, Culinary District</p>
                </div>
            </div>

            <div class="info-card">
                <div class="info-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <div class="info-content">
                    <h3>Phone</h3>
                    <p>+1 (555) 123-4567</p>
                </div>
            </div>

            <div class="info-card">
                <div class="info-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="info-content">
                    <h3>Opening Hours</h3>
                    <p>Mon-Fri: 11:00 AM - 11:00 PM</p>
                    <p>Sat-Sun: 10:00 AM - 12:00 AM</p>
                </div>
            </div>
        </div>
    </div>

    <div class="restaurant-gallery">
        <h2>Our Dining Space</h2>
        <div class="gallery-container">
            <div class="gallery-item" style="background-image: url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
            <div class="gallery-item" style="background-image: url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
            <div class="gallery-item" style="background-image: url('https://images.unsplash.com/photo-1544148103-0773bf10d330?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
        </div>
    </div>
</div>

<div id="confirmationModal" class="modal">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <div class="modal-icon success">
            <i class="fas fa-check-circle"></i>
        </div>
        <h2>Reservation Confirmed!</h2>
        <p id="confirmationMessage">Your table has been successfully reserved. We look forward to serving you.</p>
        <button class="modal-btn" id="closeModalBtn">Done</button>
    </div>
</div>

<script src="../js/reserve.js"></script>
</body>
</html>