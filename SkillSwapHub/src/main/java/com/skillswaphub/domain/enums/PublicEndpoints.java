package com.skillswaphub.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

@Getter
@AllArgsConstructor
public enum PublicEndpoints {
    REGISTER("/register"),
    LOGIN("/login"),
    API_REGISTER("/api/register"),
    API_LOGIN("/api/login"),
    VERIFY_EMAIL("/api/auth/verify"),
    CSS("/css/**"),
    JS("/js/**"),
    VENDOR("/vendor/**");

    private final String path;

    public static String[] paths() {
        return Arrays.stream(values()).map(PublicEndpoints::getPath).toArray(String[]::new);
    }
}
