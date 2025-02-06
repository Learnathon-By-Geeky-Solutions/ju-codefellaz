package com.skillswaphub.domain.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiResponse<T extends Serializable> implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private String responseCode;
    private String responseMessage;
    private T data;

}
