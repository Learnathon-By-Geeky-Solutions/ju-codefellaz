package com.skillswaphub.exceptions;

import com.skillswaphub.domain.common.ApiResponse;
import com.skillswaphub.domain.enums.ResponseMessage;
import com.skillswaphub.exceptions.custom.*;
import com.skillswaphub.utils.ResponseUtils;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.SignatureException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authorization.AuthorizationDeniedException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;

@RestControllerAdvice
@ResponseStatus
public class GlobalExceptionHandler {

    @ExceptionHandler({Exception.class, EmailSendingException.class})
    public ResponseEntity<ApiResponse<String>> handleGlobalException() {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(ResponseUtils.createErrorResponse(ResponseMessage.INTERNAL_SERVICE_EXCEPTION));
    }

    @ExceptionHandler({UsernameNotFoundException.class, BadCredentialsException.class})
    public ResponseEntity<ApiResponse<String>> handleAuthenticationFailureException() {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(ResponseUtils.createErrorResponse(ResponseMessage.AUTHENTICATION_FAILED));
    }

    @ExceptionHandler({
            MalformedJwtException.class,
            SignatureException.class,
            ExpiredJwtException.class,
            UnsupportedJwtException.class
    })
    public ResponseEntity<ApiResponse<String>> handleAuthenticationWithJwtTokenException() {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(ResponseUtils.createErrorResponse(ResponseMessage.AUTHENTICATION_FAILURE));
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ApiResponse<String>> handleResourceNotFoundException() {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ResponseUtils.createErrorResponse(ResponseMessage.RECORD_NOT_FOUND));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResponse<HashMap<String, String>>> handleValidationExceptions(MethodArgumentNotValidException exception) {
        HashMap<String, String> validationErrors = new HashMap<>();
        exception.getBindingResult().getFieldErrors().forEach(error ->
            validationErrors.put(error.getField(), error.getDefaultMessage()));

        return ResponseEntity.badRequest().body(ResponseUtils.createValidationErrorResponse(validationErrors));
    }

    @ExceptionHandler(AuthorizationDeniedException.class)
    public ResponseEntity<ApiResponse<String>> handleAuthorizationDeniedException() {
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(ResponseUtils.createErrorResponse(ResponseMessage.AUTHORIZATION_FAILURE));
    }

    @ExceptionHandler(RecordAlreadyExistException.class)
    public ResponseEntity<ApiResponse<String>> handleRecordAlreadyExistException(){
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ResponseUtils.createErrorResponse(ResponseMessage.EMAIL_ALREADY_EXISTS));
    }

    @ExceptionHandler(InvalidEmailTokenException.class)
    public ResponseEntity<ApiResponse<String>> handleInvalidTokenException() {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(ResponseUtils.createErrorResponse(ResponseMessage.INVALID_REQUEST_DATA));
    }

    @ExceptionHandler(EmailAlreadyVerifiedException.class)
    public ResponseEntity<ApiResponse<String>> handleEmailAlreadyVerifiedException() {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ResponseUtils.createErrorResponse(ResponseMessage.EMAIL_ALREADY_VERIFIED));
    }

}
