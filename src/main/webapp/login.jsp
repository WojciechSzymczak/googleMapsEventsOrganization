<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" type="image/png" href="/images/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events - login page</title>
    </head>
    
    <body>
        
        <h2>Hello, please log in:</h2>
        <br><br>
        <form action="j_security_check" method=post>
            <p><strong>Please Enter Your User Name: </strong>
            <input type="text" name="j_username" size="25">
            <p><p><strong>Please Enter Your Password: </strong>
            <input type="password" size="15" name="j_password">
            <p><p>
            <input type="submit" value="Submit">
            <input type="reset" value="Reset">
        </form>
        
        
    </body>
</html>
