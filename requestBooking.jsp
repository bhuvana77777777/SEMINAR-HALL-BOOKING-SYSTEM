<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String eventTitle = request.getParameter("eventTitle");
    String fromTime = request.getParameter("fromTime");
    String toTime = request.getParameter("toTime");
    String capacity = request.getParameter("capacity");
    String hall = request.getParameter("hall");
    String date = request.getParameter("date");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        con = getConnection();
        String query = "INSERT INTO hall_requests (name, email, phone, eventTitle, fromTime, toTime, capacity, hall, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pst = con.prepareStatement(query);
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, phone);
        pst.setString(4, eventTitle);
        pst.setString(5, fromTime);
        pst.setString(6, toTime);
        pst.setString(7, capacity);
        pst.setString(8, hall);
        pst.setString(9, date);
        int rows = pst.executeUpdate();

        if (rows > 0) {
            out.print("Booking request submitted successfully!");
        } else {
            out.print("Error: Request submission failed.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
