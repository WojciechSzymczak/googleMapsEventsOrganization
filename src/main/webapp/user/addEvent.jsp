<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>      
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="/images/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events - add event page</title>   
        <link href="/css/bootstrap.min.css" rel="stylesheet">        
        <link href="/css/mycss/style1.css" rel="stylesheet">
    </head>
    
    <body>
                
        <%@ include file="/WEB-INF/jspf/userPanel.jspf" %>
        <%@ include file="/WEB-INF/jspf/searchBar.jspf" %>               
        <%@ include file="/WEB-INF/jspf/menu.jspf" %>
        
        <div class="container">
            <div class="row">
                <h2>To add an event, simply fill the form below:</h2><hr>
            </div>            
        </div>
        
        <div class="container">
            <div class="row">                
                ${requestScope["eventAddResultMessage"]}<br><br>
            </div>            
        </div>
                
        <div class="container">
            <div class="row">        
                <form action="EventAddController" method="post">
                    <fieldset>
                        
                        <div class="form-group">
                          <label for="eventName">Event name</label>
                          <input type="text" class="form-control input-md" name="eventName" id="eventName" aria-describedby="eventNameHelp" placeholder="Enter event name" required="">
                          <small id="eventNameHelp" class="form-text text-muted">This is the name of your event visible to other users.</small>
                        </div>
                                                                       
                        <div class="form-group">                                
                          <label for="beginningTime">Beginning time</label>
                            <span class="input-group-addon">                                        
                                <input type="date" id="beginningDate" name="beginningDate">                                
                                <input type="time" id="beginningTime" name="beginningTime">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                          <small id="eventTimeHelp" class="form-text text-muted">Specify when your event is going to start.</small>
                        </div>                        
                        
                        <div class="form-group">
                            <label for="eventDescription">Tell something about your event!</label>
                            <textarea class="form-control" id="eventDescription" name="eventDescription" rows="3" placeholder="Enter event description" required=""></textarea>
                            <small id="eventDescriptionHelp" class="form-text text-muted">Short description of the event.</small>
                        </div>
                        
                        <div class="form-group">
                            
                            <div class="col-xs-6 col-md-6 col-lg-6 form-group">
                                <label for="longitude">Longitude</label> 
                                <input class="form-control" id="longitude" name="longitude" placeholder="" type="text" readonly/>
                            </div>
                            
                            <div class="col-xs-6 col-md-6 col-lg-6 form-group">
                                <label for="latitude">Latitude</label> 
                                <input class="form-control" id="latitude" name="latitude" placeholder="" type="text" readonly/>
                            </div>
                            
                        </div>
                        
                        <div class="container">
                            <div class="row">                             
                            </div>
                        </div>
                        
                        <hr>
                        <div class="form-group">
                          <label>Put the location of your event on the map:</label>
                        </div>
                        
                        <div id="map_container">
                            <div id="map"></div>
                        </div>
                        
                        <div class="form-group">                                
                            <button type="submit" class="btn btn-primary btn-lg pull-right">Add my event!</button>                               
                        </div>                        
                                                
                    </fieldset>
                </form>                
            </div>            
        </div>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>');</script>
        <script src="/js/bootstrap.min.js"></script>        
        <script src="https://maps.googleapis.com/maps/api/js?key=<%@include file = "/WEB-INF/public_keys/googleMapsApiKey.txt" %>&callback=initMap" defer></script>        
        <script type="text/javascript" defer>
            var map;
                function initMap() {
                    
                    map = new google.maps.Map(document.getElementById('map'), {
                      center: {lat: 51.7592485, lng: 19.4559833},
                      zoom: 13
                    });
                    
                    var myMarker = new google.maps.Marker({
                        position: new google.maps.LatLng(51.7592485, 19.4559833),
                        draggable: true
                    });
                    
                    google.maps.event.addListener(myMarker, 'dragend', function(evt){
                        document.getElementById("longitude").value = evt.latLng.lng();
                        document.getElementById("latitude").value = evt.latLng.lat();
                    });
                    
                    map.setCenter(myMarker.position);
                    myMarker.setMap(map);
                }                                    
        </script>        
    </body>    
</html>