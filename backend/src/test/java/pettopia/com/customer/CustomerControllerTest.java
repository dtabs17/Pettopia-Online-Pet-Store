
package pettopia.com.customer;

import org.junit.jupiter.api.Test;

import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;

import pettopia.com.customer.dto.ForgotPasswordRequestDTO;
import pettopia.com.customer.dto.ForgotPasswordResponseDTO;
import pettopia.com.customer.dto.ResetPasswordDTO;
import pettopia.com.security.JwtUtil;
import pettopia.com.reward.RewardService;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CustomerControllerTest {

    private final CustomerService customerService = mock(CustomerService.class);
    private final JwtUtil jwtUtil = mock(JwtUtil.class);
    private final RewardService rewardService = mock(RewardService.class);

    @Test
    void forgotPasswordIsBlockedWhenDemoModeIsDisabled() {
        CustomerController controller =
                new CustomerController(customerService, rewardService, jwtUtil, false);

        ForgotPasswordRequestDTO request = new ForgotPasswordRequestDTO();
        request.setEmail("test@example.com");

        ResponseStatusException exception = assertThrows(
                ResponseStatusException.class,
                () -> controller.forgotPassword(request)
        );

        assertEquals(HttpStatus.NOT_FOUND, exception.getStatusCode());
        verifyNoInteractions(customerService);
    }

    @Test
    void resetPasswordIsBlockedWhenDemoModeIsDisabled() {
        CustomerController controller =
                new CustomerController(customerService, rewardService, jwtUtil, false);

        ResetPasswordDTO request = new ResetPasswordDTO();
        request.setToken("test-token");
        request.setNewPassword("new-password");

        ResponseStatusException exception = assertThrows(
                ResponseStatusException.class,
                () -> controller.resetPassword(request)
        );

        assertEquals(HttpStatus.NOT_FOUND, exception.getStatusCode());
        verifyNoInteractions(customerService);
    }

    @Test
    void forgotPasswordReturnsDemoLinkWhenEnabled() {
        CustomerController controller =
                new CustomerController(customerService, rewardService, jwtUtil, true);

        ForgotPasswordRequestDTO request = new ForgotPasswordRequestDTO();
        request.setEmail("test@example.com");

        when(customerService.createPasswordResetToken("test@example.com"))
                .thenReturn("test-token");

        ForgotPasswordResponseDTO response =
                controller.forgotPassword(request);

        assertEquals("test-token", response.getResetToken());
        assertEquals(
                "http://localhost:5173/reset-password?token=test-token",
                response.getResetUrl()
        );

        verify(customerService).createPasswordResetToken("test@example.com");
    }

    @Test
    void resetPasswordWorksWhenDemoModeIsEnabled() {
        CustomerController controller =
                new CustomerController(customerService, rewardService, jwtUtil, true);

        ResetPasswordDTO request = new ResetPasswordDTO();
        request.setToken("test-token");
        request.setNewPassword("new-password");

        String response = controller.resetPassword(request);

        assertEquals("Password has been reset successfully.", response);

        verify(customerService)
                .resetPassword("test-token", "new-password");
    }
}
