package app.authentication.controller;

import app.authentication.dao.UserDao;
import app.authentication.model.UserModel;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDao = new UserDao();

        try {
            UserModel userModel = userDao.getUserModel(request.getParameter("login"), request.getParameter("password"));
            HttpSession session = request.getSession(true);
            session.setAttribute("user", userModel);
            if (userModel.getUserRole().equals("user")) {
                response.sendRedirect(request.getContextPath() + "/user/index.jsp");
            } else if (userModel.getUserRole().equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("msg", "An authentication error occurred. Please try again.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}