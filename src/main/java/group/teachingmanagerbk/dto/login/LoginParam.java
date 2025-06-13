package group.teachingmanagerbk.dto.login;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class LoginParam {

    @Schema(description = "用户账号", example = "user123")
    private String account;     //账号

    @Schema(description = "用户密码", example = "password123")
    private String password;    //密码

    @Schema(description = "用户身份权限", example = "admin")
    private String authority;   //身份权限
}
