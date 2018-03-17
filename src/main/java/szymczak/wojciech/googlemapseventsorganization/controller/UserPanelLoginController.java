package szymczak.wojciech.googlemapseventsorganization.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserPanelLoginController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.sendRedirect("/index.jsp");
        
    }    

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