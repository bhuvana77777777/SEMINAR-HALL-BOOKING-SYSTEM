<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    // Retrieve user input from the login form
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Database connection variables
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    boolean isValid = false; // Flag to check if login is successful

    try {
        con = getConnection(); // Get database connection

        // SQL query to check if the email and password match
        String query = "SELECT * FROM login WHERE email=? AND password=?";
        pst = con.prepareStatement(query);
        pst.setString(1, email); // Set email in query
        pst.setString(2, password); // Set password in query
        rs = pst.executeQuery();

        // If a record is found, set session and mark as valid login
        if (rs.next()) {
            session.setAttribute("user", email); // Store email in session
            isValid = true;
        }
    } catch (Exception e) {
        e.printStackTrace(); // Print any error in console
    } finally {
        // Close resources to prevent memory leaks
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }

    // Redirect based on login result
    if (isValid) {
        response.sendRedirect("event.html"); // Redirect to event page if login is successful
    } else {
        out.println("<script>alert('Invalid Credentials'); window.location='f_login.html';</script>");
    }
%>
