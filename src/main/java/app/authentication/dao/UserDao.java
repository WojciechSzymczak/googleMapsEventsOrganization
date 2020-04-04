package app.authentication.dao;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import app.authentication.model.*;

public class UserDao extends HttpServlet {
 
    public OutData<UserModel, ResultCode> getUserModel(String name, String pass, String address) throws ServletException, IOException , Exception{

        OutData<UserModel, ResultCode> outData = CallProcedure.callUserAuthenticationProc(name, pass, address);

        if(outData.getResCode().getCode() == 0) {
            throw new Exception(outData.getResCode().getMessage());
        }

        if(outData.getResCode().getCode() == 2) {
            throw new Exception(outData.getResCode().getMessage());
        }

        if(outData.getResCode().getCode() == 3) {
            throw new Exception(outData.getResCode().getMessage());
        }

        if(outData.getResCode().getCode() == 4) {
            throw new Exception(outData.getResCode().getMessage());
        }

        if(!(outData.getResCode().getCode() == 1 || outData.getResCode().getCode() ==5)){
            throw new Exception("An error occurred. Please contact support.");
        }

        return outData;
    }

    public List<UserActionModel> getUserActions(int userId) throws ServletException, IOException , Exception{

        OutData<List<UserActionModel>, ResultCode> outData = CallProcedure.callGetUserActionsProc(userId);

        if(outData.getResCode().getCode() != 1) {
            throw new Exception("An error occurred. Please contact support.");
        }

        return outData.getResObj();
    }

    public void addUserAction(int userId, String actionName) throws Exception {

        ResultCode res = CallProcedure.addUserAction(userId, actionName);

        if(res.getCode() != 1) {
            throw new Exception("An error occurred. Please contact support.");
        }
    }

    public List<IpPermitModel> getUserIpPermits(int userId) throws Exception{

        OutData<List<IpPermitModel>, ResultCode> outData = CallProcedure.callGetUserIpPermitsProc(userId);

        if(outData.getResCode().getCode() != 1) {
            throw new Exception("An error occurred. Please contact support.");
        }

        return outData.getResObj();
    }

    public void addUserIpPermit(int userId, String ipPermit) throws Exception{

        ResultCode resultCode = CallProcedure.callAddUserIpPermitProc(userId, ipPermit);

        if(resultCode.getCode() != 1) {
            throw new Exception("An error occurred. Please contact support.");
        }
    }

    public void deleteUserIpPermit(int userId, int permitId) throws Exception{
        ResultCode resultCode = CallProcedure.callDeleteUserIpPermitProc(userId, permitId);

        if(resultCode.getCode() != 1) {
            throw new Exception("An error occurred. Please contact support.");
        }
    }

    public void changePassword(int userId, String password) throws Exception{
        ResultCode resultCode = CallProcedure.callChangeUserPasswordProc(userId, password);

        if(resultCode.getCode() == 0) {
            throw new Exception(resultCode.getMessage());
        }

        if(resultCode.getCode() == 2) {
            throw new Exception(resultCode.getMessage());
        }

        if(resultCode.getCode() != 1) {
            throw new Exception("An error occurred. Please contact support.");
        }
    }
}