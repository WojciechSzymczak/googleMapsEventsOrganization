package app.authentication.controller;

import app.authentication.dao.UserDao;
import app.authentication.model.UserModel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

public class UserLogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        UserModel userModel = (UserModel) request.getSession().getAttribute("user");

        try {
            userDao.addUserAction(userModel.getUserId(), "Logging off.");
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getSession().invalidate();
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}