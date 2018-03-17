<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>      
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="/images/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events - main page</title>   
        <link href="/css/bootstrap.min.css" rel="stylesheet">        
        <link href="/css/mycss/style1.css" rel="stylesheet">
    </head>
    
    <body>
                
        <%@ include file="/WEB-INF/jspf/userPanel.jspf" %>
        <%@ include file="/WEB-INF/jspf/searchBar.jspf" %>               
        <%@ include file="/WEB-INF/jspf/menu.jspf" %>

         <!-- Main jumbotron for a primary marketing message or call to action -->
         <div class="jumbotron">
           <div class="container">
               
             <h1>
                 Welcome on the main page!                    
             </h1>
               
               <p>
                   <c:if test="${pageContext.request.isUserInRole('user')}">
                        Logged as user ${pageContext.request.getRemoteUser()}!<br>
                        <a href="logout.jsp">Logout</a>
                    </c:if>
                    <c:if test="${pageContext.request.isUserInRole('admin')}">
                        Logged as administrator ${pageContext.request.getRemoteUser()}!<br>
                        <a href="logout.jsp">Logout</a>
                    </c:if>
               </p>
             <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p>
             
           </div>
         </div>

         <div class="container">
           <!-- Example row of columns -->
           <div class="row">
             <div class="col-md-4">
               <h2>Heading</h2>
               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
             </div>
             <div class="col-md-4">
               <h2>Heading</h2>
               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
            </div>               
             <div class="col-md-4">
               <h2>Heading</h2>
               <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
             </div>
           </div>        
        </div>        
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>');</script>
        <script src="/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(){
                if(window.location.href.indexOf("#login") > -1) {
                    $('#login-modal').modal('show');
                }
            });        
        </script>
    </body>
    
</html>
