/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class SystemConfig implements Serializable {

    private int configid;
    private String configname;
    private String configvalue;

    public SystemConfig() {
        this.configid = 0;
        this.configname = "";
        this.configvalue = "";
    }

    public SystemConfig(int configid, String configname, String configvalue) {
        this.configid = configid;
        this.configname = configname;
        this.configvalue = configvalue;
    }

    public int getConfigid() {
        return configid;
    }

    public void setConfigid(int configid) {
        this.configid = configid;
    }

    public String getConfigname() {
        return configname;
    }

    public void setConfigname(String configname) {
        this.configname = configname;
    }

    public String getConfigvalue() {
        return configvalue;
    }

    public void setConfigvalue(String configvalue) {
        this.configvalue = configvalue;
    }
    
    

}
