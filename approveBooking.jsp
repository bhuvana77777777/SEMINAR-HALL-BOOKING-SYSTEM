<%@ page import="java.sql.*, javax.mail.*, javax.mail.internet.*, java.util.Properties" %>
<%@ include file="dbConnection.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String email = request.getParameter("email");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        con = getConnection();
        String query = "UPDATE hall_requests SET status='Approved' WHERE id=?";
        pst = con.prepareStatement(query);
        pst.setInt(1, id);
        pst.executeUpdate();

        // Send email notification
        String subject = "Seminar Hall Booking Approved";
        String message = "Your seminar hall booking request has been approved!";
        sendEmail(email, subject, message);

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
