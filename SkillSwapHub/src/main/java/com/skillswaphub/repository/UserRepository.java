package com.skillswaphub.repository;

import com.skillswaphub.entity.User;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);

    boolean existsByEmail(@NotNull(message ="Email cannot be null") @Email(message = "Invalid email format") String email);
}
