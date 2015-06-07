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
    <title>Address Book</title>
</head>

    <body>
<%
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Query query = new Query("Address").addSort("addressName");
    List<Entity> addressEntities = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
    
    if (addressEntities.isEmpty()) {
%>
<p>No addresses.</p>
<%
    } else {
%>
<p>Contacts in address book:</p>
<%
        List<Address> addresses = new ArrayList();
        for (Entity address : addressEntities)
        {
            addresses.add(new Address(address));
        }
        
        for (Address address : addresses) 
        {
            pageContext.setAttribute("address_id", address.getId());
            pageContext.setAttribute("address_name", address.getName());
            pageContext.setAttribute("address_street", address.getStreet());
            pageContext.setAttribute("address_city", address.getCity());
            pageContext.setAttribute("address_state", address.getState());
            pageContext.setAttribute("address_zip", address.getZip());
%>
<p>
<b>${fn:escapeXml(address_name)} (${fn:escapeXml(address_id)})</b>
<div>
${fn:escapeXml(address_street)},
${fn:escapeXml(address_city)},
${fn:escapeXml(address_state)}
${fn:escapeXml(address_zip)}
</div>
</p>
<%
        }
    }
%>

<form action="/addAddress" method="post">
    <table>
    <tr><td>Name: </td><td><input type="text" name="addressName"/></td></tr>
    <tr><td>Street: </td><td><input type="text" name="street"/></td></tr>
    <tr><td>City: </td><td><input type="text" name="city"/> </td></tr>
    <tr><td>State: </td><td><input type="text" maxlength="2" name="state"/></td></tr>
    <tr><td>Zip: </td><td><input type="text" name="zip"/></td></tr>
    <tr><td></td><td><input type="submit" value="Add Address"/></td></tr>
    </table>
</form>



    </body>
</html>
