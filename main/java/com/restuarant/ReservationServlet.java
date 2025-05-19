package com.restuarant;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String guests = request.getParameter("guests");
        String tableType = request.getParameter("tableType");
        String specialRequests = request.getParameter("specialRequests");

        // Validate required fields
        if (name == null || name.isEmpty() ||
                email == null || email.isEmpty() ||
                phone == null || phone.isEmpty() ||
                date == null || date.isEmpty() ||
                time == null || time.isEmpty() ||
                guests == null || guests.isEmpty()) {

            request.setAttribute("errorMessage", "Please fill in all required fields");
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
            return;
        }

        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("errorMessage", "Please enter a valid email address");
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
            return;
        }

        // In a real application, you would:
        // 1. Process the reservation (save to database)
        // 2. Send confirmation email
        // 3. Handle any business logic

        // For this example, we'll just forward to the JSP with a success message
        request.setAttribute("successMessage", "Your reservation has been confirmed!");
        request.setAttribute("reservationDetails",
                "Name: " + name + "<br>" +
                        "Email: " + email + "<br>" +
                        "Phone: " + phone + "<br>" +
                        "Date: " + date + "<br>" +
                        "Time: " + time + "<br>" +
                        "Guests: " + guests + "<br>" +
                        "Table Type: " + (tableType != null ? tableType : "Standard") + "<br>" +
                        "Special Requests: " + (specialRequests != null ? specialRequests : "None"));

        request.getRequestDispatcher("reservation.jsp").forward(request, response);
    }
}