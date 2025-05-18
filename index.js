document.addEventListener('DOMContentLoaded', function() {
    // Navbar scroll effect
    const navbar = document.querySelector('.navbar');
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Sample menu data - in a real app, this would come from an API
    const menuData = [
        {
            name: "Grilled Salmon",
            description: "Fresh Atlantic salmon with lemon butter sauce",
            price: "$24.99",
            image: "images/salmon.jpg"
        },
        {
            name: "Filet Mignon",
            description: "8oz prime cut with roasted vegetables",
            price: "$32.99",
            image: "images/steak.jpg"
        },
        {
            name: "Vegetable Pasta",
            description: "Seasonal vegetables with homemade pasta",
            price: "$18.99",
            image: "images/pasta.jpg"
        }
    ];

    // Load menu items
    const menuContainer = document.querySelector('.menu-items');
    menuData.forEach(item => {
        const menuItem = document.createElement('div');
        menuItem.className = 'menu-item';
        menuItem.innerHTML = `
            <img src="${item.image}" alt="${item.name}">
            <div class="menu-item-content">
                <h3>${item.name}</h3>
                <p>${item.description}</p>
                <span class="price">${item.price}</span>
            </div>
        `;
        menuContainer.appendChild(menuItem);
    });

    // Form submission
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            // In a real app, you would send this data to your server
            alert('Thank you for your message! We will contact you soon.');
            this.reset();
        });
    }
});