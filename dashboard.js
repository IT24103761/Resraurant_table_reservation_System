document.addEventListener('DOMContentLoaded', function() {
    // Sidebar Toggle Functionality
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');

    sidebarToggle.addEventListener('click', function() {
        sidebar.classList.toggle('active');
        mainContent.classList.toggle('sidebar-collapsed');
    });

    // Initialize Charts
    initializeCharts();

    // Notification Bell Click Event
    const notificationBell = document.querySelector('.notifications');
    notificationBell.addEventListener('click', function() {
        // In a real app, this would show notifications dropdown
        alert('Notifications dropdown would appear here');
    });

    // Search Box Focus Effect
    const searchBox = document.querySelector('.search-box input');
    searchBox.addEventListener('focus', function() {
        this.parentNode.classList.add('focused');
    });

    searchBox.addEventListener('blur', function() {
        this.parentNode.classList.remove('focused');
    });

    // Action Buttons in Table
    const actionButtons = document.querySelectorAll('.action-btn');
    actionButtons.forEach(button => {
        button.addEventListener('click', function() {
            const action = this.classList.contains('view') ? 'View' : 'Edit';
            const reservationId = this.closest('tr').querySelector('td').textContent;
            alert(`${action} action for reservation ${reservationId}`);
        });
    });

    // Simulate loading data
    simulateDataLoading();
});

function initializeCharts() {
    // Reservations Chart
    const reservationsCtx = document.getElementById('reservationsChart').getContext('2d');
    const reservationsChart = new Chart(reservationsCtx, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Reservations',
                data: [12, 19, 15, 22, 18, 25, 30],
                backgroundColor: 'rgba(78, 115, 223, 0.05)',
                borderColor: 'rgba(78, 115, 223, 1)',
                borderWidth: 2,
                tension: 0.4,
                fill: true,
                pointBackgroundColor: '#fff',
                pointBorderColor: 'rgba(78, 115, 223, 1)',
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#2a3042',
                    titleFont: {
                        size: 14,
                        family: "'Poppins', sans-serif"
                    },
                    bodyFont: {
                        size: 12,
                        family: "'Poppins', sans-serif"
                    },
                    padding: 12,
                    usePointStyle: true,
                    callbacks: {
                        label: function(context) {
                            return ` ${context.parsed.y} reservations`;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    ticks: {
                        stepSize: 5
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

    // Tables Chart
    const tablesCtx = document.getElementById('tablesChart').getContext('2d');
    const tablesChart = new Chart(tablesCtx, {
        type: 'bar',
        data: {
            labels: ['Window #1', 'Window #2', 'Booth #1', 'Booth #2', 'Private #1', 'Outdoor #1'],
            datasets: [{
                label: 'Reservations',
                data: [15, 12, 8, 10, 6, 9],
                backgroundColor: [
                    'rgba(78, 115, 223, 0.8)',
                    'rgba(28, 200, 138, 0.8)',
                    'rgba(54, 185, 204, 0.8)',
                    'rgba(246, 194, 62, 0.8)',
                    'rgba(231, 74, 59, 0.8)',
                    'rgba(108, 117, 125, 0.8)'
                ],
                borderColor: [
                    'rgba(78, 115, 223, 1)',
                    'rgba(28, 200, 138, 1)',
                    'rgba(54, 185, 204, 1)',
                    'rgba(246, 194, 62, 1)',
                    'rgba(231, 74, 59, 1)',
                    'rgba(108, 117, 125, 1)'
                ],
                borderWidth: 1,
                borderRadius: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: '#2a3042',
                    titleFont: {
                        size: 14,
                        family: "'Poppins', sans-serif"
                    },
                    bodyFont: {
                        size: 12,
                        family: "'Poppins', sans-serif"
                    },
                    padding: 12,
                    usePointStyle: true,
                    callbacks: {
                        label: function(context) {
                            return ` ${context.parsed.y} reservations`;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    ticks: {
                        stepSize: 5
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

    // Make charts responsive to window resize
    window.addEventListener('resize', function() {
        reservationsChart.resize();
        tablesChart.resize();
    });
}

function simulateDataLoading() {
    // Simulate loading data with a slight delay
    const loadingElements = document.querySelectorAll('.stat-value, .chart-container, .reservations-table');

    loadingElements.forEach(el => {
        el.style.opacity = '0';
    });

    setTimeout(() => {
        loadingElements.forEach(el => {
            el.style.transition = 'opacity 0.5s ease';
            el.style.opacity = '1';
        });
    }, 300);

    // Update stats periodically (simulated)
    setInterval(() => {
        const todayReservations = document.querySelector('.stat-card:nth-child(1) .stat-value');
        const currentValue = parseInt(todayReservations.textContent);
        const randomChange = Math.floor(Math.random() * 3) - 1; // -1, 0, or 1
        todayReservations.textContent = Math.max(0, currentValue + randomChange);

        // Update change indicator
        const changeElement = document.querySelector('.stat-card:nth-child(1) .stat-change');
        if (randomChange > 0) {
            changeElement.innerHTML = '<i class="fas fa-arrow-up"></i> ' + (Math.random() * 5 + 5).toFixed(0) + '% from yesterday';
            changeElement.className = 'stat-change positive';
        } else if (randomChange < 0) {
            changeElement.innerHTML = '<i class="fas fa-arrow-down"></i> ' + (Math.random() * 5 + 5).toFixed(0) + '% from yesterday';
            changeElement.className = 'stat-change negative';
        }
    }, 5000);
}