package app.authentication.controller;

import app.authentication.dao.UserDao;
import app.authentication.model.IpPermitModel;
import app.authentication.model.UserModel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class UserIpPermitsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDao = new UserDao();
        UserModel userModel = (UserModel) request.getSession().getAttribute("user");
        List<IpPermitModel> ipPermitModelList = new ArrayList<>();

        try {
            ipPermitModelList = userDao.getUserIpPermits(userModel.getUserId());
        } catch (Exception e) {
            request.getSession().setAttribute("msg", e.getMessage());
        }

        request.getSession().setAttribute("permits", ipPermitModelList);
        response.sendRedirect(request.getContextPath() + "/user/userIpPermits.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDao = new UserDao();
        UserModel userModel = (UserModel) request.getSession().getAttribute("user");
        String taskName = request.getParameter("task_name");
        List<IpPermitModel> ipPermitModelList = new ArrayList<>();

        try {
            if ("add_ip_permit".equals(taskName) && request.getParameter("ip_address") != null && !request.getParameter("ip_address").trim().equals("")) {
                userDao.addUserIpPermit(userModel.getUserId(), request.getParameter("ip_address"));
            } else if ("delete_ip_permit".equals(taskName)) {
                userDao.deleteUserIpPermit(userModel.getUserId(), request.getParameter("permit_id"));
            }
            ipPermitModelList = userDao.getUserIpPermits(userModel.getUserId());
        } catch (Exception e) {
            request.getSession().setAttribute("msg", e.getMessage());
        }

        request.getSession().setAttribute("permits", ipPermitModelList);
        response.sendRedirect(request.getContextPath() + "/user/userIpPermits.jsp");
    }
}