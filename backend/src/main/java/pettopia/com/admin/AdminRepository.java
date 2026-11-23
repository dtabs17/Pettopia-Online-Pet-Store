package pettopia.com.admin;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AdminRepository extends JpaRepository<AdminUser, Integer> {
    Optional<AdminUser> findByEmail(String email);
}
