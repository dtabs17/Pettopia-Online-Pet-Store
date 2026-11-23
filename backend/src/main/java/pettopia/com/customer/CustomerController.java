package pettopia.com.customer;

import pettopia.com.customer.dto.ChangePasswordDTO;
import pettopia.com.customer.dto.CustomerLoginDTO;
import pettopia.com.customer.dto.CustomerRegistrationDTO;
import pettopia.com.customer.dto.ForgotPasswordRequestDTO;
import pettopia.com.customer.dto.ForgotPasswordResponseDTO;
import pettopia.com.customer.dto.JwtResponseDTO;
import pettopia.com.customer.dto.ResetPasswordDTO;

import org.springframework.web.bind.annotation.*;
import pettopia.com.security.JwtUtil;
import pettopia.com.reward.dto.RedeemRequestDTO;
import pettopia.com.reward.dto.RewardSummaryDTO;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("api/customers")
public class CustomerController {
    private final CustomerService customerService;
    private final JwtUtil jwtUtil;
    private final boolean demoPasswordResetEnabled;

    public CustomerController(
            CustomerService customerService,
            JwtUtil jwtUtil,
            @Value("${pettopia.demo-password-reset.enabled:false}") boolean demoPasswordResetEnabled) {

        this.customerService = customerService;
        this.jwtUtil = jwtUtil;
        this.demoPasswordResetEnabled = demoPasswordResetEnabled;
    }

    @PostMapping("/register")
    public CustomerRegistrationDTO registerCustomer(@RequestBody CustomerRegistrationDTO customerRegistrationDTO) {
        return customerService.registerCustomer(customerRegistrationDTO);
    }

    @PostMapping("/login")
    public JwtResponseDTO loginCustomer(@RequestBody CustomerLoginDTO customerLoginDTO) {
        return customerService.loginCustomer(customerLoginDTO);
    }

    @PostMapping("/logout")
    public String logoutCustomer() {
        return "Logged out successfully";
    }

    @GetMapping("/rewards")
    public RewardSummaryDTO getRewards(@RequestHeader("Authorization") String authHeader) {
        String email = jwtUtil.extractEmail(authHeader);
        return customerService.getRewardHistory(email);
    }

    @PostMapping("/rewards/redeem")
    public RewardSummaryDTO redeemPoints(@RequestHeader("Authorization") String authHeader,
            @RequestBody RedeemRequestDTO redeemRequest) {
        String email = jwtUtil.extractEmail(authHeader);
        int points = redeemRequest.getPoints();
        return customerService.redeemPoints(email, points, "Redeemed via dashboard");
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestHeader("Authorization") String authHeader,
            @RequestBody ChangePasswordDTO dto) {
        String email = jwtUtil.extractEmail(authHeader);
        customerService.changePassword(email, dto.getCurrentPassword(), dto.getNewPassword());
        return "Password changed successfully";
    }

    @PostMapping("/forgot-password")
    public ForgotPasswordResponseDTO forgotPassword(@RequestBody ForgotPasswordRequestDTO request) {
        if (!demoPasswordResetEnabled) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Demo password reset is disabled");
        }
        String token = customerService.createPasswordResetToken(request.getEmail());

        String resetUrl = "http://localhost:5173/reset-password?token=" + token;

        return new ForgotPasswordResponseDTO(
                "Demo mode: Use the reset link below to reset your password.",
                token,
                resetUrl);
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestBody ResetPasswordDTO request) {
        if (!demoPasswordResetEnabled) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Demo password reset is disabled");
        }
        customerService.resetPassword(request.getToken(), request.getNewPassword());
        return "Password has been reset successfully.";
    }

}
