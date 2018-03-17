<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>        
        <link rel="icon" type="image/png" href="/images/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events - logout page</title>
    </head>
    <body>
        
        <%
            request.getSession(false).invalidate(); 
            String redirectURL = "index.jsp";
            response.sendRedirect(redirectURL);
        %>
                
    </body>
</html>
