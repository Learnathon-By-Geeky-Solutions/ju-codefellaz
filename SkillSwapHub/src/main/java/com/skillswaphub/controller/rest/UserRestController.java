package com.skillswaphub.controller.rest;

import com.skillswaphub.domain.dto.UserDTO;
import com.skillswaphub.domain.common.ApiResponse;
import com.skillswaphub.domain.request.LoginRequest;
import com.skillswaphub.domain.request.RegisterRequest;
import com.skillswaphub.domain.response.JwtTokenResponse;
import com.skillswaphub.service.UserService;
import com.skillswaphub.utils.ResponseUtils;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class UserRestController {
    private final UserService userService;

    @GetMapping("/all-users")
    public ResponseEntity<ApiResponse<ArrayList<UserDTO>>> getAllUsers() {
        ArrayList<UserDTO> users = userService.getAllUser();
        ApiResponse<ArrayList<UserDTO>> response = ResponseUtils.createSuccessResponse(users);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/register")
    public ResponseEntity<ApiResponse<RegisterRequest>> registerUser(@Valid @RequestBody RegisterRequest user) {
        RegisterRequest registeredUser = userService.saveUser(user);
        ApiResponse<RegisterRequest> response = ResponseUtils.createSuccessResponse(registeredUser);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/auth/verify")
    public ResponseEntity<ApiResponse<String>> verifyEmailToken(@RequestParam String token) {
        userService.verifyUserEmail(token);
        return new ResponseEntity<>(ResponseUtils.createSuccessResponse(),HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<JwtTokenResponse>> loginUser(@RequestBody LoginRequest user) {
        String verificationResult = userService.verifyUser(user);
        JwtTokenResponse tokenResponse = new JwtTokenResponse(verificationResult, "Bearer", 86400);
        ApiResponse<JwtTokenResponse> response = ResponseUtils.createSuccessResponse(tokenResponse);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}
