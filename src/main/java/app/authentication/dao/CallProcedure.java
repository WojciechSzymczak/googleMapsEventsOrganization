package app.authentication.dao;

import app.authentication.model.OutData;
import app.authentication.model.ResultCode;
import app.authentication.model.UserModel;
import oracle.jdbc.driver.OracleDriver;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
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

            statement = conn.prepareCall("{call c##auth_user.USER_PACKAGE.authenticate_user(?, ?, ? ,?, ?, ?)}");
            statement.setString(1, userName);
            statement.setString(2, userPassword);
            statement.registerOutParameter(3, Types.INTEGER);
            statement.registerOutParameter(4, Types.VARCHAR);
            statement.registerOutParameter(5, Types.INTEGER);
            statement.registerOutParameter(6, Types.VARCHAR);
            statement.execute();

            userModel = new UserModel(statement.getInt(5), statement.getString(6), userName, userPassword);
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
}