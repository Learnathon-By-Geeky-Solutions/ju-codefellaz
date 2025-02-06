package com.skillswaphub.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum ApiResponseCode {
    // Success Codes
    OPERATION_SUCCESSFUL("S100000"),

    // Client Errors
    RECORD_NOT_FOUND("E000101"),
    INVALID_REQUEST_DATA("E000102"),
    AUTHENTICATION_FAILED("E000401"),
    INVALID_PASSWORD("E000107"),
    NOT_AUTHORIZED("E000109"),

    // Server Errors
    SERVICE_UNAVAILABLE("E000103"),
    DB_OPERATION_FAILED("E000010"),
    OPERATION_UNSUCCESSFUL("E00214"),
    INTER_SERVICE_COMMUNICATION_ERROR("E000111"),
    REQUEST_PROCESSING_FAILED("E000106"),

    // Business Logic Errors
    NO_ACCOUNT_FOUND("E000104");

    private final String responseCode;
}
