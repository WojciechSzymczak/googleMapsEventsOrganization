<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - error</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/authentication.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center error">
                    <span class="display-1 d-block">404</span>
                    <div class="mb-4 lead">Oops! We couldn't find the page you are looking for.</div>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-link">Home</a>
                </div>
            </div>
        </div>
    </body>
</html>