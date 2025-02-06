package com.skillswaphub.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ResponseMessage {

    // Success Messages
    OPERATION_SUCCESSFUL(ApiResponseCode.OPERATION_SUCCESSFUL.getResponseCode(), "Operation completed successfully."),

    // Client Error Messages
    RECORD_NOT_FOUND(ApiResponseCode.RECORD_NOT_FOUND.getResponseCode(), "The requested record could not be found."),
    NO_ACCOUNT_FOUND(ApiResponseCode.NO_ACCOUNT_FOUND.getResponseCode(), "No account was found with the provided details."),
    INVALID_REQUEST_DATA(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "The provided request data is invalid."),
    INVALID_JSON_BODY(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "Invalid JSON structure: Expected an object."),
    RECORD_NOT_MATCHED(ApiResponseCode.RECORD_NOT_FOUND.getResponseCode(), "No matching record found."),
    RECORD_ALREADY_EXIST(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "The record already exists."),
    INVALID_MOBILE_NUMBER(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "The mobile number is already registered."),
    EMAIL_ALREADY_EXISTS(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "The email address is already registered."),
    EMAIL_ALREADY_VERIFIED(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "The email address is already verified."),
    MOBILE_ALREADY_EXISTS(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "The mobile number is already registered."),
    REQUEST_CANNOT_PROCESS(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "The request could not be processed."),
    ALREADY_REQUEST_PENDING(ApiResponseCode.INVALID_REQUEST_DATA.getResponseCode(), "A request is already pending for this action."),

    // Authentication & Authorization Messages
    AUTHENTICATION_FAILED(ApiResponseCode.AUTHENTICATION_FAILED.getResponseCode(), "Authentication failed due to incorrect credentials."),
    AUTHENTICATION_FAILURE(ApiResponseCode.AUTHENTICATION_FAILED.getResponseCode(), "Authentication failed due to invalid cookie."),
    AUTHORIZATION_FAILURE(ApiResponseCode.NOT_AUTHORIZED.getResponseCode(), "Access Denied: You do not have permission to perform this action."),
    OLD_PASSWORD_NOT_VALID(ApiResponseCode.INVALID_PASSWORD.getResponseCode(), "The old password does not match."),
    NEW_PASSWORD_MISMATCH(ApiResponseCode.INVALID_PASSWORD.getResponseCode(), "The new password and confirmation do not match."),

    // Server Error Messages
    SERVICE_UNAVAILABLE(ApiResponseCode.SERVICE_UNAVAILABLE.getResponseCode(), "The service is currently unavailable. Please try again later."),
    DATABASE_EXCEPTION(ApiResponseCode.DB_OPERATION_FAILED.getResponseCode(), "An error occurred while accessing the database."),
    INTERNAL_SERVICE_EXCEPTION(ApiResponseCode.REQUEST_PROCESSING_FAILED.getResponseCode(), "An internal error occurred while processing the request."),
    INTER_SERVICE_COMMUNICATION_ERROR(ApiResponseCode.INTER_SERVICE_COMMUNICATION_ERROR.getResponseCode(), "An error occurred while communicating with another service.");

    private final String responseCode;
    private final String message;
}
