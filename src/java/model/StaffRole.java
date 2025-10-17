/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;

/**
 *
 * @author votra
 */
public class StaffRole implements Serializable{
    private final String value;

    private StaffRole(String value) {
        this.value = value;
    }

    public static final StaffRole RECEPTIONIST = new StaffRole("Receptionist");
    public static final StaffRole MANAGER = new StaffRole("Manager");
    public static final StaffRole HOUSEKEEPING = new StaffRole("Housekeeping");
    public static final StaffRole SERVICE_STAFF = new StaffRole("ServiceStaff");
    public static final StaffRole ADMIN = new StaffRole("Admin");

    public String getValue() {
        return this.value;
    }
    
    private static final StaffRole[] ALL_ROLES = {RECEPTIONIST, MANAGER, HOUSEKEEPING, SERVICE_STAFF, ADMIN};

    public static StaffRole valueFromDb(String value) {
        for (StaffRole role : ALL_ROLES) {
            if (role.getValue().equalsIgnoreCase(value)) {
                return role;
            }
        }
        throw new IllegalArgumentException("Unknown role: " + value);
    }
}
