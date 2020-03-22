package app.authentication.model;

import java.time.LocalDateTime;

public class UserActionModel {

    private int actionId;

    private LocalDateTime date;

    private String action;

    private int userId;

    public UserActionModel() {}

    public UserActionModel(int actionId, LocalDateTime date, String action, int userId) {
        this.actionId = actionId;
        this.date = date;
        this.action = action;
        this.userId = userId;
    }

    public int getActionId() {
        return actionId;
    }

    public void setActionId(int actionId) {
        this.actionId = actionId;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public String getDateInPrintableFormat() {
        return date.toLocalDate() + " " + date.toLocalTime();
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return this.userId + " " + this.date + " " + this.action;
    }
}