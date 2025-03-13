<%@ page import="java.sql.*, org.json.simple.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    JSONArray halls = new JSONArray();

    try {
        con = getConnection();
        String query = "SELECT DeptName, availability FROM seminarhall";
        pst = con.prepareStatement(query);
        rs = pst.executeQuery();

        while (rs.next()) {
            JSONObject hall = new JSONObject();
            hall.put("DeptName", rs.getString("DeptName"));
            hall.put("availability", rs.getString("availability"));
            halls.add(hall);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }

    out.print(halls.toJSONString());
%>
