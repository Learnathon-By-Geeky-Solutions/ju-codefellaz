package com.skillswaphub.domain.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class JwtTokenResponse implements Serializable {
    private String token;
    private String tokenType;
    private int expiresIn;
}
