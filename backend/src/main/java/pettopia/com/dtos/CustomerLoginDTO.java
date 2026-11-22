package pettopia.com.dtos;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerLoginDTO {
    private String email;
    private String password;
}
