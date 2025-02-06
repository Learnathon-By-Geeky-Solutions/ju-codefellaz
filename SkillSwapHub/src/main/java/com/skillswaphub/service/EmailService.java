package com.skillswaphub.service;

public interface EmailService {
    public void sendEmail(String to, String subject, String body);
    public void sendVerificationEmail(String to, String token);
}
