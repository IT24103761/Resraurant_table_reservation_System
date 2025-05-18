package com.restaurant;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {

    // In-memory menu data (in production, use a database)
    private static final Map<String, MenuItem> menuItems = new HashMap<>();

    @Override
    public void init() throws ServletException {
        // Initialize menu items
        menuItems.put("R001", new MenuItem("R001", "Chicken Fried Rice",
                "Fragrant basmati rice with chicken and vegetables", "Rice", 1200));
        menuItems.put("R002", new MenuItem("R002", "Vegetable Rice",
                "Seasonal vegetables with aromatic spices", "Rice", 900));
        menuItems.put("R003", new MenuItem("R003", "Egg Fried Rice",
                "Classic fried rice with scrambled eggs", "Rice", 850));
        menuItems.put("K001", new MenuItem("K001", "Chicken Kottu",
                "Chopped roti with chicken and spices", "Kottu", 1100));
        menuItems.put("K002", new MenuItem("K002", "Cheese Kottu",
                "Loaded with melted mozzarella cheese", "Kottu", 1300));
        menuItems.put("K003", new MenuItem("K003", "Vegetable Kottu",
                "Fresh vegetables with chopped roti", "Kottu", 950));
        menuItems.put("N001", new MenuItem("N001", "Chicken Noodles",
                "Stir-fried noodles with chicken", "Noodles", 1000));
        menuItems.put("N002", new MenuItem("N002", "Vegetable Noodles",
                "Mixed vegetables with noodles", "Noodles", 850));
        menuItems.put("D001", new MenuItem("D001", "Watalappan",
                "Traditional coconut custard pudding", "Desserts", 600));
        menuItems.put("D002", new MenuItem("D002", "Chocolate Lava Cake",
                "Warm chocolate cake with molten center", "Desserts", 800));
        menuItems.put("D003", new MenuItem("D003", "Ice Cream Sundae",
                "Vanilla ice cream with toppings", "Desserts", 700));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Group items by category for the menu display
        Map<String, List<MenuItem>> menuByCategory = new HashMap<>();
        for (MenuItem item : menuItems.values()) {
            menuByCategory.computeIfAbsent(item.getCategory(), k -> new ArrayList<>()).add(item);
        }

        request.setAttribute("menuByCategory", menuByCategory);
        request.getRequestDispatcher("/page/menu.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemId = request.getParameter("itemId");
        HttpSession session = request.getSession();

        // Get or create the user's order in session
        Map<String, OrderItem> order = (Map<String, OrderItem>) session.getAttribute("order");
        if (order == null) {
            order = new HashMap<>();
            session.setAttribute("order", order);
        }

        if (itemId != null && menuItems.containsKey(itemId)) {
            // Add item to order or increment quantity if already exists
            MenuItem menuItem = menuItems.get(itemId);
            if (order.containsKey(itemId)) {
                OrderItem orderItem = order.get(itemId);
                orderItem.setQuantity(orderItem.getQuantity() + 1);
            } else {
                order.put(itemId, new OrderItem(menuItem, 1));
            }

            response.sendRedirect("menu.jsp?success=true");
        } else {
            response.sendRedirect("menu.jsp?error=Invalid+menu+item+selected");
        }
    }

    // MenuItem class
    public static class MenuItem {
        private String id;
        private String name;
        private String description;
        private String category;
        private double price;

        public MenuItem(String id, String name, String description, String category, double price) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.category = category;
            this.price = price;
        }

        // Getters
        public String getId() { return id; }
        public String getName() { return name; }
        public String getDescription() { return description; }
        public String getCategory() { return category; }
        public double getPrice() { return price; }
    }

    // OrderItem class
    public static class OrderItem {
        private MenuItem menuItem;
        private int quantity;

        public OrderItem(MenuItem menuItem, int quantity) {
            this.menuItem = menuItem;
            this.quantity = quantity;
        }

        // Getters and Setters
        public MenuItem getMenuItem() { return menuItem; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }

        public double getTotalPrice() {
            return menuItem.getPrice() * quantity;
        }
    }
}