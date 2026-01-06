package pettopia.com.dtos;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class CustomerRegistrationDTO {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
}
