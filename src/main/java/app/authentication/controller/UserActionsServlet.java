package app.authentication.controller;

import app.authentication.dao.UserDao;
import app.authentication.model.UserActionModel;
import app.authentication.model.UserModel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class UserActionsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDao = new UserDao();
        UserModel user = ((UserModel) request.getSession().getAttribute("user"));

        try {
            List<UserActionModel> userActions = userDao.getUserActions(user.getUserId());
            HttpSession session = request.getSession();
            session.setAttribute("actions", userActions);
            response.sendRedirect(request.getContextPath() + "/user/index.jsp");
        } catch (Exception e) {
            request.getSession().setAttribute("msg", "An error occurred. Please try again.");
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}