package com.skillswaphub.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    @GetMapping("/all-users")
    public String getAllUsers() {
        return "pages/users";
    }

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "pages/registerUsers"; // Returns the registration form page (register.html)
    }
    @GetMapping("/login")
    public String showLogInForm(){
        return "pages/loginUsers";
    }
    @GetMapping("/dashboard")
    public String showIndex(){
        return "pages/index";
    }
}
