package model;

import java.io.Serializable;
import java.text.DecimalFormat;

public class Service implements Serializable {

    private int serviceid;
    private String servicename;
    private String servicetype;
    private double price;

    public Service() {
        this.serviceid = 0;
        this.servicename = "";
        this.servicetype = "";
        this.price = 0;
    }

    public Service(int serviceid, String servicename, String servicetype, double price) {
        this.serviceid = serviceid;
        this.servicename = servicename;
        this.servicetype = servicetype;
        this.price = price;
    }

    public int getServiceid() {
        return serviceid;
    }

    public void setServiceid(int serviceid) {
        this.serviceid = serviceid;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }

    public String getServicetype() {
        return servicetype;
    }

    public void setServicetype(String servicetype) {
        this.servicetype = servicetype;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getFormattedPrice() {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(this.price);
    }
}
