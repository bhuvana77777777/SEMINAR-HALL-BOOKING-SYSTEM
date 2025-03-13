<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%! 
    public Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/seminarhallbooking";
        String user = "root"; 
        String password = "system";  
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            throw new SQLException("Database connection failed: " + e.getMessage());
        }
        
        return conn;
    }
%>

<%
    Connection conn = null;
    try {
        conn = getConnection();
        out.println("<p>Database connection successful!</p>");
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                out.println("<p>Error closing connection: " + e.getMessage() + "</p>");
            }
        }
    }
%>
