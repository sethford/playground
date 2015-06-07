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
    <title>Travel Log</title>
</head>

    <body>
        <h1>Travel Log</h1>
        
    <a href="addtravel.jsp?travelYear=2014">Add Travel for 2014</a><br/>
    <a href="addressbook.jsp">Address Book</a>
    
    <br/><br/>
<%
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("Address").addSort("addressName");
    List<Entity> addressEntities = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());

    List<Address> addresses = new ArrayList();
    for (Entity address : addressEntities)
    {
        addresses.add(new Address(address));
    }

    for (int i = 0; i < addresses.size(); i++)
    {
        if (i == 0)
            continue;

        Address address1 = addresses.get(i-1);
        Address address2 = addresses.get(i);

        DistanceService distService = new DistanceService();
        String distance = distService.getDistance(address1, address2);
%>
        Distance between <%= address1.getName() %> and <%= address2.getName() %>: <%= distance %><br/>
<%
    }
%>
    </body>
</html>
