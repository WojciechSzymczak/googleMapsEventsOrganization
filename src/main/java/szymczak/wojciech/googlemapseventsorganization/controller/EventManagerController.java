package szymczak.wojciech.googlemapseventsorganization.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import szymczak.wojciech.googlemapseventsorganization.dao.EventDao;
import szymczak.wojciech.googlemapseventsorganization.dao.UserDao;
import szymczak.wojciech.googlemapseventsorganization.model.EventModel;
import szymczak.wojciech.googlemapseventsorganization.model.UserModel;

public class EventManagerController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (request.getUserPrincipal() != null) {            

            String username = request.getRemoteUser();
            
            UserDao userDao = new UserDao();            
            UserModel userModel = userDao.createUserModel(username);
            
            EventDao eventDao = new EventDao();
            LinkedList <EventModel> userEventsArray = eventDao.getUserEvents(userModel);

            JSONObject jsonObject = new JSONObject();
                
            for(int i=0;i<userEventsArray.size();i++) {
                
                LinkedHashMap tempLinkedHashMap = new LinkedHashMap();
                tempLinkedHashMap.put("eventID",userEventsArray.get(i).getEvent_id().toString());
                tempLinkedHashMap.put("eventName",userEventsArray.get(i).getEvent_name());
                tempLinkedHashMap.put("eventStartDate",userEventsArray.get(i).getEvent_start_date().toString());
                tempLinkedHashMap.put("eventLongitude",userEventsArray.get(i).getEvent_longitude().toString());
                tempLinkedHashMap.put("eventLatitude",userEventsArray.get(i).getEvent_latitude().toString());
                tempLinkedHashMap.put("eventDescription",userEventsArray.get(i).getEvent_description());
                tempLinkedHashMap.put("userID",userEventsArray.get(i).getUser_id().toString());
                        
                JSONArray tempJSONArray = new JSONArray();
                tempJSONArray.put(tempLinkedHashMap);
                jsonObject.put("event_" + i, tempJSONArray);
                
            }
            
            request.setAttribute("myJson", jsonObject);        
        
            RequestDispatcher dispatcher = request.getRequestDispatcher("/user/eventManager.jsp");
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
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/user/eventManager.jsp");
            dispatcher.forward(request, response);
            
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
        } 
        
    }
    
}