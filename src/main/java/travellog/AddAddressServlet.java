/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package travellog;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Seth
 */
public class AddAddressServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException 
    {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        String addressName = req.getParameter("addressName");
        String street = req.getParameter("street");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String zip = req.getParameter("zip");
        
        Entity address = new Entity("Address");

        address.setProperty("addressName", addressName);
        address.setProperty("street", street);
        address.setProperty("city", city);
        address.setProperty("state", state);
        address.setProperty("zip", zip);

        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        datastore.put(address);

        resp.sendRedirect("/travellog.jsp");
    }

}
