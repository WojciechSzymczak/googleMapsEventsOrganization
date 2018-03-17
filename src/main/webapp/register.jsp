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
        <title>Events - register page</title>   
        <link href="/../css/bootstrap.min.css" rel="stylesheet">        
        <link href="/../css/mycss/style1.css" rel="stylesheet">
    </head>
    
    <body>                
        <%@ include file="/WEB-INF/jspf/userPanel.jspf" %>
        <%@ include file="/WEB-INF/jspf/searchBar.jspf" %>               
        <%@ include file="/WEB-INF/jspf/menu.jspf" %>        
        
        ${requestScope["registerResultMessage"]}
        
        <div class="container">
            <div class="row">
                <form class="form-horizontal" action="UserRegisterController" method="post">
                    <fieldset>

                    <!-- Form Name -->
                    <legend>Register</legend>

                    <!-- Text input-->
                    <div class="form-group">
                      <label class="col-md-4 control-label" for="Name">Name</label>  
                      <div class="col-md-5">
                      <input id="Name" name="user_name" type="text" placeholder="username" class="form-control input-md" required="">

                      </div>
                    </div>

                    <!-- Password input-->
                    <div class="form-group">
                      <label class="col-md-4 control-label" for="passwordinput">Password</label>
                      <div class="col-md-5">
                        <input id="passwordinput" name="passwordinput" type="password" placeholder="" class="form-control input-md" required="">
                        <span class="help-block">max 16 characters</span>
                      </div>
                    </div>

                    <!-- Password input-->
                    <div class="form-group">
                      <label class="col-md-4 control-label" for="confirm_password">Confirm Password</label>
                      <div class="col-md-5">
                        <input id="confirm_password" name="user_pass" type="password" placeholder="Re-type password" class="form-control input-md" required="">

                      </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                      <label class="col-md-4 control-label" for="emailId">Email</label>  
                      <div class="col-md-5">
                      <input id="email" name="user_email" type="text" placeholder="user@domain.com" class="form-control input-md" required="">

                      </div>
                    </div>

                    <!-- Button -->
                    <div class="form-group">
                      <label class="col-md-4 control-label " for="submit"></label>
                      <div class="col-md-4">
                        <button id="submit" name="submit" class="btn btn-success">Submit</button>
                      </div>
                    </div>

                    </fieldset>
                </form>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>');</script>
        <script src="/js/bootstrap.min.js"></script>
    </body>
    
</html>
