package szymczak.wojciech.googlemapseventsorganization.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import szymczak.wojciech.googlemapseventsorganization.dao.UserDao;
import szymczak.wojciech.googlemapseventsorganization.model.UserModel;

public class UserRegisterController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
            RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
            dispatcher.forward(request, response);
            
    }    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
            UserDao tempUserDao = new UserDao();
            UserModel tempUserModel = new UserModel();
            
            tempUserModel.setUserName(request.getParameter("user_name"));
            tempUserModel.setUserEmail(request.getParameter("user_email"));
            tempUserModel.setUserPass(request.getParameter("user_pass"));
            
            String registerResultMessage = tempUserDao.registerUser(tempUserModel);
            request.setAttribute("registerResultMessage", registerResultMessage);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
            dispatcher.forward(request, response);
                        
        }
        
    }