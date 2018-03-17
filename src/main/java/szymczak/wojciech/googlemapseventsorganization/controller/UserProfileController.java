package szymczak.wojciech.googlemapseventsorganization.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import szymczak.wojciech.googlemapseventsorganization.dao.UserDao;
import szymczak.wojciech.googlemapseventsorganization.model.UserModel;

public class UserProfileController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (request.getUserPrincipal() != null) {
            
            String userName = request.getUserPrincipal().getName();
            UserDao tempUserDao = new UserDao();
            UserModel tempUserModel = tempUserDao.createUserModel(userName);
            
            request.setAttribute("user_first_name", tempUserModel.getUserFirstName());
            request.setAttribute("user_last_name", tempUserModel.getUserLastName());

            RequestDispatcher dispatcher = request.getRequestDispatcher("/user/profile.jsp");
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
        }
        
    }    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (request.getUserPrincipal() != null) {
            
            String userName = request.getRemoteUser();
            UserDao tempUserDao = new UserDao();
            UserModel tempUserModel = tempUserDao.createUserModel(userName);
            
            tempUserModel.setUserFirstName(request.getParameter("user_first_name"));            
            tempUserModel.setUserLastName(request.getParameter("user_last_name"));
            request.setAttribute("user_first_name", tempUserModel.getUserFirstName());            
            request.setAttribute("user_last_name", tempUserModel.getUserLastName());
            
            String updateResultMessage = tempUserDao.updateUserProfile(tempUserModel);
            if (updateResultMessage.equals("succes")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/user/profile.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("updateResultMessage", updateResultMessage);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/user/profile.jsp");
                dispatcher.forward(request, response);
            }
            
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
        } 
        
    }

}