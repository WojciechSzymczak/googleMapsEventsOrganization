package app.authentication.model;

public class OutData <T, ResultCode>{

    private T resObj;

    private ResultCode resCode;

    public OutData(T resObj, ResultCode resCode) {
        this.resObj = resObj;
        this.resCode = resCode;
    }

    public T getResObj() {
        return resObj;
    }

    public void setResObj(T resObj) {
        this.resObj = resObj;
    }

    public ResultCode getResCode() {
        return resCode;
    }

    public void setResCode(ResultCode resCode) {
        this.resCode = resCode;
    }
}