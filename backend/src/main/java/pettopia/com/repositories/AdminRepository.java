package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pettopia.com.entities.AdminUser;

import java.util.Optional;

public interface AdminRepository extends JpaRepository<AdminUser, Integer> {
    Optional<AdminUser> findByEmail(String email);
}
