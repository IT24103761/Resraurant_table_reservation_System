document.addEventListener('DOMContentLoaded', function() {
    // Password visibility toggle
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');

    if (togglePassword && passwordInput) {
        togglePassword.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.classList.toggle('fa-eye-slash');
        });
    }

    // Form validation
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Reset errors
            document.querySelectorAll('.input-error').forEach(el => el.textContent = '');

            // Validate email
            const email = document.getElementById('email').value.trim();
            const emailError = document.getElementById('email-error');
            if (!email) {
                emailError.textContent = 'Email is required';
                return;
            } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                emailError.textContent = 'Please enter a valid email address';
                return;
            }

            // Validate password
            const password = document.getElementById('password').value.trim();
            const passwordError = document.getElementById('password-error');
            if (!password) {
                passwordError.textContent = 'Password is required';
                return;
            } else if (password.length < 6) {
                passwordError.textContent = 'Password must be at least 6 characters';
                return;
            }

            // Show loading state
            const loginBtn = document.getElementById('loginBtn');
            const btnText = loginBtn.querySelector('.btn-text');
            const spinner = loginBtn.querySelector('.spinner');

            btnText.textContent = 'Logging in...';
            spinner.classList.remove('hidden');
            loginBtn.disabled = true;

            // Simulate form submission
            setTimeout(() => {
                loginForm.submit();

                // Reset button state
                btnText.textContent = 'Login';
                spinner.classList.add('hidden');
                loginBtn.disabled = false;
            }, 1500);
        });
    }

    // Remember me functionality
    if (localStorage.getItem('rememberedEmail')) {
        document.getElementById('email').value = localStorage.getItem('rememberedEmail');
        document.getElementById('remember').checked = true;
    }

    const rememberCheckbox = document.getElementById('remember');
    if (rememberCheckbox) {
        rememberCheckbox.addEventListener('change', function() {
            const email = document.getElementById('email').value.trim();
            if (this.checked && email) {
                localStorage.setItem('rememberedEmail', email);
            } else {
                localStorage.removeItem('rememberedEmail');
            }
        });
    }

    // Social login buttons
    document.querySelectorAll('.social-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            const provider = this.classList.contains('google') ? 'Google' : 'Facebook';
            alert(`In a real application, this would redirect to ${provider} login`);
        });
    });
});