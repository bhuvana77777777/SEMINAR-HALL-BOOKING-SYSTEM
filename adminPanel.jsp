<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    // Ensure the admin is logged in
    String adminEmail = (String) session.getAttribute("admin");
    if (adminEmail == null) {
        response.sendRedirect("adminLogin.html");
        return;
    }
%>

<html>
<head>
    <title>Admin Panel - Approve Bookings</title>
    <script>
        function approveBooking(id, email) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "approveBooking.jsp?id=" + id + "&email=" + encodeURIComponent(email), true);
            xhr.onload = function() {
                if (xhr.status == 200) {
                    alert("Booking approved successfully!");
                    location.reload();
                } else {
                    alert("Error approving booking.");
                }
            };
            xhr.send();
        }

        function rejectBooking(id) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "rejectBooking.jsp?id=" + id, true);
            xhr.onload = function() {
                if (xhr.status == 200) {
                    alert("Booking rejected!");
                    location.reload();
                } else {
                    alert("Error rejecting booking.");
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>
    <h2>Pending Booking Requests</h2>
    <a href="adminLogout.jsp">Logout</a> <!-- Logout link -->

    <table border="1">
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Event Title</th>
            <th>Hall</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>

        <%
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                con = getConnection();
                String query = "SELECT id, name, email, eventTitle, hall, date FROM hall_requests WHERE status='Pending'";
                pst = con.prepareStatement(query);
                rs = pst.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String eventTitle = rs.getString("eventTitle");
                    String hall = rs.getString("hall");
                    String date = rs.getString("date");

                    out.println("<tr>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + eventTitle + "</td>");
                    out.println("<td>" + hall + "</td>");
                    out.println("<td>" + date + "</td>");
                    out.println("<td>");
                    out.println("<button onclick=\"approveBooking(" + id + ", '" + email + "')\">Approve</button>");
                    out.println("<button onclick=\"rejectBooking(" + id + ")\">Reject</button>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                out.println("<p>Error loading bookings: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    out.println("<p>Error closing database: " + e.getMessage() + "</p>");
                }
            }
        %>
    </table>
</body>
</html>
