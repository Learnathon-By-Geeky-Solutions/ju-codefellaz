package com.skillswaphub.service.implementation;

import com.skillswaphub.domain.dto.UserDTO;
import com.skillswaphub.domain.entity.User;
import com.skillswaphub.domain.request.LoginRequest;
import com.skillswaphub.domain.request.RegisterRequest;
import com.skillswaphub.exceptions.custom.EmailAlreadyVerifiedException;
import com.skillswaphub.exceptions.custom.InvalidEmailTokenException;
import com.skillswaphub.exceptions.custom.RecordAlreadyExistException;
import com.skillswaphub.repository.UserRepository;
import com.skillswaphub.security.JwtService;
import com.skillswaphub.service.EmailService;
import com.skillswaphub.service.UserService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final ModelMapper modelMapper;
    private final BCryptPasswordEncoder passwordEncoder;
    private final EmailService emailService;

    @Override
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public ArrayList<UserDTO> getAllUser() {
        List<User> users = userRepository.findAll();
        return users.stream()
                .map(user -> modelMapper.map(user, UserDTO.class))
                .collect(Collectors.toCollection(ArrayList::new));
    }

    @Override
    public RegisterRequest saveUser(RegisterRequest registerRequest) {
        if (userRepository.existsByEmail(registerRequest.getEmail())) {
            throw new RecordAlreadyExistException("Email is already in use");
        }

        User user = modelMapper.map(registerRequest, User.class);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        String token = UUID.randomUUID().toString();
        user.setVerificationToken(token);

        userRepository.save(user);
        emailService.sendVerificationEmail(user.getEmail(), token);

        return registerRequest;
    }

    @Override
    public String verifyUser(LoginRequest user) {
        Authentication authenticate = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword()));
        if (authenticate.isAuthenticated()) {
            return jwtService.generateToken(user);
        }
        return null;
    }

    @Override
    public void verifyUserEmail(String token) {
        User user = userRepository.findByVerificationToken(token)
                .orElseThrow(() -> new InvalidEmailTokenException("Invalid or expired token"));

        if (user.isEmailVerified()) {
            throw new EmailAlreadyVerifiedException("Email is already verified");
        }

        user.setEmailVerified(true);
        user.setVerificationToken(null);
        userRepository.save(user);
    }

}
