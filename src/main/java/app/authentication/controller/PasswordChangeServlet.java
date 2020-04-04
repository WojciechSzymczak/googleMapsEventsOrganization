package app.authentication.controller;

import app.authentication.dao.UserDao;
import app.authentication.model.UserModel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class PasswordChangeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }

        response.sendRedirect(request.getContextPath() + "/user/changePassword.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDao = new UserDao();
        UserModel userModel = (UserModel) request.getSession().getAttribute("user");

        try {
            userDao.changePassword(userModel.getUserId(), (String) request.getParameter("password2"));
            request.getSession().setAttribute("res", "Password successfully changed!");
        } catch (Exception e) {
            request.getSession().setAttribute("msg", e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/user/changePassword.jsp");
    }
}