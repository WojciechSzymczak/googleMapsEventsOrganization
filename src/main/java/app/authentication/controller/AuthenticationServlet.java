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

//TODO
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDao = new UserDao();

        try {
//            UserModel userModel = userDao.getUserModel("nowak", "12345678");
//            HttpSession session = request.getSession();
//            session.setAttribute("name", userModel.getUserEmail());
        } catch (Exception e) {
            request.getSession().setAttribute("msg", "An authentication error occurred. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }    

    //TODO
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
                request.login(request.getParameter("username"), request.getParameter("password"));
                response.sendRedirect("/index.jsp");
            } catch(ServletException e) {
                response.sendRedirect("/error.jsp");
            }
    }
}