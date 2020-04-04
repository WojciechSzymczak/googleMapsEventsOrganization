<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - password change page</title>
        <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/authentication.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/icons/fontawesome/css/fontawesome.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/icons/fontawesome/css/brands.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/icons/fontawesome/css/solid.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/userPanel.jspf"%>

        <c:if test="${sessionScope.user == null || sessionScope.user.userRole == null || sessionScope.user.userRole != 'user'}">
            <c:redirect url="/index.jsp"/>
        </c:if>

        <div class="px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
            <h1 class="display-4">Change Password</h1>
        </div>

        <div class="container">
            <div class="card">
                <article class="card-body">
                    <c:if test="${sessionScope.msg != null && !sessionScope.msg.trim().isEmpty()}">
                        <p class="lead alert-danger text-center">${sessionScope.msg}</p>
                    </c:if>
                    <c:if test="${sessionScope.res != null && !sessionScope.res.trim().isEmpty()}">
                        <p class="lead alert-success text-center">${sessionScope.res}</p>
                    </c:if>
                    <div class="form-group">
                        <form action="${pageContext.request.contextPath}/changePass" method="POST">
                            <div class="form-group">
                                <label>Type new password:</label>
                                <input type="password" class="input-lg form-control" name="password1" id="password1" placeholder="New Password" autocomplete="off">
                                <i class="fas fa-times fa-danger" id="8char"></i> 8 Characters Long
                                <i class="fas fa-times fa-danger" id="uCase"></i> One Uppercase Letter
                                <i class="fas fa-times fa-danger" id="lCase"></i> One Lowercase Letter
                                <i class="fas fa-times fa-danger" id="num"></i> One Number
                                </div>
                            <div class="form-group">
                                <label>Repeat password:</label>
                                <input type="password" class="input-lg form-control" name="password2" id="password2" placeholder="Repeat Password" autocomplete="off">
                                <i class="fas fa-times fa-danger" id="pwMatch"></i> Passwords Match
                            </div>
                            <div class="form-group">
                                <input type="submit" id="submitButton" class="btn btn-primary btn-block" data-loading-text="Changing Password..." value="Change Password" disabled>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </div>
                        </form>
                    </div>
                </article>
            </div>

            <%@include file="../WEB-INF/jspf/footer.jspf"%>
        </div>
    </body>
</html>

<script type="text/javascript">
    $("input[type=password]").keyup(function(){
        var ucase = new RegExp("[A-Z]+");
        var lcase = new RegExp("[a-z]+");
        var num = new RegExp("[0-9]+");
        var eightLetters = false;
        var uppercaseLetter = false;
        var lowercaseLetter = false;
        var oneNumber = false;
        var passwordsMatch = false;

        if($("#password1").val().length >= 8){
            $("#8char").removeClass("fa-danger");
            $("#8char").addClass("fa-success");
            eightLetters = true;
        }else{
            $("#8char").removeClass("fa-success");
            $("#8char").addClass("fa-danger");
            eightLetters = false;
        }

        if(ucase.test($("#password1").val())){
            $("#uCase").removeClass("fa-danger");
            $("#uCase").addClass("fa-success");
            uppercaseLetter = true;
        }else{
            $("#uCase").removeClass("fa-success");
            $("#uCase").addClass("fa-danger");
            uppercaseLetter = false;
        }

        if(lcase.test($("#password1").val())){
            $("#lCase").removeClass("fa-danger");
            $("#lCase").addClass("fa-success");
            lowercaseLetter = true;
        }else{
            $("#lCase").removeClass("fa-success");
            $("#lCase").addClass("fa-danger");
            lowercaseLetter = false;
        }

        if(num.test($("#password1").val())){
            $("#num").removeClass("fa-danger");
            $("#num").addClass("fa-success");
            oneNumber = true;
        }else{
            $("#num").removeClass("fa-success");
            $("#num").addClass("fa-danger");
            oneNumber = false;
        }

        if($("#password1").val() == $("#password2").val()){
            $("#pwMatch").removeClass("fa-danger");
            $("#pwMatch").addClass("fa-success");
            passwordsMatch = true;
        }else{
            $("#pwMatch").removeClass("fa-success");
            $("#pwMatch").addClass("fa-danger");
            passwordsMatch = false;
        }

        if($("#password1").val() == $("#password2").val()){
            $("#pwMatch").removeClass("fa-danger");
            $("#pwMatch").addClass("fa-success");
            passwordsMatch = true;
        }else{
            $("#pwMatch").removeClass("fa-success");
            $("#pwMatch").addClass("fa-danger");
            passwordsMatch = false;
        }

        if (eightLetters && uppercaseLetter && lowercaseLetter && oneNumber && passwordsMatch) {
            $("#submitButton").prop('disabled', false);
        }else{
            $("#submitButton").prop('disabled', true);
        }
    });
</script>