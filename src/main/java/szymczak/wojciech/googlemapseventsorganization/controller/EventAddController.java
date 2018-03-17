package szymczak.wojciech.googlemapseventsorganization.controller;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import szymczak.wojciech.googlemapseventsorganization.dao.EventDao;
import szymczak.wojciech.googlemapseventsorganization.dao.UserDao;
import szymczak.wojciech.googlemapseventsorganization.model.EventModel;
import szymczak.wojciech.googlemapseventsorganization.model.UserModel;

public class EventAddController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (request.getUserPrincipal() != null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/user/addEvent.jsp");
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

            try {
                
                if (request.getParameter("eventName").equals("")) {
                    throw new Exception("Event name missing! Please provide correct information.");
                }
                else if ((request.getParameter("beginningDate").equals(""))) {                    
                    throw new Exception("Beginning date missing! Please provide correct information.");
                }
                else if ((request.getParameter("beginningTime").equals(""))) {                    
                    throw new Exception("Beginning time missing! Please provide correct information.");
                }
                else if (request.getParameter("longitude").equals("")) {
                    throw new Exception("Longitude parameter missing! Please provide correct information.");
                }
                else if ((request.getParameter("latitude").equals(""))) {                    
                    throw new Exception("Latitude parameter missing! Please provide correct information.");
                }
                else if ((request.getParameter("eventDescription").equals(""))) {                    
                    throw new Exception("Description missing! Please provide correct information.");
                }          
                
                String [] stringBeginningDateTab = request.getParameter("beginningDate").split("-");
                Integer [] intBeginningDateTab = new Integer[3];
                intBeginningDateTab[0] = Integer.parseInt(stringBeginningDateTab[0]);
                intBeginningDateTab[1] = Integer.parseInt(stringBeginningDateTab[1]);
                intBeginningDateTab[2] = Integer.parseInt(stringBeginningDateTab[2]);
                
                String [] stringBeginningTimeTab = request.getParameter("beginningTime").split(":");
                Integer [] intBeginningTimeTab = new Integer[2];
                intBeginningTimeTab[0] = Integer.parseInt(stringBeginningTimeTab[0]);
                intBeginningTimeTab[1] = Integer.parseInt(stringBeginningTimeTab[1]);
                
                Timestamp tempTimestamp = new Timestamp(intBeginningDateTab[0]-1900,intBeginningDateTab[1]-1,intBeginningDateTab[2],intBeginningTimeTab[0],intBeginningTimeTab[1],0,0);
                
                EventModel eventModel =  new EventModel();
                eventModel.setEvent_name(request.getParameter("eventName")); 
                eventModel.setEvent_start_date(tempTimestamp);
                
                Double tempLongitude = Double.parseDouble(request.getParameter("longitude"));                
                Double tempLatitude = Double.parseDouble(request.getParameter("latitude"));
                
                eventModel.setEvent_longitude(tempLongitude);
                eventModel.setEvent_latitude(tempLatitude);
                
                String Username = request.getRemoteUser();
                UserDao userDao = new UserDao();
                UserModel userModel = userDao.createUserModel(Username);
                eventModel.setUser_id(userModel.getUserID());

                eventModel.setEvent_description(request.getParameter("eventDescription"));
                
                EventDao eventDao = new EventDao();
                String eventAddResultMessage = eventDao.addEvent(eventModel);
                
                request.setAttribute("eventAddResultMessage", eventAddResultMessage);
                
                
            } catch(Exception e) {
                request.setAttribute("eventAddResultMessage", e.getMessage());
                
            } finally {
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("/user/addEvent.jsp");
                dispatcher.forward(request, response);
                
            }
            
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
        } 
        
    }
    
}