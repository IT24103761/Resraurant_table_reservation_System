package com.restuarant;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    private static final String FILE_PATH = "feedback.txt"; // Store in webapp directory

    private AtomicInteger idCounter = new AtomicInteger(1);

    @Override
    public void init() throws ServletException {
        // Initialize ID counter based on existing feedback
        try {
            List<feedback> feedbackList = readFeedbackFromFile();
            if (!feedbackList.isEmpty()) {
                int maxId = feedbackList.stream()
                        .mapToInt(fb -> Integer.parseInt(fb.getId()))
                        .max()
                        .orElse(0);
                idCounter.set(maxId + 1);
            }
        } catch (IOException e) {
            throw new ServletException("Error initializing feedback servlet", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String jsonResponse;

        if (id != null && !id.isEmpty()) {
            // Return single feedback for editing
            feedback feedback = getFeedbackById(id);
            jsonResponse = convertFeedbackToJson(feedback);
        } else {
            // Return all feedback
            List<feedback> feedbackList = readFeedbackFromFile();
            jsonResponse = convertFeedbackListToJson(feedbackList);
        }

        sendJsonResponse(response, jsonResponse);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String jsonResponse;

        try {
            if ("add".equals(action)) {
                feedback feedback = new feedback();
                feedback.setId(String.valueOf(idCounter.getAndIncrement()));
                feedback.setName(request.getParameter("name"));
                feedback.setEmail(request.getParameter("email"));
                feedback.setRating(Integer.parseInt(request.getParameter("rating")));
                feedback.setComments(request.getParameter("comments"));

                saveFeedbackToFile(feedback, true);
                jsonResponse = "{\"success\":true,\"message\":\"Feedback added successfully\"}";
            }
            else if ("update".equals(action)) {
                String feedbackId = request.getParameter("feedbackId");
                List<feedback> feedbackList = readFeedbackFromFile();

                boolean updated = false;
                for (feedback feedback : feedbackList) {
                    if (feedback.getId().equals(feedbackId)) {
                        feedback.setName(request.getParameter("name"));
                        feedback.setEmail(request.getParameter("email"));
                        feedback.setRating(Integer.parseInt(request.getParameter("rating")));
                        feedback.setComments(request.getParameter("comments"));
                        feedback.setDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                        updated = true;
                        break;
                    }
                }

                if (updated) {
                    saveAllFeedbackToFile(feedbackList);
                    jsonResponse = "{\"success\":true,\"message\":\"Feedback updated successfully\"}";
                } else {
                    jsonResponse = "{\"success\":false,\"message\":\"Feedback not found\"}";
                }
            }
            else if ("delete".equals(action)) {
                String feedbackId = request.getParameter("feedbackId");
                List<feedback> feedbackList = readFeedbackFromFile();

                boolean removed = feedbackList.removeIf(feedback -> feedback.getId().equals(feedbackId));

                if (removed) {
                    saveAllFeedbackToFile(feedbackList);
                    jsonResponse = "{\"success\":true,\"message\":\"Feedback deleted successfully\"}";
                } else {
                    jsonResponse = "{\"success\":false,\"message\":\"Feedback not found\"}";
                }
            } else {
                jsonResponse = "{\"success\":false,\"message\":\"Invalid action\"}";
            }
        } catch (Exception e) {
            jsonResponse = "{\"success\":false,\"message\":\"Error: " + e.getMessage() + "\"}";
        }

        sendJsonResponse(response, jsonResponse);
    }

    private feedback getFeedbackById(String id) throws IOException {
        List<feedback> feedbackList = readFeedbackFromFile();
        return feedbackList.stream()
                .filter(feedback -> feedback.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    private List<feedback> readFeedbackFromFile() throws IOException {
        List<feedback> feedbackList = new ArrayList<>();
        String filePath = getServletContext().getRealPath("/") + FILE_PATH;
        File file = new File(filePath);

        // Create file if it doesn't exist
        if (!file.exists()) {
            file.createNewFile();
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                feedback feedback = com.restuarant.feedback.fromString(line);
                if (feedback != null) {
                    feedbackList.add(feedback);
                }
            }
        }

        // Sort by date descending
        feedbackList.sort((f1, f2) -> f2.getDate().compareTo(f1.getDate()));
        return feedbackList;
    }

    private void saveFeedbackToFile(feedback feedback, boolean append) throws IOException {
        String filePath = getServletContext().getRealPath("/") + FILE_PATH;
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath, append))) {
            writer.println(feedback.toString());
        }
    }

    private void saveAllFeedbackToFile(List<feedback> feedbackList) throws IOException {
        String filePath = getServletContext().getRealPath("/") + FILE_PATH;
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath))) {
            for (feedback feedback : feedbackList) {
                writer.println(feedback.toString());
            }
        }
    }

    private void sendJsonResponse(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    // Helper methods for JSON conversion without Gson
    private String convertFeedbackToJson(feedback feedback) {
        if (feedback == null) {
            return "null";
        }
        return String.format(
                "{\"id\":\"%s\",\"name\":\"%s\",\"email\":\"%s\",\"rating\":%d,\"comments\":\"%s\",\"date\":\"%s\"}",
                escapeJson(feedback.getId()),
                escapeJson(feedback.getName()),
                escapeJson(feedback.getEmail()),
                feedback.getRating(),
                escapeJson(feedback.getComments()),
                escapeJson(feedback.getDate())
        );
    }

    private String convertFeedbackListToJson(List<feedback> feedbackList) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < feedbackList.size(); i++) {
            if (i > 0) {
                sb.append(",");
            }
            sb.append(convertFeedbackToJson(feedbackList.get(i)));
        }
        sb.append("]");
        return sb.toString();
    }

    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}

class FeedbackReview {
    private String id;
    private String name;
    private String email;
    private int rating;
    private String comments;
    private String date;

    public FeedbackReview() {
        this.date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    @Override
    public String toString() {
        return id + "|" + name + "|" + email + "|" + rating + "|" + comments + "|" + date;
    }

    public static feedback fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 6) {
            feedback feedback = new feedback();
            feedback.setId(parts[0]);
            feedback.setName(parts[1]);
            feedback.setEmail(parts[2]);
            feedback.setRating(Integer.parseInt(parts[3]));
            feedback.setComments(parts[4]);
            feedback.setDate(parts[5]);
            return feedback;
        }
        return null;
    }
}