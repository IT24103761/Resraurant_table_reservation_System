document.addEventListener('DOMContentLoaded', function() {
    // Initialize Charts
    const reservationsCtx = document.getElementById('reservationsChart').getContext('2d');
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');

    // Reservations Chart
    const reservationsChart = new Chart(reservationsCtx, {
        type: 'bar',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Reservations',
                data: [12, 19, 15, 22, 28, 35, 30],
                backgroundColor: 'rgba(230, 126, 34, 0.7)',
                borderColor: 'rgba(230, 126, 34, 1)',
                borderWidth: 1,
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });

    // Revenue Chart
    const revenueChart = new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
            datasets: [{
                label: 'Revenue',
                data: [12500, 14300, 13800, 15600, 17200, 18900, 20500],
                backgroundColor: 'rgba(52, 152, 219, 0.1)',
                borderColor: 'rgba(52, 152, 219, 1)',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    ticks: {
                        callback: function(value) {
                            return '$' + value.toLocaleString();
                        }
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });

    // Notification Bell Animation
    const notificationBell = document.querySelector('.notifications i');
    let bellAnimated = false;

    notificationBell.addEventListener('mouseenter', function() {
        if (!bellAnimated) {
            this.classList.add('fa-shake');
            bellAnimated = true;

            setTimeout(() => {
                this.classList.remove('fa-shake');
                bellAnimated = false;
            }, 1000);
        }
    });

    // Toggle Sidebar on Mobile
    const sidebar = document.querySelector('.sidebar');
    const sidebarToggle = document.createElement('div');
    sidebarToggle.className = 'sidebar-toggle';
    sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
    sidebarToggle.style.display = 'none';

    document.querySelector('.top-nav').prepend(sidebarToggle);

    sidebarToggle.addEventListener('click', function() {
        sidebar.classList.toggle('mobile-show');
    });

    function handleResize() {
        if (window.innerWidth < 992) {
            sidebar.classList.remove('mobile-show');
            sidebarToggle.style.display = 'flex';
        } else {
            sidebarToggle.style.display = 'none';
            sidebar.classList.remove('mobile-show');
        }
    }

    window.addEventListener('resize', handleResize);
    handleResize();

    // Table Row Click Event
    const tableRows = document.querySelectorAll('.reservations-table tbody tr');

    tableRows.forEach(row => {
        row.addEventListener('click', function(e) {
            if (!e.target.closest('.action-btn')) {
                const reservationId = this.querySelector('td:first-child').textContent;
                console.log('Viewing reservation:', reservationId);
                // In a real app, you would redirect to the reservation detail page
            }
        });
    });

    // Simulate data updates
    setInterval(() => {
        // Update stats with random data for demo purposes
        const todayReservations = document.querySelector('.stats-cards .stat-card:nth-child(1) .stat-value');
        const totalCustomers = document.querySelector('.stats-cards .stat-card:nth-child(2) .stat-value');

        const currentReservations = parseInt(todayReservations.textContent);
        const currentCustomers = parseInt(totalCustomers.textContent.replace(/,/g, ''));

        todayReservations.textContent = currentReservations + Math.floor(Math.random() * 3);
        totalCustomers.textContent = (currentCustomers + Math.floor(Math.random() * 10)).toLocaleString();
    }, 5000);
});