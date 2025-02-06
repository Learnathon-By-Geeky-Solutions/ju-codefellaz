package com.skillswaphub.exceptions.custom;

public class InvalidEmailTokenException extends RuntimeException {
    public InvalidEmailTokenException(String message) {
        super(message);
    }
}
