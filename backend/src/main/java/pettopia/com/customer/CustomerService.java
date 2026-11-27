package pettopia.com.customer;

import pettopia.com.customer.dto.CustomerLoginDTO;
import pettopia.com.customer.dto.CustomerRegistrationDTO;
import pettopia.com.customer.dto.JwtResponseDTO;
import pettopia.com.security.JwtService;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import java.time.LocalDateTime;

import java.util.UUID;
import java.util.Optional;

@Service
public class CustomerService {

    private final CustomerRepository customerRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final JwtService jwtService;

    public CustomerService(CustomerRepository customerRepository,
                           PasswordResetTokenRepository passwordResetTokenRepository,
                           JwtService jwtService) {
        this.customerRepository = customerRepository;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
        this.bCryptPasswordEncoder = new BCryptPasswordEncoder();
        this.jwtService = jwtService;
    }

    public String createPasswordResetToken(String email) {
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("No account found with that email"));

        String tokenValue = UUID.randomUUID().toString();

        PasswordResetToken token = PasswordResetToken.builder()
                .token(tokenValue)
                .customer(customer)
                .expiresAt(LocalDateTime.now().plusHours(1))
                .used(false)
                .build();

        passwordResetTokenRepository.save(token);

        return tokenValue;
    }

    public void resetPassword(String tokenValue, String newPassword) {
        PasswordResetToken token = passwordResetTokenRepository.findByToken(tokenValue)
                .orElseThrow(() -> new RuntimeException("Invalid or expired reset token"));

        if (token.isUsed()) {
            throw new RuntimeException("Reset token has already been used");
        }

        if (token.getExpiresAt().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Reset token has expired");
        }

        Customer customer = token.getCustomer();

        validatePasswordPolicy(newPassword);

        customer.setPasswordHash(bCryptPasswordEncoder.encode(newPassword));
        customer.setPasswordLastChanged(LocalDateTime.now());
        customerRepository.save(customer);

        token.setUsed(true);
        passwordResetTokenRepository.save(token);
    }


    public CustomerRegistrationDTO registerCustomer(CustomerRegistrationDTO customerDto) {
        Optional<Customer> existingCustomer = customerRepository.findByEmail(customerDto.getEmail());
        if (existingCustomer.isPresent()) {
            throw new RuntimeException("Email already registered");
        }
        String rawPassword = customerDto.getPassword();
        validatePasswordPolicy(rawPassword);

        Customer customer = new Customer();
        customer.setEmail(customerDto.getEmail());
        customer.setFirstName(customerDto.getFirstName());
        customer.setLastName(customerDto.getLastName());
        customer.setPasswordHash(bCryptPasswordEncoder.encode(customerDto.getPassword()));

        customerRepository.save(customer);
        customerDto.setPassword(null);
        return customerDto;
    }

    public JwtResponseDTO loginCustomer(CustomerLoginDTO customerLoginDto) {
        Optional<Customer> existingCustomerOpt = customerRepository.findByEmail(customerLoginDto.getEmail());
        if (!existingCustomerOpt.isPresent()) {
            throw new RuntimeException("Invalid email or password");
        }

        Customer customer = existingCustomerOpt.get();

        LocalDateTime now = LocalDateTime.now();
        if (customer.getAccountLockedUntil() != null &&
                customer.getAccountLockedUntil().isAfter(now)) {
            throw new RuntimeException("Account locked due to multiple failed attempts. Try again later.");
        }

        if (bCryptPasswordEncoder.matches(customerLoginDto.getPassword(), customer.getPasswordHash())) {
            customer.setFailedLoginAttempts(0);
            customer.setAccountLockedUntil(null);
            customerRepository.save(customer);

            String token = jwtService.generateToken(customer.getEmail());
            return new JwtResponseDTO(customer.getEmail(), token);
        }

        int attempts = (customer.getFailedLoginAttempts() == null ? 0 : customer.getFailedLoginAttempts()) + 1;
        customer.setFailedLoginAttempts(attempts);

        if (attempts >= 5) {
            customer.setAccountLockedUntil(now.plusMinutes(15));
        }

        customerRepository.save(customer);
        throw new RuntimeException("Invalid email or password");
    }

    public void changePassword(String customerEmail, String currentPassword, String newPassword) {
        Customer customer = customerRepository.findByEmail(customerEmail)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        if (!bCryptPasswordEncoder.matches(currentPassword, customer.getPasswordHash())) {
            throw new RuntimeException("Current password is incorrect");
        }

        validatePasswordPolicy(newPassword);

        customer.setPasswordHash(bCryptPasswordEncoder.encode(newPassword));
        customer.setPasswordLastChanged(LocalDateTime.now());
        customerRepository.save(customer);
    }

    private void validatePasswordPolicy(String password) {
        if (password == null) {
            throw new RuntimeException("Password is required");
        }

        if (password.length() < 10) {
            throw new RuntimeException("Password must be at least 10 characters long");
        }

        if (password.length() > 64) {
            throw new RuntimeException("Password must be at most 64 characters long");
        }
    }


}

