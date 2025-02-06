package com.skillswaphub.utils;

import com.skillswaphub.domain.common.ApiResponse;
import com.skillswaphub.domain.enums.ApiResponseCode;
import com.skillswaphub.domain.enums.ResponseMessage;
import lombok.experimental.UtilityClass;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Utility class for creating standardized API responses.
 */
@UtilityClass
public class ResponseUtils {

    /** ✅ Generic Success Response without param */
    public static <T extends Serializable> ApiResponse<T> createSuccessResponse() {
        return new ApiResponse<>(ResponseMessage.OPERATION_SUCCESSFUL.getResponseCode(),
                ResponseMessage.OPERATION_SUCCESSFUL.getMessage(),null);
    }

    /** ✅ Generic Success Response */
    public static <T extends Serializable> ApiResponse<T> createSuccessResponse(T data) {
        return new ApiResponse<>(ResponseMessage.OPERATION_SUCCESSFUL.getResponseCode(),
                ResponseMessage.OPERATION_SUCCESSFUL.getMessage(), data);
    }

    /** ✅ Success Response with Custom Message */
    public static <T extends Serializable> ApiResponse<T> createSuccessResponse(String message, T data) {
        return new ApiResponse<>(ApiResponseCode.OPERATION_SUCCESSFUL.getResponseCode(), message, data);
    }

    /** ✅ Success Response without Data */
    public static <T extends Serializable> ApiResponse<T> createSuccessResponse(String message) {
        return new ApiResponse<>(ApiResponseCode.OPERATION_SUCCESSFUL.getResponseCode(), message, null);
    }

    /** ✅ Error Response with Code & Message */
    public static <T extends Serializable> ApiResponse<T> createErrorResponse(String code, String message) {
        return new ApiResponse<>(code, message, null);
    }

    /** ✅ Error Response from Enum */
    public static <T extends Serializable> ApiResponse<T> createErrorResponse(ResponseMessage responseMessage) {
        return new ApiResponse<>(responseMessage.getResponseCode(), responseMessage.getMessage(), null);
    }

    /** ✅ Error Response with Validation Errors (using HashMap for serialization) */
    public static ApiResponse<HashMap<String, String>> createValidationErrorResponse(Map<String, String> validationErrors) {
        return new ApiResponse<>(
                ResponseMessage.INVALID_REQUEST_DATA.getResponseCode(),
                ResponseMessage.INVALID_REQUEST_DATA.getMessage(),
                new HashMap<>(validationErrors) // Wrap Map in HashMap to ensure serialization
        );
    }
}
