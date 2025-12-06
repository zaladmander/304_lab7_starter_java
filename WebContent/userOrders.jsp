<%@ taglib prefix="shop" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/auth.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <shop:head pageName="User Orders" />
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />

    <h1>Your Orders</h1>

    <jsp:include page="/WEB-INF/listUserOrders.jsp">
        <jsp:param name="userId" value="${sessionScope.authenticatedUser}" />
    </jsp:include>

</body>
</html>