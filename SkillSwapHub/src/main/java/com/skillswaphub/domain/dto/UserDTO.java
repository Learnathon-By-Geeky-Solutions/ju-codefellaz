package com.skillswaphub.domain.dto;

import com.skillswaphub.domain.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class UserDTO implements Serializable {
    private String name;
    private String email;
    private Role role;
}
