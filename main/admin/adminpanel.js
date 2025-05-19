document.addEventListener('DOMContentLoaded', function() {
    // Navigation
    const navLinks = document.querySelectorAll('.admin-nav a');
    const sections = document.querySelectorAll('.admin-section');

    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            // Remove active class from all links and sections
            navLinks.forEach(navLink => navLink.parentElement.classList.remove('active'));
            sections.forEach(section => section.classList.remove('active'));

            // Add active class to clicked link and corresponding section
            this.parentElement.classList.add('active');
            const sectionId = this.getAttribute('data-section') + '-section';
            document.getElementById(sectionId).classList.add('active');

            // Load data for the section if needed
            if (sectionId === 'feedback-section') {
                loadAllFeedback();
            } else if (sectionId === 'analytics-section') {
                loadAnalytics();
            }
        });
    });

    // Modal functionality
    const modal = document.getElementById('response-modal');
    const closeModal = document.querySelector('.close-modal');

    // Open modal when respond button is clicked
    document.addEventListener('click', function(e) {
        if (e.target.classList.contains('respond-btn') || e.target.closest('.respond-btn')) {
            const feedbackId = e.target.closest('.feedback-item').dataset.id;
            openResponseModal(feedbackId);
        }
    });

    // Close modal
    closeModal.addEventListener('click', function() {
        modal.style.display = 'none';
    });

    // Close modal when clicking outside
    window.addEventListener('click', function(e) {
        if (e.target === modal) {
            modal.style.display = 'none';
        }
    });

    // Form submission for response
    const responseForm = document.getElementById('response-form');
    responseForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const feedbackId = document.getElementById('response-feedback-id').value;
        const response = document.getElementById('admin-response').value;

        submitResponse(feedbackId, response);
    });

    // Settings form submission
    const settingsForm = document.getElementById('restaurant-settings');
    settingsForm.addEventListener('submit', function(e) {
        e.preventDefault();
        saveSettings();
    });

    // Search and filter functionality
    const feedbackSearch = document.getElementById('feedback-search');
    const ratingFilter = document.getElementById('rating-filter');
    const responseFilter = document.getElementById('response-filter');

    feedbackSearch.addEventListener('input', filterFeedback);
    ratingFilter.addEventListener('change', filterFeedback);
    responseFilter.addEventListener('change', filterFeedback);

    // Load initial data
    loadDashboardData();
    loadAllFeedback();
    loadAnalytics();
    loadSettings();
});

function loadDashboardData() {
    fetch('AdminServlet?action=dashboard')
        .then(response => response.json())
        .then(data => {
            document.getElementById('total-feedback').textContent = data.totalFeedback;
            document.getElementById('positive-ratings').textContent = data.positiveRatings;
            document.getElementById('negative-ratings').textContent = data.negativeRatings;
            document.getElementById('responded-feedback').textContent = data.respondedFeedback;

            // Display recent feedback
            const recentFeedbackList = document.getElementById('recent-feedback-list');
            recentFeedbackList.innerHTML = '';

            if (data.recentFeedback.length === 0) {
                recentFeedbackList.innerHTML = '<p>No recent feedback available.</p>';
                return;
            }

            data.recentFeedback.forEach(feedback => {
                recentFeedbackList.appendChild(createFeedbackElement(feedback));
            });
        })
        .catch(error => {
            console.error('Error loading dashboard data:', error);
        });
}

function loadAllFeedback() {
    fetch('AdminServlet?action=allFeedback')
        .then(response => response.json())
        .then(feedbackList => {
            const allFeedbackList = document.getElementById('all-feedback-list');
            allFeedbackList.innerHTML = '';

            if (feedbackList.length === 0) {
                allFeedbackList.innerHTML = '<p>No feedback available.</p>';
                return;
            }

            feedbackList.forEach(feedback => {
                allFeedbackList.appendChild(createFeedbackElement(feedback, true));
            });
        })
        .catch(error => {
            console.error('Error loading all feedback:', error);
        });
}

function createFeedbackElement(feedback, withActions = false) {
    const feedbackItem = document.createElement('div');
    feedbackItem.className = 'feedback-item';
    feedbackItem.dataset.id = feedback.id;
    feedbackItem.dataset.rating = feedback.rating;
    feedbackItem.dataset.responded = feedback.response ? 'true' : 'false';

    // Create rating stars
    let ratingStars = '';
    for (let i = 1; i <= 5; i++) {
        const iconClass = i <= feedback.rating ? 'fas' : 'far';
        let iconName;

        switch(feedback.rating) {
            case 1: iconName = i === 1 ? 'fa-angry' : 'fa-angry'; break;
            case 2: iconName = i === 2 ? 'fa-frown' : 'fa-frown'; break;
            case 3: iconName = i === 3 ? 'fa-meh' : 'fa-meh'; break;
            case 4: iconName = i === 4 ? 'fa-smile' : 'fa-smile'; break;
            case 5: iconName = i === 5 ? 'fa-laugh' : 'fa-laugh'; break;
            default: iconName = 'fa-meh';
        }

        ratingStars += `<i class="${iconClass} ${iconName}"></i>`;
    }

    let responseSection = '';
    if (feedback.response) {
        responseSection = `
            <div class="feedback-response">
                <div class="response-header">
                    <span>Admin Response</span>
                    <span>${feedback.responseDate}</span>
                </div>
                <p>${feedback.response}</p>
            </div>
        `;
    }

    let actionsSection = '';
    if (withActions) {
        actionsSection = `
            <div class="feedback-actions">
                <button class="action-btn respond-btn" ${feedback.response ? 'disabled' : ''}>
                    <i class="fas fa-reply"></i> Respond
                </button>
                <button class="action-btn delete-btn">
                    <i class="fas fa-trash"></i> Delete
                </button>
            </div>
        `;
    }

    feedbackItem.innerHTML = `
        <div class="feedback-header">
            <span class="feedback-name">${feedback.name}</span>
            <span class="feedback-rating">${ratingStars}</span>
        </div>
        <div class="feedback-date">${feedback.date}</div>
        <div class="feedback-comments">${feedback.comments}</div>
        ${responseSection}
        ${actionsSection}
    `;

    // Add delete functionality
    if (withActions) {
        const deleteBtn = feedbackItem.querySelector('.delete-btn');
        deleteBtn.addEventListener('click', function() {
            if (confirm('Are you sure you want to delete this feedback?')) {
                deleteFeedback(feedback.id);
            }
        });
    }

    return feedbackItem;
}

function filterFeedback() {
    const searchTerm = document.getElementById('feedback-search').value.toLowerCase();
    const ratingFilter = document.getElementById('rating-filter').value;
    const responseFilter = document.getElementById('response-filter').value;

    const feedbackItems = document.querySelectorAll('#all-feedback-list .feedback-item');

    feedbackItems.forEach(item => {
        const matchesSearch = item.textContent.toLowerCase().includes(searchTerm);
        const matchesRating = ratingFilter === '0' || item.dataset.rating === ratingFilter;
        const matchesResponse =
            responseFilter === 'all' ||
            (responseFilter === 'responded' && item.dataset.responded === 'true') ||
            (responseFilter === 'unresponded' && item.dataset.responded === 'false');

        if (matchesSearch && matchesRating && matchesResponse) {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });
}

function openResponseModal(feedbackId) {
    fetch(`AdminServlet?action=getFeedback&id=${feedbackId}`)
        .then(response => response.json())
        .then(feedback => {
            const modal = document.getElementById('response-modal');
            const feedbackDetails = document.getElementById('feedback-details');

            // Create rating stars
            let ratingStars = '';
            for (let i = 1; i <= 5; i++) {
                const iconClass = i <= feedback.rating ? 'fas' : 'far';
                let iconName;

                switch(feedback.rating) {
                    case 1: iconName = i === 1 ? 'fa-angry' : 'fa-angry'; break;
                    case 2: iconName = i === 2 ? 'fa-frown' : 'fa-frown'; break;
                    case 3: iconName = i === 3 ? 'fa-meh' : 'fa-meh'; break;
                    case 4: iconName = i === 4 ? 'fa-smile' : 'fa-smile'; break;
                    case 5: iconName = i === 5 ? 'fa-laugh' : 'fa-laugh'; break;
                    default: iconName = 'fa-meh';
                }

                ratingStars += `<i class="${iconClass} ${iconName}"></i>`;
            }

            feedbackDetails.innerHTML = `
                <div class="feedback-header">
                    <span class="feedback-name">${feedback.name}</span>
                    <span class="feedback-rating">${ratingStars}</span>
                </div>
                <div class="feedback-date">${feedback.date}</div>
                <div class="feedback-comments">${feedback.comments}</div>
            `;

            document.getElementById('response-feedback-id').value = feedback.id;

            if (feedback.response) {
                document.getElementById('admin-response').value = feedback.response;
            } else {
                document.getElementById('admin-response').value = '';
            }

            modal.style.display = 'block';
        })
        .catch(error => {
            console.error('Error loading feedback for response:', error);
            alert('Error loading feedback details');
        });
}

function submitResponse(feedbackId, response) {
    const formData = new FormData();
    formData.append('feedbackId', feedbackId);
    formData.append('response', response);
    formData.append('action', 'respond');

    fetch('AdminServlet', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Response submitted successfully');
                document.getElementById('response-modal').style.display = 'none';
                loadDashboardData();
                loadAllFeedback();
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error submitting response:', error);
            alert('Error submitting response');
        });
}

function deleteFeedback(feedbackId) {
    const formData = new FormData();
    formData.append('feedbackId', feedbackId);
    formData.append('action', 'delete');

    fetch('AdminServlet', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                loadDashboardData();
                loadAllFeedback();
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error deleting feedback:', error);
            alert('Error deleting feedback');
        });
}

function loadAnalytics() {
    fetch('AdminServlet?action=analytics')
        .then(response => response.json())
        .then(data => {
            // Rating distribution chart
            const ratingCtx = document.getElementById('rating-chart').getContext('2d');
            new Chart(ratingCtx, {
                type: 'bar',
                data: {
                    labels: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'],
                    datasets: [{
                        label: 'Number of Ratings',
                        data: data.ratingDistribution,
                        backgroundColor: [
                            '#e74c3c',
                            '#e67e22',
                            '#f39c12',
                            '#2ecc71',
                            '#27ae60'
                        ],
                        borderColor: [
                            '#c0392b',
                            '#d35400',
                            '#e67e22',
                            '#27ae60',
                            '#219955'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Feedback trend chart
            const trendCtx = document.getElementById('trend-chart').getContext('2d');
            new Chart(trendCtx, {
                type: 'line',
                data: {
                    labels: data.trendLabels,
                    datasets: [{
                        label: 'Feedback Count',
                        data: data.trendData,
                        backgroundColor: 'rgba(52, 152, 219, 0.2)',
                        borderColor: 'rgba(52, 152, 219, 1)',
                        borderWidth: 2,
                        tension: 0.1,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error loading analytics:', error);
        });
}

function loadSettings() {
    fetch('AdminServlet?action=getSettings')
        .then(response => response.json())
        .then(settings => {
            document.getElementById('restaurant-name').value = settings.restaurantName || '';
            document.getElementById('admin-email').value = settings.adminEmail || '';
            document.getElementById('notification-pref').value = settings.notificationPref || 'all';
        })
        .catch(error => {
            console.error('Error loading settings:', error);
        });
}

function saveSettings() {
    const formData = new FormData();
    formData.append('restaurantName', document.getElementById('restaurant-name').value);
    formData.append('adminEmail', document.getElementById('admin-email').value);
    formData.append('notificationPref', document.getElementById('notification-pref').value);
    formData.append('action', 'saveSettings');

    fetch('AdminServlet', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Settings saved successfully');
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error saving settings:', error);
            alert('Error saving settings');
        });
}