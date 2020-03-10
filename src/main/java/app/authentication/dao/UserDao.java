package app.authentication.dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import app.authentication.model.UserModel;

//TODO
public class UserDao extends HttpServlet {
 
    public UserModel createUserModel(String username) throws ServletException, IOException {

        UserModel tempUserModel = new UserModel();
//            try {
//                InitialContext ctx = new InitialContext();
//                Context envContext = (Context)ctx.lookup("java:/comp/env");
//                DataSource ds = (DataSource) envContext.lookup("jdbc/MySqlDS");
//                Connection con = ds.getConnection();
//                if (!con.isClosed()) {
//
//                        String query = "SELECT * FROM events.users where user_name=?";
//                        PreparedStatement ps = con.prepareStatement(query);
//                        ps.setString(1, username);
//                        ResultSet rs = ps.executeQuery();
//                        rs.next();
//
//                        //TODO find better way to deal with BigInteger
//                        BigInteger tempUserID;
//                        tempUserID = BigInteger.valueOf(Long.parseLong(rs.getString("user_id")));
//                        //
//
//                        tempUserModel.setUserID(tempUserID);
//                        tempUserModel.setUserName(username);
//                        tempUserModel.setUserFirstName(rs.getString("user_first_name"));
//                        tempUserModel.setUserLastName(rs.getString("user_last_name"));
//                    }
//
//                    con.close();
//
//
//            } catch(SQLException e) {
//                System.out.println("SQLException: " + e.getMessage());
//            } catch(NamingException e) {
//                System.out.println("NamingException: " + e.getMessage());
//            } catch (NumberFormatException e) {
//                System.out.println("NumberFormatException: " + e.getMessage());
//            } catch(Exception e) {
//                System.out.println("Exception: " + e.getMessage());
//            }
            
            return tempUserModel;
    }
}