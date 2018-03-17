<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>      
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="/../images/favicon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events - event manager</title>   
        <link href="/../css/bootstrap.min.css" rel="stylesheet">        
        <link href="/../css/mycss/style1.css" rel="stylesheet">
    </head>
    
    <body>                
        <%@ include file="/WEB-INF/jspf/userPanel.jspf" %>
        <%@ include file="/WEB-INF/jspf/searchBar.jspf" %>               
        <%@ include file="/WEB-INF/jspf/menu.jspf" %>
        
        <div class="container">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">

                    <div class="panel panel-default panel-table">
                      <div class="panel-heading">
                        <div class="row">
                          <div class="col col-xs-6">
                            <h3 class="panel-title">My events</h3>
                          </div>
                          <div class="col col-xs-6 text-right">
                              <a href="EventAddController">
                                <button type="button" class="btn btn-sm btn-primary btn-create">Create event!</button>
                              </a>
                          </div>
                        </div>
                      </div>
                      <div class="panel-body">
                        <table class="table table-striped table-bordered table-list">
                          <thead>
                            <tr>
                                <th><em class="fa fa-cog"></em></th>
                                <th class="hidden-xs">ID</th>
                                <th>Name</th>
                                <th>Start Date</th>
                                <th>Longitude</th>
                                <th>Latitude</th>
                                <th>Description</th>
                            </tr> 
                          </thead>
                          <tbody> 
                              
                                    <%
                                        //TODO find a way to eliminate scriptlets
                                        String json = request.getAttribute("myJson").toString();
                                        JSONTokener jsonTokener = new JSONTokener(json);
                                        JSONObject object = (JSONObject) jsonTokener.nextValue();
                                        for (int i=0; i< object.length(); i++) {
                                            
                                            JSONArray jsonArray = object.getJSONArray("event_" + i);
                                    %>
                                            <tr>
                                                <td align="center">
                                                  <a class="btn btn-default"><em class="fa fa-pencil"></em></a>
                                                  <a class="btn btn-danger"><em class="fa fa-trash"></em></a>
                                                </td>
                                                <td class="hidden-xs"> <% out.write(jsonArray.getJSONObject(0).get("eventID").toString()); %> </td>
                                                <td> <% out.write(jsonArray.getJSONObject(0).get("eventName").toString()); %> </td>
                                                <td> <% out.write(jsonArray.getJSONObject(0).get("eventStartDate").toString()); %> </td>
                                                <td> <% out.write(jsonArray.getJSONObject(0).get("eventLongitude").toString()); %> </td>
                                                <td> <% out.write(jsonArray.getJSONObject(0).get("eventLatitude").toString()); %> </td>
                                                <td> <% out.write(jsonArray.getJSONObject(0).get("eventDescription").toString()); %> </td>
                                            </tr>
                                    <%   
                                        }
                                    %>
                                    
                          </tbody>
                          
                        </table>

                      </div>
                      <div class="panel-footer">
                        <div class="row">
                          <div class="col col-xs-4">Page 1 of 5
                          </div>
                          <div class="col col-xs-8">
                            <ul class="pagination hidden-xs pull-right">
                              <li><a href="#">1</a></li>
                              <li><a href="#">2</a></li>
                              <li><a href="#">3</a></li>
                              <li><a href="#">4</a></li>
                              <li><a href="#">5</a></li>
                            </ul>
                            <ul class="pagination visible-xs pull-right">
                                <li><a href="#">«</a></li>
                                <li><a href="#">»</a></li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                </div>
            </div>
        </div>
                          
        <%@ include file="/WEB-INF/jspf/footer.jspf" %> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>');</script>
        <script src="/js/bootstrap.min.js"></script>
    </body>
    
</html>
