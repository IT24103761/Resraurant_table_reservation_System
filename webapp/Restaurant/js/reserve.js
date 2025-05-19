document.addEventListener('DOMContentLoaded', function() {
    // Form validation and submission
    const reservationForm = document.getElementById('reservationForm');
    const confirmationModal = document.getElementById('confirmationModal');
    const closeModalBtn = document.getElementById('closeModalBtn');
    const confirmationMessage = document.getElementById('confirmationMessage');

    // Set minimum date to today
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('date').setAttribute('min', today);

    // Form submission
    reservationForm.addEventListener('submit', function(e) {
        e.preventDefault();

        // Basic form validation
        const name = document.getElementById('name').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const date = document.getElementById('date').value;
        const time = document.getElementById('time').value;
        const guests = document.getElementById('guests').value;

        if (!name || !email || !phone || !date || !time || !guests) {
            alert('Please fill in all required fields');
            return;
        }

        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert('Please enter a valid email address');
            return;
        }

        // Phone validation (basic)
        if (phone.length < 10) {
            alert('Please enter a valid phone number');
            return;
        }

        // If all validations pass, proceed with form submission
        submitReservation();
    });

    // Function to handle form submission (simulated)
    function submitReservation() {
        // In a real application, this would be an AJAX call to the server
        const formData = new FormData(reservationForm);
        const reservationDetails = {};

        formData.forEach((value, key) => {
            reservationDetails[key] = value;
        });

        // Format the confirmation message
        const formattedDate = new Date(reservationDetails.date).toLocaleDateString('en-US', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });

        const formattedTime = new Date(`2000-01-01T${reservationDetails.time}`).toLocaleTimeString('en-US', {
            hour: '2-digit',
            minute: '2-digit',
            hour12: true
        });

        confirmationMessage.innerHTML = `
            Thank you, <strong>${reservationDetails.name}</strong>!<br><br>
            Your reservation for <strong>${reservationDetails.guests} ${reservationDetails.guests === '1' ? 'person' : 'people'}</strong> 
            on <strong>${formattedDate}</strong> at <strong>${formattedTime}</strong> has been confirmed.<br><br>
            A confirmation has been sent to <strong>${reservationDetails.email}</strong>.
        `;

        // Show the confirmation modal
        confirmationModal.classList.add('show');

        // Reset the form
        reservationForm.reset();
    }

    // Close modal handlers
    closeModalBtn.addEventListener('click', function() {
        confirmationModal.classList.remove('show');
    });

    window.addEventListener('click', function(e) {
        if (e.target === confirmationModal) {
            confirmationModal.classList.remove('show');
        }
    });

    // Add animation to form elements on focus
    const formInputs = document.querySelectorAll('.form-group input, .form-group select, .form-group textarea');

    formInputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.querySelector('label').style.color = black;
            this.parentElement.querySelector('i').style.color = black;
        });

        input.addEventListener('blur', function() {
            this.parentElement.querySelector('label').style.color = '';
            this.parentElement.querySelector('i').style.color = black;
        });
    });

    // Time input formatting
    const timeInput = document.getElementById('time');
    timeInput.addEventListener('change', function() {
        // Ensure time is in HH:MM format
        if (this.value) {
            const [hours, minutes] = this.value.split(':');
            this.value = `${hours.padStart(2, '0')}:${minutes.padStart(2, '0')}`;
        }
    });
});