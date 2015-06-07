package travellog;

import com.google.appengine.api.datastore.Entity;

/**
 *
 * @author Seth
 */
public class Address {
    
    private long id;
    private String name;
    private String street;
    private String street2;
    private String city;
    private String state;
    private String zip;
    
    
    public Address()
    { }
    
    public Address(Entity address)
    {
        id = address.getKey().getId();
        name = (String)address.getProperty("addressName");
        street = (String)address.getProperty("street");
        city = (String)address.getProperty("city");
        state = (String)address.getProperty("state");
        zip = (String)address.getProperty("zip");
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getStreet2() {
        return street2;
    }

    public void setStreet2(String street2) {
        this.street2 = street2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }
    
    public String toString()
    {
        return street + ", " + city + ", " + state + " " + zip;
    }
}
