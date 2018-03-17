package szymczak.wojciech.googlemapseventsorganization.dao;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.sql.DataSource;
import szymczak.wojciech.googlemapseventsorganization.model.EventModel;
import szymczak.wojciech.googlemapseventsorganization.model.UserModel;
 
public class EventDao extends HttpServlet {
 
    public String addEvent(EventModel inputEventModel) throws ServletException, IOException {
        
        String eventAddResultMessage = "";
        
            try {
                InitialContext ctx = new InitialContext();
                Context envContext = (Context)ctx.lookup("java:/comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/MySqlDS");
                Connection con = ds.getConnection();
                if (!con.isClosed()) {

                        String query = "CALL add_event(?,?,?,?,?,?);";
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setString(1, inputEventModel.getEvent_name());
                        ps.setTimestamp(2, inputEventModel.getEvent_start_date());
                        ps.setDouble(3, inputEventModel.getEvent_longitude());
                        ps.setDouble(4, inputEventModel.getEvent_latitude());
                        //TODO make sure it is a proper way in dealing with BigInteger
                        ps.setObject(5, inputEventModel.getUser_id());
                        //
                        ps.setString(6, inputEventModel.getEvent_description());
                        ps.executeUpdate();
                        eventAddResultMessage = "Event was successfully added!";
                                               
                    }                
                
                    con.close();


            } catch(SQLException e) {
                System.out.println("SQLException: " + e.getMessage());
                eventAddResultMessage = "Failed to add an event." + e.getErrorCode();
            } catch(NamingException e) {
                System.out.println("NamingException: " + e.getMessage());
                eventAddResultMessage = "Failed to add an event.";
            } catch(Exception e) {
                System.out.println("Exception: " + e.getMessage());           
                eventAddResultMessage = "Failed to add an event.";
            }
            
            return eventAddResultMessage;
            
    }    

    public LinkedList <EventModel> getUserEvents(UserModel userModel) {
        
        LinkedList <EventModel> userEventsArray = new LinkedList <EventModel>(); 
        
        try {
                InitialContext ctx = new InitialContext();
                Context envContext = (Context)ctx.lookup("java:/comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/MySqlDS");
                Connection con = ds.getConnection();
                if (!con.isClosed()) {

                        String query = "SELECT * FROM events WHERE user_id=?";
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setObject(1, userModel.getUserID());
                        
                        ResultSet rs = ps.executeQuery();
                        
                        while (rs.next()) {
                            EventModel tempEventModel = new EventModel();
                            tempEventModel.setEvent_id(rs.getLong("event_id"));
                            tempEventModel.setEvent_name(rs.getString("event_name"));                            
                            Timestamp tempTimestamp = rs.getTimestamp("event_start_date");
                            tempEventModel.setEvent_start_date(tempTimestamp);
                            tempEventModel.setEvent_longitude(rs.getDouble("event_longitude"));
                            tempEventModel.setEvent_latitude(rs.getDouble("event_latitude"));
                            tempEventModel.setEvent_description(rs.getString("event_description"));
                            tempEventModel.setUser_id(BigInteger.valueOf(Long.parseLong(rs.getString("user_id"))));
                            
                            userEventsArray.add(tempEventModel);
                        }
                                               
                    }                
                
                    con.close();


            } catch(SQLException e) {
                System.out.println("SQLException: " + e.getMessage());
            } catch(NamingException e) {
                System.out.println("NamingException: " + e.getMessage());
            } catch(Exception e) {
                System.out.println("Exception: " + e.getMessage());           
            }
        
        
        return userEventsArray;
        
    }
}