<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    String adminEmail = request.getParameter("adminEmail");
    String adminPassword = request.getParameter("adminPassword");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    boolean isValid = false;

    try {
        con = getConnection();
        String query = "SELECT password FROM admin WHERE email=?";
        pst = con.prepareStatement(query);
        pst.setString(1, adminEmail);
        rs = pst.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");

            if (storedPassword.equals(adminPassword)) { // Direct comparison
                session.setAttribute("admin", adminEmail);
                isValid = true;
            }
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p>Error closing database: " + e.getMessage() + "</p>");
        }
    }

    if (isValid) {
        response.sendRedirect("adminPanel.jsp"); // Redirect to admin panel on success
    } else {
        out.println("<script>alert('Invalid Credentials'); window.location='index.html';</script>");
    }
%>
