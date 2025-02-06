package com.skillswaphub.repository;

import com.skillswaphub.domain.entity.User;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);

    boolean existsByEmail(@NotNull(message ="Email cannot be null") @Email(message = "Invalid email format") String email);

    Optional<User> findByVerificationToken(String token);
}
