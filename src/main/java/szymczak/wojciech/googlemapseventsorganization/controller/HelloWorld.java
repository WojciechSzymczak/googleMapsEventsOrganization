package szymczak.wojciech.googlemapseventsorganization.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
 
public class HelloWorld extends HttpServlet {
 
    // TODO:  Deal with SSL connection configuration
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            
        StringBuilder tekst = new StringBuilder();
        
        try {
            InitialContext ctx = new InitialContext();
            Context envContext = (Context)ctx.lookup("java:/comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/MySqlDS");
            Connection con = ds.getConnection();
            if (!con.isClosed()) {
                    response.setContentType("text/html");
                    response.setCharacterEncoding("UTF-8");
                    tekst.append("<br><br><html><head></head><body><table style=\"border: 2px solid black;\">"
                            + "<tr><th style=\"border: 2px solid black;\">E-mail</th></tr>");
  
                    String query = "SELECT * FROM events.users LIMIT 100;";
                    PreparedStatement preparedStatement = con.prepareStatement(query);
                    ResultSet rs = preparedStatement.executeQuery();
                    
                    while (rs.next()) {
                        tekst.append("<tr><td style=\"border: 2px solid black;\">").append(rs.getString("email")).append("</td></tr>");
                    }

                    tekst.append("</table></body></html>");
                }
        
        con.close();
        
        } catch(SQLException e) {
            System.out.println("SQLException: " + e.getMessage());
        } catch(NamingException e) {
            System.out.println("NamingException: " + e.getMessage());
        } catch(Exception e) {
            System.out.println("Exception: " + e.getMessage());
        }
            
        PrintWriter out = response.getWriter();
        out.print("Hello World servlet!<br><br>");
        out.print("Przykładowe e-maile z bazy danych:<br><br>");
        out.print(tekst.toString());
    }
}