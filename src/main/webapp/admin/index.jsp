<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
    <head>        
        <link rel="icon" type="image/png" href="/images/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events - admin main page</title>        
    </head>
    <body>
        
        <h1>Hello World from admin folder!</h1>
        
            <c:if test="${pageContext.request.isUserInRole('admin')}">
                Logged as administrator ${pageContext.request.getRemoteUser()}!<br>
                <a href="../logout.jsp">Logout</a>
            </c:if>
    
    </body>
</html>
