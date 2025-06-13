package group.teachingmanagerbk.dto.login;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ModifyPasswordParam extends LoginParam {

    @Schema(description = "用户ID", example = "U12345")
    private String userId;      //用户id
}
