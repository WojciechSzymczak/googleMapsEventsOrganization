package app.authentication.model;

public class UserModel {
    
    int userId;

    String userEmail;

    String userName;

    String userPass;

    String userRole;

    public UserModel() {}

    public UserModel(int userId, String userEmail, String userName, String userPass, String userRole) {
        this.userId = userId;
        this.userEmail = userEmail;
        this.userName = userName;
        this.userPass = userPass;
        this.userRole = userRole;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }
    
    @Override
    public String toString() {
        return this.userEmail + " " + this.userName + " " + this.userPass;
    }
}