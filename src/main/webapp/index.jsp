<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>      
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - main page</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/authentication.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="WEB-INF/jspf/userPanel.jspf"%>

        <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
            <h1 class="display-4">Log in!</h1>
        </div>

        <div class="container">
            <div class="card">
                <article class="card-body">
                    <c:if test="${sessionScope.msg != null && !sessionScope.msg.trim().isEmpty()}">
                        <p class="lead alert-danger text-center">${sessionScope.msg}</p>
                    </c:if>
                    <h4 class="card-title mb-4 mt-1">Sign in</h4>
                    <form action="authentication" method="POST">
                        <div class="form-group">
                            <label>Your user name</label>
                            <input name="login" class="form-control" placeholder="User name" type="text">
                        </div>
                        <div class="form-group">
                            <label>Your password</label>
                            <input name="password" class="form-control" placeholder="******" type="password">
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block"> Login  </button>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </div>
                    </form>
                </article>
            </div>

            <%@include file="WEB-INF/jspf/footer.jspf"%>
        </div>
    </body>
</html>