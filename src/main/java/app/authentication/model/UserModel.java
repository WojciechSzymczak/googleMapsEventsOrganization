package app.authentication.model;

import java.math.BigInteger;

//TODO
public class UserModel {
    
    BigInteger userID;
    String userEmail;
    String userName;
    String userPass;
    String userFirstName;
    String userLastName;

    public BigInteger getUserID() {
        return userID;
    }

    public void setUserID(BigInteger userID) {
        this.userID = userID;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public String getUserFirstName() {
        return userFirstName;
    }

    public void setUserFirstName(String userFirstName) {
        this.userFirstName = userFirstName;
    }

    public String getUserLastName() {
        return userLastName;
    }

    public void setUserLastName(String userLastName) {
        this.userLastName = userLastName;
    }

    public UserModel() {}

    public UserModel(String userEmail, String userName, String userPass, String userFirstName, String userLastName) {
        this.userEmail = userEmail;
        this.userName = userName;
        this.userPass = userPass;
        this.userFirstName = userFirstName;
        this.userLastName = userLastName;
    }
    
    @Override
    public String toString() {
        return this.userEmail + " " + this.userName + " " + this.userPass + " " + this.userFirstName + " " + this.userLastName;
    }
}
