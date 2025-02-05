package com.skillswaphub.service.implementation;

import com.skillswaphub.dto.UserDTO;
import com.skillswaphub.entity.User;
import com.skillswaphub.repository.UserRepository;
import com.skillswaphub.security.JwtService;
import com.skillswaphub.service.UserService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final ModelMapper modelMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    @Override
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public List<UserDTO> getAllUser() {
        List<User> users= userRepository.findAll();
        return users.stream()
                .map(user-> modelMapper.map(user, UserDTO.class))
                .toList();
    }

    @Override
    public void saveUser(User user) {
        if(userRepository.existsByEmail(user.getEmail())) {
            throw new IllegalArgumentException("Email is already in use");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
    }

    @Override
    public String verifyUser(User user) {
        Authentication authenticate = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword()));
        if(authenticate.isAuthenticated()){
            return jwtService.generateToken(user);
        }
        return "fail";
    }

}
