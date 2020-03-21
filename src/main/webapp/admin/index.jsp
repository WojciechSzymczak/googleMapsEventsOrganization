<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - admin page</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/authentication.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/userPanel.jspf"%>

        <c:if test="${sessionScope.user == null || sessionScope.user.userRole == null || sessionScope.user.userRole != 'admin'}">
            <c:redirect url="/index.jsp"/>
        </c:if>

        <div class="container">

            <%@include file="../WEB-INF/jspf/footer.jspf"%>
        </div>
    </body>
</html>