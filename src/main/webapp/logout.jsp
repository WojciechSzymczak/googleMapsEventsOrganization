<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - logout page</title>
    </head>
    <body>
        <% request.getSession(false).invalidate(); %>
        <c:redirect url="/index.jsp"/>
    </body>
</html>
