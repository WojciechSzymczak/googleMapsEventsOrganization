package app.authentication.dao;

import app.authentication.model.*;

import oracle.jdbc.driver.OracleDriver;

import java.io.FileInputStream;
import java.io.IOException;

import java.sql.*;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

class CallProcedure {

    private static Connection conn;

    static OutData<UserModel, ResultCode> callUserAuthenticationProc(String userName, String userPassword) {
        UserModel userModel = null;
        ResultCode resCode = null;
        CallableStatement statement = null;
        ResultSet rs = null;

        try {
            if (conn == null || conn.isClosed()) {
                initConnection();
            }

            statement = conn.prepareCall("{call c##auth_user.USER_PACKAGE.authenticate_user(?, ?, ? ,?, ?, ?, ?)}");
            statement.setString(1, userName);
            statement.setString(2, userPassword);
            statement.registerOutParameter(3, Types.INTEGER);
            statement.registerOutParameter(4, Types.VARCHAR);
            statement.registerOutParameter(5, Types.INTEGER);
            statement.registerOutParameter(6, Types.VARCHAR);
            statement.registerOutParameter(7, Types.VARCHAR);
            statement.execute();

            userModel = new UserModel(statement.getInt(5), statement.getString(6), userName, userPassword, statement.getString(7));
            resCode = new ResultCode(statement.getInt(3), statement.getString(4));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections(rs);
            closeConnections(statement);
            closeConnections(conn);
        }

        return new OutData<>(userModel, resCode);
    }

    private static void closeConnections(AutoCloseable autoCloseable) {
        try {
            if (autoCloseable != null) {
                autoCloseable.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void initConnection() {
        Properties prop = new Properties();
        try {
            DriverManager.registerDriver (new OracleDriver());
            prop.load(new FileInputStream(System.getProperty("properties_path")));
            conn = DriverManager.getConnection(prop.getProperty("db.url"), prop.getProperty("db.user"), prop.getProperty("db.password"));
        } catch (SQLException | IOException e) {
            conn = null;
            e.printStackTrace();
        }
    }

    static OutData<List <UserActionModel>, ResultCode> callGetUserActionsProc(int userId) {
        UserActionModel userActionModel = null;
        ResultCode resCode = null;
        CallableStatement statement = null;
        ResultSet rs = null;
        List<UserActionModel> userActions = new ArrayList<>();

        try {
            if (conn == null || conn.isClosed()) {
                initConnection();
            }

            statement = conn.prepareCall("{call c##auth_user.USER_PACKAGE.get_user_actions(?, ?)}");
            statement.setInt(1, userId);
            statement.registerOutParameter(2, Types.REF_CURSOR);
            statement.executeQuery();

            rs = (ResultSet) statement.getObject(2);

            while (rs.next()) {
                userActions.add(
                    new UserActionModel(rs.getInt("action_id"),
                    LocalDateTime.ofInstant(Instant.ofEpochMilli(rs.getDate("action_date").getTime()), ZoneOffset.UTC).plus(60, ChronoUnit.MINUTES),
                    rs.getString("action_name"),
                    rs.getInt("user_id")));
            }

            resCode = new ResultCode(1, "Successfully fetched user actions.");
        } catch (SQLException e) {
            resCode = new ResultCode(0, "An error occurred. Please contact support.");
            e.printStackTrace();
        } finally {
            closeConnections(rs);
            closeConnections(statement);
            closeConnections(conn);
        }

        return new OutData<>(userActions, resCode);
    }

    static ResultCode addUserAction(int userId, String actionName) {
        ResultCode resCode = null;
        CallableStatement statement = null;
        ResultSet rs = null;

        try {
            if (conn == null || conn.isClosed()) {
                initConnection();
            }

            statement = conn.prepareCall("{call c##auth_user.USER_PACKAGE.add_user_action(?, ?)}");
            statement.setInt(1, userId);
            statement.setString(2, actionName);
            rs = statement.executeQuery();

            resCode = new ResultCode(1, "Successfully added user action.");
        } catch (SQLException e) {
            resCode = new ResultCode(0, "An error occurred. Please contact support.");
            e.printStackTrace();
        } finally {
            closeConnections(rs);
            closeConnections(statement);
            closeConnections(conn);
        }

        return resCode;
    }

    public static OutData<List<IpPermitModel>, ResultCode> callGetUserIpPermitsProc(int userId) {
        List<IpPermitModel> ipPermitModelList = new ArrayList<>();
        ResultCode resCode = null;
        CallableStatement statement = null;
        ResultSet rs = null;

        try {
            if (conn == null || conn.isClosed()) {
                initConnection();
            }

            statement = conn.prepareCall("{call c##auth_user.USER_PACKAGE.get_user_ip_permits(?, ?)}");
            statement.setInt(1, userId);
            statement.registerOutParameter(2, Types.REF_CURSOR);
            statement.executeQuery();

            rs = (ResultSet) statement.getObject(2);

            while (rs.next()) {
                ipPermitModelList.add( new IpPermitModel(rs.getInt("perm_id"), rs.getString("perm_ip")));
            }

            resCode = new ResultCode(1, "Successfully fetched user's IP permissions.");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections(rs);
            closeConnections(statement);
            closeConnections(conn);
        }

        return new OutData<>(ipPermitModelList, resCode);
    }

    public static ResultCode callAddUserIpPermitProc(int userId, String ipPermit) {
        ResultCode resCode = null;
        CallableStatement statement = null;
        ResultSet rs = null;

        try {
            if (conn == null || conn.isClosed()) {
                initConnection();
            }

            statement = conn.prepareCall("{call c##auth_user.USER_PACKAGE.add_user_ip_permit(?, ?, ?, ?)}");
            statement.setInt(1, userId);
            statement.setString(2, ipPermit);
            statement.registerOutParameter(3, Types.NUMERIC);
            statement.registerOutParameter(4, Types.VARCHAR);
            statement.executeQuery();

            resCode = new ResultCode(statement.getInt(3), statement.getString(4));
        } catch (SQLException e) {
            resCode = new ResultCode(0, "An error occurred. Please contact support.");
            e.printStackTrace();
        } finally {
            closeConnections(rs);
            closeConnections(statement);
            closeConnections(conn);
        }

        return resCode;
    }

    public static ResultCode callDeleteUserIpPermitProc(int userId, int permitId) {
        ResultCode resCode = null;
        CallableStatement statement = null;
        ResultSet rs = null;

        try {
            if (conn == null || conn.isClosed()) {
                initConnection();
            }

            statement = conn.prepareCall("{call c##auth_user.USER_PACKAGE.delete_user_ip_permit(?, ?, ?, ?)}");
            statement.setInt(1, userId);
            statement.setInt(2, permitId);
            statement.registerOutParameter(3, Types.NUMERIC);
            statement.registerOutParameter(4, Types.VARCHAR);
            statement.executeQuery();

            resCode = new ResultCode(statement.getInt(3), statement.getString(4));
        } catch (SQLException e) {
            resCode = new ResultCode(0, "An error occurred. Please contact support.");
            e.printStackTrace();
        } finally {
            closeConnections(rs);
            closeConnections(statement);
            closeConnections(conn);
        }

        return resCode;
    }
}