package com.skillswaphub.service.implementation;

import com.skillswaphub.exceptions.custom.EmailSendingException;
import com.skillswaphub.service.EmailService;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {
    public final JavaMailSender mailSender;

    @Override
    public void sendEmail(String to, String subject, String body) {
        try{
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);

            mailSender.send(message);
        }
        catch(Exception e){
            throw new EmailSendingException(e.getMessage());
        }
    }

    @Override
    public void sendVerificationEmail(String to, String token) {
        String subject = "Verify Your Email";
        String verificationUrl = "http://localhost:8080/api/auth/verify?token=" + token;
        String content = "Click the link to verify your email: " + verificationUrl;

        sendEmail(to, subject, content);
    }
}
