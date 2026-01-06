package pettopia.com.controllers;

import org.springframework.web.bind.annotation.*;
import pettopia.com.config.JwtUtil;
import pettopia.com.dtos.*;
import pettopia.com.services.CustomerService;
import pettopia.com.dtos.ChangePasswordDTO;
import pettopia.com.dtos.ForgotPasswordRequestDTO;
import pettopia.com.dtos.ResetPasswordDTO;


@RestController
@RequestMapping("api/customers")
public class CustomerController {
    private final CustomerService customerService;
    private final JwtUtil jwtUtil;

    public CustomerController(CustomerService customerService, JwtUtil jwtUtil) {
        this.customerService = customerService;
        this.jwtUtil = jwtUtil;
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
        String token = customerService.createPasswordResetToken(request.getEmail());

        String resetUrl = "http://localhost:5173/reset-password?token=" + token;

        return new ForgotPasswordResponseDTO(
                "If an account exists for that email, a reset link has been sent.",
                token,
                resetUrl
        );
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestBody ResetPasswordDTO request) {
        customerService.resetPassword(request.getToken(), request.getNewPassword());
        return "Password has been reset successfully.";
    }


}
