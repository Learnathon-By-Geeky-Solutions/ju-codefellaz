package com.skillswaphub.service;

import com.skillswaphub.domain.dto.UserDTO;
import com.skillswaphub.domain.entity.User;
import com.skillswaphub.domain.request.LoginRequest;
import com.skillswaphub.domain.request.RegisterRequest;

import java.util.ArrayList;

public interface UserService {
    User getUserByEmail(String email);
    ArrayList<UserDTO> getAllUser();
    RegisterRequest saveUser(RegisterRequest user);
    String verifyUser(LoginRequest user);

    void verifyUserEmail(String token);
}
