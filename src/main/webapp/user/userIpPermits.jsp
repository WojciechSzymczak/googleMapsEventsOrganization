<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication app - user's IP permissions.</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/authentication.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/userPanel.jspf"%>

        <c:if test="${sessionScope.user == null || sessionScope.user.userRole == null || sessionScope.user.userRole != 'user'}">
            <c:redirect url="/index.jsp"/>
        </c:if>

        <div class="container">
            <c:if test="${sessionScope.msg != null && !sessionScope.msg.trim().isEmpty()}">
                <p class="lead alert-danger text-center">${sessionScope.msg}</p>
            </c:if>

            <form action="${pageContext.request.contextPath}/permits" method="POST">
                <div class="px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
                    <label class="pb-3" for="ip_permit">Add IP address restriction:</label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="ip">For example: 127.0.0.1</span>
                        </div>
                        <input type="text" class="form-control" id="ip_permit" aria-describedby="ip" name="ip_address">
                        <div class="input-group-append">
                            <button type="submit" class="btn btn-primary">Add</button>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="task_name" value="add_ip_permit"/>
                        </div>
                    </div>
                </div>
            </form>

            <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
                <h1 class="display-4">User ${sessionScope.user.userName} IP permissions:</h1>
            </div>

                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">IP</th>
                        <th scope="col">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:set var="rowCount" scope="request" value="${1}"/>
                        <c:forEach var="Ip" items="${permits}">
                            <form action="${pageContext.request.contextPath}/permits" method="POST">
                                <tr>
                                    <th scope="row">${rowCount}</th>
                                    <td>${Ip.getPermitIp()}</td>
                                    <td><button type="submit" id="deleteButton" class="btn btn-danger">Delete</button></td>
                                </tr>
                                <input type="hidden" name="permit_id" value="${Ip.getPermitId()}"/>
                                <input type="hidden" name="task_name" value="delete_ip_permit"/>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </form>
                            <c:set var="rowCount" scope="request" value="${rowCount + 1}"/>
                        </c:forEach>
                    </tbody>
                </table>

            <%@include file="../WEB-INF/jspf/footer.jspf"%>
        </div>
    </body>
</html>