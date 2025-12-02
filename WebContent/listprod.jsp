<%@ include file="/WEB-INF/jdbc.jsp" %>

<%@ page import="java.sql.*,java.net.URLEncoder" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ taglib prefix="shop" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <shop:head pageName="Products" />

	<style>
		.product-grid {
			display: flex;
			flex-wrap: wrap;
			gap: 20px;
			margin-top: 20px;
		}

		.product-card {
			border: 1px solid #ddd;
			border-radius: 6px;
			padding: 12px;
			width: 260px;          /* tweak as you like */
			background-color: #fff;
		}

		.product-card h3 {
			font-size: 1rem;
			margin: 8px 0;
		}

		.product-card .product-category {
			font-size: 0.85rem;
			color: #666;
		}

		.product-card .product-price {
			font-weight: bold;
			margin-top: 6px;
		}

		.product-card .add-to-cart {
			margin-bottom: 8px;
		}

		.product-card-title {
			font-size: 1.1rem;
			font-weight: 600;
		}

		.product-card-price {
			font-size: 1.05rem;
			font-weight: bold;
			color: black;
		}

		a {
			text-decoration: none;
			color: inherit;
		}

		.product-card-category {
			font-size: 0.9rem;
			color: #666;
		}

		.product-img-wrap {
			width: 100%;
			height: 180px;              /* adjust as needed */
			overflow: hidden;
			display: flex;
			justify-content: center;
			align-items: center;
			background: #f8f8f8;        /* optional Amazon vibes */
			border-bottom: 1px solid #eee;
		}

		.product-img {
			max-width: 100%;
			max-height: 100%;
			object-fit: contain;        /* DON'T crop */
		}

	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/header.jsp" />

<% // Get product name to search for
String name = request.getParameter("productName");
String resultTitle = null;
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make the connection
try {
	getConnection();
	String sql;
	PreparedStatement pstmt;
	if (name == null || name.trim().isEmpty())
	{
		// Query to get all products
		sql = "SELECT p.productId, p.productName, p.productPrice, p.productImageURL, c.categoryName " +
				"FROM Product p JOIN Category c ON p.categoryId = c.categoryId " +
				"ORDER BY p.productName;";
		pstmt = con.prepareStatement(sql);
	}
	else
	{
		// Query to get products that match search string
		sql = "SELECT p.productId, p.productName, p.productPrice, p.productImageURL, c.categoryName " +
				"FROM Product p JOIN Category c ON p.categoryId = c.categoryId " +
				"WHERE p.productName LIKE ? " +
				"ORDER BY p.productName;";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + name + "%");
		resultTitle = "Products matching '" + name + "'";
	}
	
	%> 

<%
	try (ResultSet products = pstmt.executeQuery()) {
		if (!products.isBeforeFirst()) {
%>
			<p>No products found.</p>
<%
		} else {
%>
			<shop:displayProductGrid productResultSet="<%= products %>" title="<%= resultTitle %>" />
<%
		}
	}
%>

<%
	} // End try
catch (SQLException e)
{
	out.println("SQLException: " + e);
}
%>

</body>
</html>