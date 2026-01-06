package pettopia.com.dtos;

import lombok.Data;

@Data
public class ResetPasswordDTO {
    private String token;
    private String newPassword;
}
