package travellog;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Seth
 */
public class DistanceService {
    
    public DistanceService()
    {
        
    }
    
    public String getDistance(Address fromAddress, Address toAddress)
    {
        String result = "";
        
        try 
        {
            DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
            
            Filter fromAddressFilter = new FilterPredicate("fromAddress", FilterOperator.EQUAL, fromAddress.getId());
            Filter toAddressFilter = new FilterPredicate("toAddress", FilterOperator.EQUAL, toAddress.getId());
            Filter fromToAddressFilter = CompositeFilterOperator.and(fromAddressFilter, toAddressFilter);
            
            Query query = new Query("Distance").setFilter(fromToAddressFilter);
            List<Entity> distances = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
            
            if (distances.isEmpty())
            {
                //Get distance and save to Distances table.
                URL url = new URL("https://maps.googleapis.com/maps/api/distancematrix/json?"
                    + "origins=" + URLEncoder.encode(fromAddress.toString())
                    + "&destinations=" + URLEncoder.encode(toAddress.toString())
                    + "&units=imperial");
                BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
                StringBuilder res = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    res.append(line);
                }
                reader.close();

                JSONObject jsonObj = new JSONObject(res.toString());
                JSONArray rows = jsonObj.getJSONArray("rows");
                JSONObject row = rows.getJSONObject(0);
                JSONArray elements = row.getJSONArray("elements");
                JSONObject element = elements.getJSONObject(0);
                JSONObject dist = element.getJSONObject("distance");
                String distanceText = dist.getString("text");
                int distanceValue = dist.getInt("value");
                result = distanceText;
                
                Entity distance = new Entity("Distance");

                distance.setProperty("fromAddress", fromAddress.getId());
                distance.setProperty("toAddress", toAddress.getId());
                distance.setProperty("distance", distanceText);
                distance.setProperty("value", distanceValue);

                datastore.put(distance);
            }
            else
            {
                result = (String) distances.get(0).getProperty("distance");
            }
            
        } catch (MalformedURLException e) {
            // ...
        } catch (IOException e) {
            // ...
        }
        
        return result;
    }
}
