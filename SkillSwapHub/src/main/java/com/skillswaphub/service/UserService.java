package com.skillswaphub.service;

import com.skillswaphub.dto.UserDTO;
import com.skillswaphub.entity.User;

import java.util.List;

public interface UserService {
    User getUserByEmail(String email);
    List<UserDTO> getAllUser();
    void saveUser(User user);
    String verifyUser(User user);
}
