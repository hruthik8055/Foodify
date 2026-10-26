package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.food.DAO.ContactDAO;
import com.food.model.ContactMessage;
import com.food.util.DBConnectionUtil;

public class ContactDAOImpl implements ContactDAO {

    @Override
    public boolean addContactMessage(ContactMessage contactMessage) {

        String sql = "INSERT INTO ContactMessages "
                + "(UserID, Name, Email, Category, Subject, Message) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, contactMessage.getUserId());
            pstmt.setString(2, contactMessage.getName());
            pstmt.setString(3, contactMessage.getEmail());
            pstmt.setString(4, contactMessage.getCategory());
            pstmt.setString(5, contactMessage.getSubject());
            pstmt.setString(6, contactMessage.getMessage());

            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}