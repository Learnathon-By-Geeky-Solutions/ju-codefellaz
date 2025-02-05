package com.skillswaphub.controller.rest;

import com.skillswaphub.dto.UserDTO;
import com.skillswaphub.entity.User;
import com.skillswaphub.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class UserRestController {
    private final UserService userService;

    @GetMapping("/all-users")
    public List<UserDTO> getAllUsers() {
        return userService.getAllUser();
    }

    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@Valid @RequestBody User user) {
        try{
            userService.saveUser(user);
            return new ResponseEntity<>("User created successfully", HttpStatus.CREATED);
        }
        catch (IllegalArgumentException e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/login")
    public String loginUser(@RequestBody User user) {
        return userService.verifyUser(user);
    }

}
