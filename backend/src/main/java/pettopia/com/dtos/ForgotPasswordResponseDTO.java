package pettopia.com.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ForgotPasswordResponseDTO {
    private String message;
    private String resetToken;
    private String resetUrl;
}

