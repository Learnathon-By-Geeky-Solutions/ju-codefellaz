package com.skillswaphub.domain.request;

import com.skillswaphub.domain.enums.Role;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class RegisterRequest implements Serializable {

    @NotNull(message = "Name cannot be null")
    @Size(min=2, max=100, message="Name must be between 2 and 100 characters")
    private String name;

    @NotNull(message ="Email cannot be null")
    @Email(
            message = "Invalid email format",
            regexp = "^[\\w+&*-]+(?:\\.[\\w+&*-]+)*@[a-zA-Z0-9-]+(?:\\.[a-zA-Z]{2,})+$"

    )
    //https://owasp.org/www-community/OWASP_Validation_Regex_Repository
    private String email;

    @NotNull(message = "Password cannot be null")
    @Pattern(
            regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}$",
            message = "Password must be at least 8 characters long, including at least one uppercase letter, one lowercase letter, and one digit."
    )
    private String password;

    @NotNull(message = "Role cannot be null")
    private Role role;
}
