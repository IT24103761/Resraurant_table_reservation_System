<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Feedback</title>
    <link rel="stylesheet" href="css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="feedback-container">
    <h1>Share Your Dining Experience</h1>

    <!-- Feedback Form -->
    <form id="feedbackForm" action="FeedbackServlet" method="post">
        <input type="hidden" id="feedbackId" name="feedbackId" value="">
        <input type="hidden" id="action" name="action" value="add">

        <div class="form-group">
            <label for="name">Your Name:</label>
            <input type="text" id="name" name="name" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label>Rate Your Experience:</label>
            <div class="reaction-container">
                <div class="reaction" data-value="1">
                    <i class="far fa-angry"></i>
                    <span>Terrible</span>
                </div>
                <div class="reaction" data-value="2">
                    <i class="far fa-frown"></i>
                    <span>Bad</span>
                </div>
                <div class="reaction" data-value="3">
                    <i class="far fa-meh"></i>
                    <span>Okay</span>
                </div>
                <div class="reaction" data-value="4">
                    <i class="far fa-smile"></i>
                    <span>Good</span>
                </div>
                <div class="reaction" data-value="5">
                    <i class="far fa-laugh"></i>
                    <span>Excellent</span>
                </div>
            </div>
            <input type="hidden" id="rating" name="rating" value="">
        </div>

        <div class="form-group">
            <label for="comments">Comments:</label>
            <textarea id="comments" name="comments" rows="4" required></textarea>
        </div>

        <button type="submit" class="submit-btn">Submit Feedback</button>
        <button type="button" id="cancelEdit" class="cancel-btn" style="display:none;">Cancel</button>
    </form>

    <!-- Feedback List -->
    <div class="feedback-list">
        <h2>Customer Feedback</h2>
        <div id="feedbackItems">
            <!-- Feedback items will be loaded here by JavaScript -->
        </div>
    </div>
</div>

<script src="js/feedback.js"></script>
</body>
</html>