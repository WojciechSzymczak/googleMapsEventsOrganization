package app.authentication.model;

public class IpPermitModel {

    private int permitId;

    private String permitIp;

    public IpPermitModel(int permitId, String permitIp) {
        this.permitId = permitId;
        this.permitIp = permitIp;
    }

    public int getPermitId() {
        return permitId;
    }

    public void setPermitId(int permitId) {
        this.permitId = permitId;
    }

    public String getPermitIp() {
        return permitIp;
    }

    public void setPermitIp(String permitIp) {
        this.permitIp = permitIp;
    }

    @Override
    public String toString() {
        return this.permitId + " " + this.permitIp;
    }
}