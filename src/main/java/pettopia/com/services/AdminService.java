package pettopia.com.services;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pettopia.com.dtos.AdminLoginRequest;
import pettopia.com.dtos.AdminLoginResponse;
import pettopia.com.entities.AdminUser;
import pettopia.com.repositories.AdminRepository;

import java.time.LocalDateTime;

@Service
public class AdminService {

    private final AdminRepository adminRepository;
    private final JwtService jwtService;
    private final BCryptPasswordEncoder passwordEncoder;

    public AdminService(AdminRepository adminRepository, JwtService jwtService, BCryptPasswordEncoder passwordEncoder) {
        this.adminRepository = adminRepository;
        this.jwtService = jwtService;
        this.passwordEncoder = passwordEncoder;
    }

    public AdminLoginResponse login(AdminLoginRequest request) {
        AdminUser admin = adminRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Admin not found"));

        if (!passwordEncoder.matches(request.getPassword(), admin.getPasswordHash())) {
            throw new RuntimeException("Invalid password");
        }

        admin.setLastLogin(LocalDateTime.now());
        adminRepository.save(admin);

        String role = admin.getRole().name().toUpperCase(); // e.g., "ADMIN"
        String token = jwtService.generateToken(admin.getEmail(), role);

        return new AdminLoginResponse(token, admin.getEmail(), role);
    }
}
