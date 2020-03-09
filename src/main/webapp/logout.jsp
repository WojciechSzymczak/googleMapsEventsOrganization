<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - logout page</title>
    </head>
    <body>
        <%
            request.getSession(false).invalidate(); 
            String redirectURL = "index.jsp";
            response.sendRedirect(redirectURL);
        %>
    </body>
</html>
