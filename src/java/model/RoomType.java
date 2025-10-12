package model;

public class RoomType {

    private int roomTypeId;
    private String typeName;
    private String capacity;
    private double price;

    public RoomType() {
    }

    public RoomType(int roomTypeId, String typeName, String capacity, double price) {
        this.roomTypeId = roomTypeId;
        this.typeName = typeName;
        this.capacity = capacity;
        this.price = price;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getCapacity() {
        return capacity;
    }

    public void setCapacity(String capacity) {
        this.capacity = capacity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    
}
