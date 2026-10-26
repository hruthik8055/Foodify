package com.food.DAO;

import java.util.List;
import com.food.model.User;

public interface UserDAO {

    int addUser(User user);

    User getUser(String email);
    
    User getUserByEmail(String email);

    void updateUser(User user);

    void deleteUser(String email);

    List<User> getAllUser();
} 