<%@ taglib prefix="shop" tagdir="/WEB-INF/tags" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <shop:head pageName="User Orders" />
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />
    <h1>Your Orders</h1>

    // load from tag
    <shop:listUserOrders />
</body>
</html>