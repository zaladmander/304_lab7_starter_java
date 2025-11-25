<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>

<!DOCTYPE html>
<html>
<head>
    <%
        String currentPage = "Admin Dashboard - Sales Report by Day";   
        request.setAttribute("currentPage", currentPage);
	%>

    <title>
		<%= (request.getAttribute("currentPage") != null ? request.getAttribute("currentPage") : "") %> 
		<%= (request.getAttribute("currentPage") != null ? " - " : "") %>
		<%= getServletContext().getInitParameter("siteTitle") %>
	</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>Order Date</th>
        <th>Total Sales Amount</th>
    </tr>
<%
    String sql = "SELECT orderDate, SUM(totalAmount) AS totalAmount" +
                    " FROM ordersummary GROUP BY orderDate ORDER BY orderDate DESC;";

    try {
        getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        NumberFormat money = NumberFormat.getCurrencyInstance();  
        while (rs.next()) {
            String orderDate = rs.getString("orderDate");
            double totalAmount = rs.getDouble("totalAmount");

            request.setAttribute("orderDate", orderDate);
            request.setAttribute("totalAmount", totalAmount);
%>
    <tr>
        <td><%= orderDate %></td>
        <td><%= money.format(totalAmount) %></td>
    </tr>
<%
        }
        rs.close();
        ps.close();
        closeConnection();
    } catch (SQLException e) {
        out.println("<p>Error generating sales report: " + e + "</p>");
    }
%>
</table>


</body>
</html>

