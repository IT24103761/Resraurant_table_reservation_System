// Mobile Navigation Toggle
const mobileNavToggle = document.createElement('div');
mobileNavToggle.className = 'mobile-nav-toggle';
mobileNavToggle.innerHTML = '<i class="fas fa-bars"></i>';
document.querySelector('.navbar').appendChild(mobileNavToggle);

const navLinks = document.querySelector('.nav-links');
mobileNavToggle.addEventListener('click', () => {
    navLinks.classList.toggle('active');
    mobileNavToggle.innerHTML = navLinks.classList.contains('active')
        ? '<i class="fas fa-times"></i>'
        : '<i class="fas fa-bars"></i>';
});

// Header Scroll Effect
window.addEventListener('scroll', () => {
    const header = document.querySelector('header');
    if (window.scrollY > 50) {
        header.classList.add('scrolled');
    } else {
        header.classList.remove('scrolled');
    }
});

// Modal Handling
const loginModal = document.getElementById('loginModal');
const signupModal = document.getElementById('signupModal');
const loginBtn = document.getElementById('loginBtn');
const signupBtn = document.getElementById('signupBtn');
const closeBtns = document.querySelectorAll('.close');

if (loginBtn) {
    loginBtn.addEventListener('click', () => {
        loginModal.style.display = 'block';
    });
}

if (signupBtn) {
    signupBtn.addEventListener('click', () => {
        signupModal.style.display = 'block';
    });
}

closeBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        loginModal.style.display = 'none';
        signupModal.style.display = 'none';
    });
});

window.addEventListener('click', (e) => {
    if (e.target === loginModal) {
        loginModal.style.display = 'none';
    }
    if (e.target === signupModal) {
        signupModal.style.display = 'none';
    }
});

// Testimonial Slider
const testimonials = document.querySelectorAll('.testimonial');
const dotsContainer = document.querySelector('.slider-dots');
let currentSlide = 0;

// Create dots
testimonials.forEach((_, index) => {
    const dot = document.createElement('div');
    dot.classList.add('dot');
    if (index === 0) dot.classList.add('active');
    dot.addEventListener('click', () => {
        goToSlide(index);
    });
    dotsContainer.appendChild(dot);
});

const dots = document.querySelectorAll('.dot');

function goToSlide(slideIndex) {
    testimonials.forEach(testimonial => testimonial.classList.remove('active'));
    dots.forEach(dot => dot.classList.remove('active'));

    testimonials[slideIndex].classList.add('active');
    dots[slideIndex].classList.add('active');
    currentSlide = slideIndex;
}

function nextSlide() {
    currentSlide = (currentSlide + 1) % testimonials.length;
    goToSlide(currentSlide);
}

function prevSlide() {
    currentSlide = (currentSlide - 1 + testimonials.length) % testimonials.length;
    goToSlide(currentSlide);
}

document.querySelector('.slider-next').addEventListener('click', nextSlide);
document.querySelector('.slider-prev').addEventListener('click', prevSlide);

// Auto slide change
let slideInterval = setInterval(nextSlide, 5000);

// Pause on hover
const slider = document.querySelector('.testimonials-slider');
slider.addEventListener('mouseenter', () => {
    clearInterval(slideInterval);
});

slider.addEventListener('mouseleave', () => {
    slideInterval = setInterval(nextSlide, 5000);
});

// Form Validation
const loginForm = document.getElementById('loginForm');
const signupForm = document.getElementById('signupForm');

if (loginForm) {
    loginForm.addEventListener('submit', (e) => {
        e.preventDefault();
        // Add your login logic here
        alert('Login functionality would be implemented here');
    });
}

if (signupForm) {
    signupForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const password = document.getElementById('signup-password').value;
        const confirmPassword = document.getElementById('signup-confirm').value;

        if (password !== confirmPassword) {
            alert('Passwords do not match!');
            return;
        }

        // Add your signup logic here
        alert('Signup functionality would be implemented here');
    });
}