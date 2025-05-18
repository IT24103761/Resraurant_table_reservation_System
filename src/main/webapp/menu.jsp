<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    class MenuItem {
        String id, name, description, category, imageUrl;
        double price;

        MenuItem(String id, String name, String description, String category, double price, String imageUrl) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.category = category;
            this.price = price;
            this.imageUrl = imageUrl;
        }
    }

    List<MenuItem> menuItems = new ArrayList<>();
    menuItems.add(new MenuItem("R001", "Chicken Fried Rice", "Fragrant basmati rice with chicken and vegetables", "Rice", 1200, "https://www.licious.in/blog/wp-content/uploads/2020/12/Chicken-Fried-Rice-min.jpg"));
    menuItems.add(new MenuItem("R002", "Vegetable Rice", "Seasonal vegetables with aromatic spices", "Rice", 900, "https://images.unsplash.com/photo-1603133872878-684f208fb84b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("R003", "Egg Fried Rice", "Classic fried rice with scrambled eggs", "Rice", 850, "https://images.unsplash.com/photo-1585032226651-759b368d7246?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("K001", "Chicken Kottu", "Chopped roti with chicken and spices", "Kottu", 1100, "https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("K002", "Cheese Kottu", "Loaded with melted mozzarella cheese", "Kottu", 1300, "https://images.unsplash.com/photo-1544025162-d76694265947?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("K003", "Vegetable Kottu", "Fresh vegetables with chopped roti", "Kottu", 950, "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("N001", "Chicken Noodles", "Stir-fried noodles with chicken", "Noodles", 1000, "https://images.unsplash.com/photo-1555126634-323283e090fa?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("N002", "Vegetable Noodles", "Mixed vegetables with noodles", "Noodles", 850, "https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("D001", "Watalappan", "Traditional coconut custard pudding", "Desserts", 600, "https://images.unsplash.com/photo-1563805042-7684c019e1cb?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("D002", "Chocolate Lava Cake", "Warm chocolate cake with molten center", "Desserts", 800, "https://images.unsplash.com/photo-1571115177098-24ec42ed204d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));
    menuItems.add(new MenuItem("D003", "Ice Cream Sundae", "Vanilla ice cream with toppings", "Desserts", 700, "https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"));

    Map<String, List<MenuItem>> menuByCategory = new HashMap<>();
    for (MenuItem item : menuItems) {
        menuByCategory.computeIfAbsent(item.category, k -> new ArrayList<>()).add(item);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Amali Restaurant</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #e67e22;
            --primary-dark: #d35400;
            --secondary-color: #2ecc71;
            --dark-color: #333;
            --light-color: #f9f9f9;
            --gray-color: #777;
            --white-color: #fff;
            --shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            background-color: #f5f5f5;
            color: #333;
        }

        header {
            background-color: var(--white-color);
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 80px;
        }

        #branding h1 {
            font-size: 28px;
            color: var(--dark-color);
        }

        #branding .highlight {
            color: var(--primary-color);
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav ul li {
            margin-left: 30px;
            position: relative;
        }

        nav ul li a {
            text-decoration: none;
            color: var(--dark-color);
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 5px;
        }

        nav ul li a:hover {
            color: var(--primary-color);
        }

        nav ul li.current a {
            color: var(--primary-color);
        }

        .login-btn {
            background-color: var(--primary-color);
            color: var(--white-color) !important;
            padding: 8px 15px;
            border-radius: 5px;
        }

        .login-btn:hover {
            background-color: var(--primary-dark);
            color: var(--white-color) !important;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }

        .user-profile img {
            border-radius: 50%;
        }

        .menu-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 20px;
        }

        .menu-container h1 {
            text-align: center;
            margin-bottom: 40px;
            font-size: 36px;
            color: var(--primary-dark);
            position: relative;
            padding-bottom: 15px;
        }

        .menu-container h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: var(--primary-color);
        }

        .menu-category {
            margin-bottom: 50px;
        }

        .menu-category h2 {
            font-size: 28px;
            margin-bottom: 25px;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .menu-category h2 i {
            color: var(--primary-color);
        }

        .menu-items {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }

        .menu-item {
            background: var(--white-color);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .item-image {
            height: 200px;
            width: 100%;
            overflow: hidden;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .menu-item:hover .item-image img {
            transform: scale(1.05);
        }

        .item-info {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .item-info h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .description {
            color: var(--gray-color);
            margin-bottom: 15px;
            font-size: 14px;
            flex-grow: 1;
        }

        .price {
            font-weight: bold;
            color: var(--primary-color);
            font-size: 18px;
            margin-bottom: 15px;
        }

        .add-btn {
            background: var(--primary-color);
            color: var(--white-color);
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
            align-self: flex-start;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .add-btn:hover {
            background: var(--primary-dark);
        }

        .alert {
            padding: 15px;
            margin-bottom: 30px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert.success {
            background: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #2e7d32;
        }

        .alert.error {
            background: #ffebee;
            color: #c62828;
            border-left: 4px solid #c62828;
        }

        .alert a {
            color: inherit;
            text-decoration: underline;
            margin-left: 5px;
        }

        footer {
            background-color: var(--dark-color);
            color: var(--white-color);
            text-align: center;
            padding: 20px 0;
            margin-top: 50px;
        }

        footer p {
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .menu-items {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }

            nav ul {
                display: none;
            }

            .container {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<header>
  <div class="container">
    <div id="branding">
      <h1><span class="highlight">Amali</span> Restaurant</h1>
    </div>
    <nav>
      <ul>
        <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
        <li class="current"><a href="menu.jsp"><i class="fas fa-utensils"></i> Menu</a></li>
        <li><a href="src/Home/Page/about.jsp"><i class="fas fa-info-circle"></i> About</a></li>
        <li><a href="src/Home/Page/reservation.jsp"><i class="fas fa-calendar-alt"></i> Reservations</a></li>
        <li><a href="contact.jsp"><i class="fas fa-envelope"></i> Contact</a></li>
        <% if (session.getAttribute("username") == null) { %>
        <li><a href="login.jsp" class="login-btn"><i class="fas fa-sign-in-alt"></i> Login</a></li>
        <% } else { %>
        <li class="dropdown">
          <div class="user-profile">
            <img src="src/Home/img/user-icon.png" alt="User" width="30">
            <span><%= session.getAttribute("username") %></span>
          </div>
        </li>
        <% } %>
      </ul>
    </nav>
  </div>
</header>

<!-- Menu Content -->
<div class="menu-container">
    <h1>Our Delicious Menu</h1>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert success">
        <i class="fas fa-check-circle"></i> Items added to your order!
        <a href="order.jsp">View Your Order</a>
    </div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert error">
        <i class="fas fa-exclamation-circle"></i> <%= request.getParameter("error") %>
    </div>
    <% } %>

    <!-- Dynamically generate menu categories -->
    <% for (Map.Entry<String, List<MenuItem>> entry : menuByCategory.entrySet()) { %>
    <div class="menu-category">
        <h2>
            <% switch(entry.getKey()) {
                case "Rice": %><i class="fas fa-utensils"></i><% break;
            case "Kottu": %><i class="fas fa-bread-slice"></i><% break;
            case "Noodles": %><i class="fas fa-utensils"></i><% break;
            case "Desserts": %><i class="fas fa-ice-cream"></i><% break;
            default: %><i class="fas fa-utensils"></i><% } %>
            <%= entry.getKey() %>
        </h2>
        <div class="menu-items">
            <% for (MenuItem item : entry.getValue()) { %>
            <div class="menu-item">
                <div class="item-image">
                    <img src="<%= item.imageUrl %>" alt="<%= item.name %>">
                </div>
                <div class="item-info">
                    <h3><%= item.name %></h3>
                    <p class="description"><%= item.description %></p>
                    <p class="price">Rs. <%= String.format("%.2f", item.price) %></p>
                    <form action="add-to-order" method="post">
                        <input type="hidden" name="itemId" value="<%= item.id %>">
                        <button type="submit" class="add-btn">
                            <i class="fas fa-plus"></i> Add to Order
                        </button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <% } %>
</div>

<!-- Footer -->
<footer>
    <div class="container">
        <p>Amali Restaurant &copy; 2023</p>
    </div>
</footer>
</body>
</html>