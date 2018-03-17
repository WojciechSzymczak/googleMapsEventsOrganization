package szymczak.wojciech.googlemapseventsorganization.dao;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.sql.DataSource;
import szymczak.wojciech.googlemapseventsorganization.model.UserModel;
 
public class UserDao extends HttpServlet {
 
    public UserModel createUserModel(String username) throws ServletException, IOException {
        
        UserModel tempUserModel = new UserModel();
        
            try {
                InitialContext ctx = new InitialContext();
                Context envContext = (Context)ctx.lookup("java:/comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/MySqlDS");
                Connection con = ds.getConnection();
                if (!con.isClosed()) {

                        String query = "SELECT * FROM events.users where user_name=?";
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setString(1, username);
                        ResultSet rs = ps.executeQuery();
                        rs.next();
                        
                        //TODO find better way to deal with BigInteger
                        BigInteger tempUserID;
                        tempUserID = BigInteger.valueOf(Long.parseLong(rs.getString("user_id")));                        
                        //
                        
                        tempUserModel.setUserID(tempUserID);
                        tempUserModel.setUserName(username);
                        tempUserModel.setUserFirstName(rs.getString("user_first_name"));
                        tempUserModel.setUserLastName(rs.getString("user_last_name"));
                    }                
                
                    con.close();


            } catch(SQLException e) {
                System.out.println("SQLException: " + e.getMessage());
            } catch(NamingException e) {
                System.out.println("NamingException: " + e.getMessage());
            } catch (NumberFormatException e) {
                System.out.println("NumberFormatException: " + e.getMessage());                
            } catch(Exception e) {
                System.out.println("Exception: " + e.getMessage());
            }
            
            return tempUserModel;
            
    }
    
    public String updateUserProfile(UserModel alteredUserModel) throws ServletException, IOException{
        
        String updateResultMessage = "";
        
        try {
                InitialContext ctx = new InitialContext();
                Context envContext = (Context)ctx.lookup("java:/comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/MySqlDS");
                Connection con = ds.getConnection();
                if (!con.isClosed()) {
                    
                        String query = "UPDATE events.users SET user_first_name=?, user_last_name=? where user_name=?";
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setString(1, alteredUserModel.getUserFirstName());
                        ps.setString(2, alteredUserModel.getUserLastName());                        
                        ps.setString(3, alteredUserModel.getUserName());
                        ps.executeUpdate();
                        updateResultMessage="Update succes.";
                    }
                
                    con.close();
                
            } catch(SQLException e) {
                System.out.println("SQLException: " + e.getMessage());                
                updateResultMessage="Update failed.";
            } catch(NamingException e) {
                System.out.println("NamingException: " + e.getMessage());                                
                updateResultMessage="Update failed.";
            } catch(Exception e) {
                System.out.println("Exception: " + e.getMessage());                                
                updateResultMessage="Update failed.";
            }
        
        
        return updateResultMessage;
    }
    
    public String registerUser(UserModel tempUserModel) throws ServletException, IOException {        
        
        String registerResultMessage = "";
        
            try {
                InitialContext ctx = new InitialContext();
                Context envContext = (Context)ctx.lookup("java:/comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/MySqlDS");
                Connection con = ds.getConnection();
                if (!con.isClosed()) {

                        String query = "INSERT INTO events.users (user_name, user_email, user_pass) VALUES (?, ?, ?);";
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setString(1, tempUserModel.getUserName());
                        ps.setString(2, tempUserModel.getUserEmail());
                        ps.setString(3, tempUserModel.getUserPass());
                        ps.executeUpdate();
                        registerResultMessage = "Registration succes.";
                    }                
                
                    con.close();


            } catch(SQLException e) {
                System.out.println("SQLException: " + e.getMessage());
                if (e.getErrorCode() == 1062) {
                    registerResultMessage = "Registration failed. A Username or Email could be already taken.";
                } else {                    
                    registerResultMessage = "Registration failed.";
                }
            } catch(NamingException e) {
                System.out.println("NamingException: " + e.getMessage());                
                registerResultMessage = "Registration failed.";
            } catch(Exception e) {
                System.out.println("Exception: " + e.getMessage());                
                registerResultMessage = "Registration failed.";
            }
            
            return registerResultMessage;
            
    }
}