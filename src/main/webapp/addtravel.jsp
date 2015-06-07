<%@page import="java.util.ArrayList"%>
<%@page import="travellog.Address"%>
<%@page import="travellog.DistanceService"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
    <title>Add Travel</title>
</head>

    <body>
        
        <table>
            <tr>
                <td style="vertical-align: top;">
                    <h1>Addresses</h1>
            
<%
    String travelYear = request.getParameter("travelYear");
    if (travelYear == null) {
        travelYear = "2015";
    }
    pageContext.setAttribute("travelYear", travelYear);
    
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("Address").addSort("addressName");
    List<Entity> addressEntities = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
    
    if (addressEntities.size() < 2) 
    {
        //alert("You must have at least 2 addresses to add a trip!")
        //ERROR: forward to address book to add addresses
    } 
    else
    {
        List<Address> addresses = new ArrayList();
        for (Entity address : addressEntities)
        {
            addresses.add(new Address(address));
        }
        
        for (Address address : addresses) 
        {
            pageContext.setAttribute("address_id", address.getId());
            pageContext.setAttribute("address_name", address.getName());
%>
            <p>${fn:escapeXml(address_name)}</p>
<%
        }
    }
%>
                </td>
                <td>&nbsp;&nbsp;</td>
                <td>
                <h1>Where did you go?</h1>

                <form action="/addtravel" method="post">
                    <table>
                    <tr><td>Event: </td><td><input type="text" name="eventName"/></td></tr>
                    <tr><td>Starting location </td><td><input type="text" name="location1"/></td><td><a href="">Add location</a></td></tr>
                    
                    <tr><td></td><td><input type="submit" value="Add Travel"/></td></tr>
                    </table>
                    <input type="hidden" name="travelYear" value="${fn:escapeXml(travelYear)}"/>
                </form>
                </td>
            </tr>
        </table>
    </body>
</html>
