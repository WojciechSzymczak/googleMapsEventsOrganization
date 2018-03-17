package szymczak.wojciech.googlemapseventsorganization.model;

import java.math.BigInteger;
import java.sql.Timestamp;

public class EventModel {

    public void setEvent_id(Long event_id) {
        this.event_id = event_id;
    }

    Long event_id;
    String event_name;
    Timestamp event_start_date;
    Double event_longitude;
    Double event_latitude;
    String event_description;    
    BigInteger user_id;
    
    public Long getEvent_id() {
        return event_id;
    }
    
    public String getEvent_name() {
        return event_name;
    }

    public void setEvent_name(String event_name) {
        this.event_name = event_name;
    }

    public Timestamp getEvent_start_date() {
        return event_start_date;
    }

    public void setEvent_start_date(Timestamp event_start_date) {
        this.event_start_date = event_start_date;
    }

    public Double getEvent_longitude() {
        return event_longitude;
    }

    public void setEvent_longitude(Double event_longitude) {
        this.event_longitude = event_longitude;
    }

    public Double getEvent_latitude() {
        return event_latitude;
    }

    public void setEvent_latitude(Double event_latitude) {
        this.event_latitude = event_latitude;
    }

    public String getEvent_description() {
        return event_description;
    }

    public void setEvent_description(String event_description) {
        this.event_description = event_description;
    }

    public BigInteger getUser_id() {
        return user_id;
    }

    public void setUser_id(BigInteger user_id) {
        this.user_id = user_id;
    }
    
    public EventModel(Long event_id, String event_name, String event_city, Timestamp event_start_date, Double event_longitude, Double event_latitude, 
            String event_description, BigInteger user_id) {
        this.event_id = event_id;
        this.event_name = event_name;
        this.event_start_date = event_start_date;
        this.event_longitude = event_longitude;
        this.event_latitude = event_latitude;
        this.event_description = event_description;
        this.user_id = user_id;
    }
    
    public EventModel() {
        this.event_id = null;
        this.event_name = null;
        this.event_start_date = null;
        this.event_longitude = null;
        this.event_latitude = null;
        this.event_description = null;
        this.user_id = null;
    }
    
    @Override
    public String toString() {
        
        return this.event_id + " " + this.event_name + " " + this.event_start_date + " " + this.event_longitude + " " + 
                this.event_latitude + " " + this.event_description + " " + this.user_id;
    }
    
}
