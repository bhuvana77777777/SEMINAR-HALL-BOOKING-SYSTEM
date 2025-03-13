<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    String hallName = request.getParameter("hallName");
    String date = request.getParameter("date");
    String timeFrom = request.getParameter("timeFrom");
    String timeTo = request.getParameter("timeTo");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        con = getConnection();
        String query = "UPDATE seminarhall SET Date=?, time_from=?, time_to=?, availability='Booked' WHERE DeptName=?";
        pst = con.prepareStatement(query);
        pst.setString(1, date);
        pst.setString(2, timeFrom);
        pst.setString(3, timeTo);
        pst.setString(4, hallName);
        int rows = pst.executeUpdate();

        if (rows > 0) {
            out.print("Hall booked successfully!");
        } else {
            out.print("Error: Hall booking failed.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
