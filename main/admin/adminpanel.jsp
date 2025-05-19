<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Restaurant Admin Panel</title>
  <link rel="stylesheet" href="css/admin.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="admin-container">
  <header class="admin-header">
    <h1><i class="fas fa-utensils"></i> Restaurant Admin Panel</h1>
    <nav class="admin-nav">
      <ul>
        <li class="active"><a href="#" data-section="dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
        <li><a href="#" data-section="feedback"><i class="fas fa-comment-alt"></i> Customer Feedback</a></li>
        <li><a href="#" data-section="analytics"><i class="fas fa-chart-bar"></i> Analytics</a></li>
        <li><a href="#" data-section="settings"><i class="fas fa-cog"></i> Settings</a></li>
      </ul>
    </nav>
    <div class="admin-logout">
      <a href="login.html"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
  </header>

  <main class="admin-main">
    <!-- Dashboard Section -->
    <section id="dashboard-section" class="admin-section active">
      <h2><i class="fas fa-tachometer-alt"></i> Dashboard Overview</h2>
      <div class="dashboard-cards">
        <div class="card">
          <div class="card-icon" style="background-color: #3498db;">
            <i class="fas fa-comments"></i>
          </div>
          <div class="card-content">
            <h3>Total Feedback</h3>
            <p id="total-feedback">0</p>
          </div>
        </div>
        <div class="card">
          <div class="card-icon" style="background-color: #2ecc71;">
            <i class="fas fa-smile"></i>
          </div>
          <div class="card-content">
            <h3>Positive Ratings</h3>
            <p id="positive-ratings">0</p>
          </div>
        </div>
        <div class="card">
          <div class="card-icon" style="background-color: #e74c3c;">
            <i class="fas fa-frown"></i>
          </div>
          <div class="card-content">
            <h3>Negative Ratings</h3>
            <p id="negative-ratings">0</p>
          </div>
        </div>
        <div class="card">
          <div class="card-icon" style="background-color: #f39c12;">
            <i class="fas fa-reply"></i>
          </div>
          <div class="card-content">
            <h3>Responded To</h3>
            <p id="responded-feedback">0</p>
          </div>
        </div>
      </div>

      <div class="recent-feedback">
        <h3>Recent Feedback</h3>
        <div id="recent-feedback-list" class="feedback-list">
          <!-- Recent feedback will be loaded here -->
        </div>
      </div>
    </section>

    <!-- Feedback Management Section -->
    <section id="feedback-section" class="admin-section">
      <h2><i class="fas fa-comment-alt"></i> Customer Feedback Management</h2>
      <div class="feedback-controls">
        <div class="search-filter">
          <input type="text" id="feedback-search" placeholder="Search feedback...">
          <select id="rating-filter">
            <option value="0">All Ratings</option>
            <option value="1">1 Star (Terrible)</option>
            <option value="2">2 Stars (Bad)</option>
            <option value="3">3 Stars (Okay)</option>
            <option value="4">4 Stars (Good)</option>
            <option value="5">5 Stars (Excellent)</option>
          </select>
          <select id="response-filter">
            <option value="all">All Responses</option>
            <option value="responded">Responded</option>
            <option value="unresponded">Unresponded</option>
          </select>
        </div>
      </div>

      <div id="all-feedback-list" class="feedback-list">
        <!-- All feedback will be loaded here -->
      </div>
    </section>

    <!-- Analytics Section -->
    <section id="analytics-section" class="admin-section">
      <h2><i class="fas fa-chart-bar"></i> Feedback Analytics</h2>
      <div class="analytics-charts">
        <div class="chart-container">
          <h3>Rating Distribution</h3>
          <canvas id="rating-chart"></canvas>
        </div>
        <div class="chart-container">
          <h3>Feedback Trends</h3>
          <canvas id="trend-chart"></canvas>
        </div>
      </div>
    </section>

    <!-- Settings Section -->
    <section id="settings-section" class="admin-section">
      <h2><i class="fas fa-cog"></i> Restaurant Settings</h2>
      <form id="restaurant-settings">
        <div class="form-group">
          <label for="restaurant-name">Restaurant Name</label>
          <input type="text" id="restaurant-name" name="restaurant-name" required>
        </div>
        <div class="form-group">
          <label for="admin-email">Admin Email</label>
          <input type="email" id="admin-email" name="admin-email" required>
        </div>
        <div class="form-group">
          <label for="notification-pref">Notification Preferences</label>
          <select id="notification-pref" name="notification-pref">
            <option value="all">All feedback</option>
            <option value="negative">Only negative feedback</option>
            <option value="none">No notifications</option>
          </select>
        </div>
        <button type="submit" class="save-btn">Save Settings</button>
      </form>
    </section>
  </main>
</div>

<!-- Feedback Response Modal -->
<div id="response-modal" class="modal">
  <div class="modal-content">
    <span class="close-modal">&times;</span>
    <h3>Respond to Feedback</h3>
    <div id="feedback-details" class="feedback-details">
      <!-- Feedback details will be loaded here -->
    </div>
    <form id="response-form">
      <input type="hidden" id="response-feedback-id">
      <div class="form-group">
        <label for="admin-response">Your Response</label>
        <textarea id="admin-response" name="admin-response" rows="4" required></textarea>
      </div>
      <button type="submit" class="submit-btn">Send Response</button>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="js/admin.js"></script>
</body>
</html>