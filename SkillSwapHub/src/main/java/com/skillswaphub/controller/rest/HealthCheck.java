package com.skillswaphub.controller.rest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthCheck {

    @GetMapping("/admin/health-check")
    @PreAuthorize("hasRole('ADMIN')")
    public String checkApi(){
        return "OK";
    }
}
