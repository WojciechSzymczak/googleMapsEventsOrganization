<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - user's main page</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/authentication.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/userPanel.jspf"%>

        <c:if test="${sessionScope.user == null || sessionScope.user.userRole == null || sessionScope.user.userRole != 'user'}">
            <c:redirect url="/index.jsp"/>
        </c:if>

        <div class="container">
            <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
                <h1 class="display-4">User ${sessionScope.user.userName} actions:</h1>
            </div>

            <table class="table table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Date</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="rowCount" scope="request" value="${1}"/>
                <c:forEach var="action" items="${actions}">
                    <tr>
                        <th scope="row">${rowCount}</th>
                        <td>${action.getDateInPrintableFormat()}</td>
                        <td>${action.getAction()}</td>
                    </tr>
                    <c:set var="rowCount" scope="request" value="${rowCount + 1}"/>
                </c:forEach>
                </tbody>
            </table>

            <%@include file="../WEB-INF/jspf/footer.jspf"%>
        </div>
    </body>
</html>