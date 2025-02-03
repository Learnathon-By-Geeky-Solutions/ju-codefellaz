package com.skillswaphub.dto;

import com.skillswaphub.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class UserDTO {
    private String name;
    private String email;
    private Role role;
}
