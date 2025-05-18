document.addEventListener('DOMContentLoaded', function() {
    // Reaction selection
    const reactions = document.querySelectorAll('.reaction');
    const ratingInput = document.getElementById('rating');

    reactions.forEach(reaction => {
        reaction.addEventListener('click', function() {
            // Remove active class from all reactions
            reactions.forEach(r => {
                r.classList.remove('active');
                r.querySelector('i').classList.remove('active');
            });

            // Add active class to clicked reaction
            this.classList.add('active');
            this.querySelector('i').classList.add('active');

            // Set the rating value
            ratingInput.value = this.getAttribute('data-value');
        });
    });

    // Form submission handling
    const form = document.getElementById('feedbackForm');
    const cancelEditBtn = document.getElementById('cancelEdit');

    form.addEventListener('submit', function(e) {
        e.preventDefault();

        if (!ratingInput.value) {
            alert('Please select a rating');
            return;
        }

        const formData = new FormData(form);
        const action = formData.get('action');

        fetch('FeedbackServlet', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resetForm();
                    loadFeedback();
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while submitting feedback');
            });
    });

    // Cancel edit button
    cancelEditBtn.addEventListener('click', function() {
        resetForm();
    });

    // Load feedback when page loads
    loadFeedback();
});

function loadFeedback() {
    fetch('FeedbackServlet')
        .then(response => response.json())
        .then(feedbackList => {
            const feedbackItems = document.getElementById('feedbackItems');

            if (feedbackList.length === 0) {
                feedbackItems.innerHTML = '<p>No feedback yet. Be the first to share your experience!</p>';
                return;
            }

            feedbackItems.innerHTML = '';

            feedbackList.forEach(feedback => {
                const feedbackItem = document.createElement('div');
                feedbackItem.className = 'feedback-item';
                feedbackItem.dataset.id = feedback.id;

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

                feedbackItem.innerHTML = `
                <div class="feedback-header">
                    <span class="feedback-name">${feedback.name}</span>
                    <span class="feedback-rating">${ratingStars}</span>
                    <div class="feedback-actions">
                        <button class="edit-btn" onclick="editFeedback('${feedback.id}')">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="delete-btn" onclick="deleteFeedback('${feedback.id}')">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
                <div class="feedback-comments">${feedback.comments}</div>
                <div class="feedback-date">${feedback.date}</div>
            `;

                feedbackItems.appendChild(feedbackItem);
            });
        })
        .catch(error => {
            console.error('Error loading feedback:', error);
            document.getElementById('feedbackItems').innerHTML =
                '<p>Error loading feedback. Please try again later.</p>';
        });
}

function editFeedback(id) {
    fetch(`FeedbackServlet?id=${id}`)
        .then(response => response.json())
        .then(feedback => {
            if (!feedback) return;

            // Fill the form with feedback data
            document.getElementById('feedbackId').value = feedback.id;
            document.getElementById('action').value = 'update';
            document.getElementById('name').value = feedback.name;
            document.getElementById('email').value = feedback.email || '';
            document.getElementById('rating').value = feedback.rating;
            document.getElementById('comments').value = feedback.comments;

            // Highlight the selected reaction
            const reactions = document.querySelectorAll('.reaction');
            reactions.forEach(reaction => {
                reaction.classList.remove('active');
                reaction.querySelector('i').classList.remove('active');

                if (parseInt(reaction.getAttribute('data-value')) === feedback.rating) {
                    reaction.classList.add('active');
                    reaction.querySelector('i').classList.add('active');
                }
            });

            // Change submit button text
            document.querySelector('.submit-btn').textContent = 'Update Feedback';

            // Show cancel button
            document.getElementById('cancelEdit').style.display = 'inline-block';

            // Scroll to form
            document.querySelector('.feedback-container').scrollIntoView({ behavior: 'smooth' });
        })
        .catch(error => {
            console.error('Error loading feedback for edit:', error);
            alert('Error loading feedback for editing');
        });
}

function deleteFeedback(id) {
    if (confirm('Are you sure you want to delete this feedback?')) {
        const formData = new FormData();
        formData.append('feedbackId', id);
        formData.append('action', 'delete');

        fetch('FeedbackServlet', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    loadFeedback();
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error deleting feedback:', error);
                alert('An error occurred while deleting feedback');
            });
    }
}

function resetForm() {
    document.getElementById('feedbackForm').reset();
    document.getElementById('feedbackId').value = '';
    document.getElementById('action').value = 'add';
    document.getElementById('rating').value = '';

    // Remove active class from reactions
    document.querySelectorAll('.reaction').forEach(reaction => {
        reaction.classList.remove('active');
        reaction.querySelector('i').classList.remove('active');
    });

    // Change submit button text back
    document.querySelector('.submit-btn').textContent = 'Submit Feedback';

    // Hide cancel button
    document.getElementById('cancelEdit').style.display = 'none';
}