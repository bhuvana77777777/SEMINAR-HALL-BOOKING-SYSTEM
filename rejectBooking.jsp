<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    Connection con = null;
    PreparedStatement pst = null;

    try {
        con = getConnection();
        String query = "UPDATE hall_requests SET status='Rejected' WHERE id=?";
        pst = con.prepareStatement(query);
        pst.setInt(1, id);
        pst.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
