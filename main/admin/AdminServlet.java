package com.restuarant;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final String FEEDBACK_FILE = "feedback.txt";
    private static final String SETTINGS_FILE = "admin_settings.txt";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("dashboard".equals(action)) {
                sendDashboardData(response);
            } else if ("allFeedback".equals(action)) {
                sendAllFeedback(response);
            } else if ("getFeedback".equals(action)) {
                sendSingleFeedback(request, response);
            } else if ("analytics".equals(action)) {
                sendAnalyticsData(response);
            } else if ("getSettings".equals(action)) {
                sendSettings(response);
            }
        } catch (Exception e) {
            sendJsonResponse(response, "{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("respond".equals(action)) {
                respondToFeedback(request, response);
            } else if ("delete".equals(action)) {
                deleteFeedback(request, response);
            } else if ("saveSettings".equals(action)) {
                saveSettings(request, response);
            }
        } catch (Exception e) {
            sendJsonResponse(response, "{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    private void sendDashboardData(HttpServletResponse response) throws IOException {
        List<feedback> feedbackList = readFeedbackFromFile();

        // Calculate dashboard metrics
        int totalFeedback = feedbackList.size();
        int positiveRatings = (int) feedbackList.stream().filter(f -> f.getRating() >= 4).count();
        int negativeRatings = (int) feedbackList.stream().filter(f -> f.getRating() <= 2).count();
        int respondedFeedback = (int) feedbackList.stream().filter(f -> f.getResponse() != null && !f.getResponse().isEmpty()).count();

        // Get recent feedback (last 5)
        List<feedback> recentFeedback = feedbackList.stream()
                .sorted((f1, f2) -> f2.getDate().compareTo(f1.getDate()))
                .limit(5)
                .collect(Collectors.toList());

        // Prepare JSON response
        StringBuilder json = new StringBuilder();
        json.append("{\"totalFeedback\":").append(totalFeedback)
                .append(",\"positiveRatings\":").append(positiveRatings)
                .append(",\"negativeRatings\":").append(negativeRatings)
                .append(",\"respondedFeedback\":").append(respondedFeedback)
                .append(",\"recentFeedback\":[");

        for (int i = 0; i < recentFeedback.size(); i++) {
            if (i > 0) json.append(",");
            json.append(convertFeedbackToJson(recentFeedback.get(i)));
        }

        json.append("]}");

        sendJsonResponse(response, json.toString());
    }

    private void sendAllFeedback(HttpServletResponse response) throws IOException {
        List<feedback> feedbackList = readFeedbackFromFile();

        // Sort by date descending
        feedbackList.sort((f1, f2) -> f2.getDate().compareTo(f1.getDate()));

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < feedbackList.size(); i++) {
            if (i > 0) json.append(",");
            json.append(convertFeedbackToJson(feedbackList.get(i)));
        }
        json.append("]");

        sendJsonResponse(response, json.toString());
    }

    private void sendSingleFeedback(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        List<feedback> feedbackList = readFeedbackFromFile();

        feedback feedback = feedbackList.stream()
                .filter(f -> f.getId().equals(id))
                .findFirst()
                .orElse(null);

        if (feedback == null) {
            sendJsonResponse(response, "{\"success\":false,\"message\":\"Feedback not found\"}");
            return;
        }

        sendJsonResponse(response, convertFeedbackToJson(feedback));
    }

    private void sendAnalyticsData(HttpServletResponse response) throws IOException {
        List<feedback> feedbackList = readFeedbackFromFile();

        // Rating distribution (1-5 stars)
        int[] ratingDistribution = new int[5];
        for (feedback f : feedbackList) {
            if (f.getRating() >= 1 && f.getRating() <= 5) {
                ratingDistribution[f.getRating() - 1]++;
            }
        }

        // Feedback trend (last 30 days)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        List<String> trendLabels = new ArrayList<>();
        List<Integer> trendData = new ArrayList<>();

        for (int i = 29; i >= 0; i--) {
            calendar.add(Calendar.DATE, -1);
            String date = dateFormat.format(calendar.getTime());

            long count = feedbackList.stream()
                    .filter(f -> f.getDate().startsWith(date))
                    .count();

            trendLabels.add(date);
            trendData.add((int) count);
        }

        // Reverse to show chronological order
        Collections.reverse(trendLabels);
        Collections.reverse(trendData);

        // Prepare JSON response
        StringBuilder json = new StringBuilder();
        json.append("{\"ratingDistribution\":[");
        for (int i = 0; i < ratingDistribution.length; i++) {
            if (i > 0) json.append(",");
            json.append(ratingDistribution[i]);
        }

        json.append("],\"trendLabels\":[");
        for (int i = 0; i < trendLabels.size(); i++) {
            if (i > 0) json.append(",");
            json.append("\"").append(trendLabels.get(i)).append("\"");
        }

        json.append("],\"trendData\":[");
        for (int i = 0; i < trendData.size(); i++) {
            if (i > 0) json.append(",");
            json.append(trendData.get(i));
        }

        json.append("]}");

        sendJsonResponse(response, json.toString());
    }

    private void respondToFeedback(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String feedbackId = request.getParameter("feedbackId");
        String adminResponse = request.getParameter("response");

        List<feedback> feedbackList = readFeedbackFromFile();

        for (feedback feedback : feedbackList) {
            if (feedback.getId().equals(feedbackId)) {
                feedback.setResponse(adminResponse);
                feedback.setResponseDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                break;
            }
        }

        saveAllFeedbackToFile(feedbackList);
        sendJsonResponse(response, "{\"success\":true,\"message\":\"Response saved successfully\"}");
    }

    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String feedbackId = request.getParameter("feedbackId");
        List<feedback> feedbackList = readFeedbackFromFile();

        boolean removed = feedbackList.removeIf(feedback -> feedback.getId().equals(feedbackId));

        if (removed) {
            saveAllFeedbackToFile(feedbackList);
            sendJsonResponse(response, "{\"success\":true,\"message\":\"Feedback deleted successfully\"}");
        } else {
            sendJsonResponse(response, "{\"success\":false,\"message\":\"Feedback not found\"}");
        }
    }

    private void sendSettings(HttpServletResponse response) throws IOException {
        Properties settings = readSettingsFromFile();

        StringBuilder json = new StringBuilder();
        json.append("{\"restaurantName\":\"")
                .append(escapeJson(settings.getProperty("restaurantName", "")))
                .append("\",\"adminEmail\":\"")
                .append(escapeJson(settings.getProperty("adminEmail", "")))
                .append("\",\"notificationPref\":\"")
                .append(escapeJson(settings.getProperty("notificationPref", "all")))
                .append("\"}");

        sendJsonResponse(response, json.toString());
    }

    private void saveSettings(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Properties settings = new Properties();
        settings.setProperty("restaurantName", request.getParameter("restaurantName"));
        settings.setProperty("adminEmail", request.getParameter("adminEmail"));
        settings.setProperty("notificationPref", request.getParameter("notificationPref"));

        String filePath = getServletContext().getRealPath("/") + SETTINGS_FILE;
        try (OutputStream output = new FileOutputStream(filePath)) {
            settings.store(output, "Restaurant Admin Settings");
        }

        sendJsonResponse(response, "{\"success\":true,\"message\":\"Settings saved successfully\"}");
    }

    private List<feedback> readFeedbackFromFile() throws IOException {
        List<feedback> feedbackList = new ArrayList<>();
        String filePath = getServletContext().getRealPath("/") + FEEDBACK_FILE;
        File file = new File(filePath);

        if (!file.exists()) {
            return feedbackList;
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

        return feedbackList;
    }

    private void saveAllFeedbackToFile(List<feedback> feedbackList) throws IOException {
        String filePath = getServletContext().getRealPath("/") + FEEDBACK_FILE;
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath))) {
            for (feedback feedback : feedbackList) {
                writer.println(feedback.toString());
            }
        }
    }

    private Properties readSettingsFromFile() throws IOException {
        Properties settings = new Properties();
        String filePath = getServletContext().getRealPath("/") + SETTINGS_FILE;
        File file = new File(filePath);

        if (file.exists()) {
            try (InputStream input = new FileInputStream(file)) {
                settings.load(input);
            }
        }

        return settings;
    }

    private String convertFeedbackToJson(feedback feedback) {
        return String.format(
                "{\"id\":\"%s\",\"name\":\"%s\",\"email\":\"%s\",\"rating\":%d,\"comments\":\"%s\",\"date\":\"%s\",\"response\":\"%s\",\"responseDate\":\"%s\"}",
                escapeJson(feedback.getId()),
                escapeJson(feedback.getName()),
                escapeJson(feedback.getEmail()),
                feedback.getRating(),
                escapeJson(feedback.getComments()),
                escapeJson(feedback.getDate()),
                escapeJson(feedback.getResponse() != null ? feedback.getResponse() : ""),
                escapeJson(feedback.getResponseDate() != null ? feedback.getResponseDate() : "")
        );
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

    private void sendJsonResponse(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}

class feedback {
    private String id;
    private String name;
    private String email;
    private int rating;
    private String comments;
    private String date;
    private String response;
    private String responseDate;

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

    public String getResponse() { return response; }
    public void setResponse(String response) { this.response = response; }

    public String getResponseDate() { return responseDate; }
    public void setResponseDate(String responseDate) { this.responseDate = responseDate; }

    @Override
    public String toString() {
        return id + "|" + name + "|" + email + "|" + rating + "|" + comments + "|" + date +
                (response != null ? "|" + response + "|" + responseDate : "");
    }

    public static feedback fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length >= 6) {
            feedback feedback = new feedback();
            feedback.setId(parts[0]);
            feedback.setName(parts[1]);
            feedback.setEmail(parts[2]);
            feedback.setRating(Integer.parseInt(parts[3]));
            feedback.setComments(parts[4]);
            feedback.setDate(parts[5]);

            if (parts.length >= 8) {
                feedback.setResponse(parts[6]);
                feedback.setResponseDate(parts[7]);
            }

            return feedback;
        }
        return null;
    }
}