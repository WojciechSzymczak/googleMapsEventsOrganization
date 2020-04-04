package app.authentication.controller;

import app.authentication.dao.UserDao;
import app.authentication.model.OutData;
import app.authentication.model.ResultCode;
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
            OutData<UserModel, ResultCode> outData = userDao.getUserModel(request.getParameter("login"), request.getParameter("password"), request.getRemoteAddr());
            HttpSession session = request.getSession(true);
            session.setAttribute("user", outData.getResObj());
            if (outData.getResObj().getUserRole().equals("user")) {
                if (outData.getResCode().getCode() == 5) {
                    session.setAttribute("msg", outData.getResCode().getMessage());
                    response.sendRedirect(request.getContextPath() + "/user/changePassword.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/actions");
                }
            } else if (outData.getResObj().getUserRole().equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("msg", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}