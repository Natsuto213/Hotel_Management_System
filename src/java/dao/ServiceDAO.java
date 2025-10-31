package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Service;
import utils.DBUtils;

public class ServiceDAO {

    public ArrayList getAllServices() {
        ArrayList<Service> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT * "
                        + "FROM SERVICE";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int serviceId = table.getInt("ServiceID");
                        String serviceName = table.getString("ServiceName");
                        String serviceType = table.getString("ServiceType");
                        double price = table.getDouble("Price");

                        Service service = new Service(serviceId, serviceName, serviceType, price);
                        result.add(service);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public Service getServiceById(int serviceId) {
        Service result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM SERVICE\n"
                        + "WHERE ServiceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, serviceId);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    String serviceName = table.getString("ServiceName");
                    String serviceType = table.getString("ServiceType");
                    double price = table.getDouble("Price");

                    result = new Service(serviceId, serviceName, serviceType, price);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
