<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>      
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="/../images/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events - profile page</title>   
        <link href="/../css/bootstrap.min.css" rel="stylesheet">        
        <link href="/../css/mycss/style1.css" rel="stylesheet">
    </head>
    
    <body>                
        <%@ include file="/WEB-INF/jspf/userPanel.jspf" %>
        <%@ include file="/WEB-INF/jspf/searchBar.jspf" %>               
        <%@ include file="/WEB-INF/jspf/menu.jspf" %>
        
        <div class="container">
           <div class="row">
        
                <form name="form" action="UserProfileController" method="post">                       
                        First Name: <input type="text" name="user_first_name" value=${requestScope["user_first_name"]}><br>                        
                        Last Name: <input type="text" name="user_last_name" value=${requestScope["user_last_name"]}>
                        <input type="submit" value="Save">
                        <input type="reset" value="Reset">
                </form>                                
                        ${requestScope["updateResultMessage"]}
                        
                        
           </div>
        </div>                        
                
        <%@ include file="/WEB-INF/jspf/footer.jspf" %> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>');</script>
        <script src="/js/bootstrap.min.js"></script>
    </body>
    
</html>
