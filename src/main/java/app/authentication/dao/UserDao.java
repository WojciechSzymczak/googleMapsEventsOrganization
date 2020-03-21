package app.authentication.dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import app.authentication.model.OutData;
import app.authentication.model.ResultCode;
import app.authentication.model.UserModel;

public class UserDao extends HttpServlet {
 
    public UserModel getUserModel(String name, String pass) throws ServletException, IOException , Exception{

        OutData<UserModel, ResultCode> outData = CallProcedure.callUserAuthenticationProc(name, pass);

        if(outData.getResCode().getCode() != 1) {
            throw new Exception("An error occurred. Please contact support.");
        }

        return outData.getResObj();
    }
}