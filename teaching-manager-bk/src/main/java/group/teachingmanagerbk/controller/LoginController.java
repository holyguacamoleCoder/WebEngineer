package group.teachingmanagerbk.controller;

import group.teachingmanagerbk.dto.login.LoginParam;
import group.teachingmanagerbk.dto.login.ModifyPasswordParam;
import group.teachingmanagerbk.service.LoginService;
import group.teachingmanagerbk.utils.ReturnResult.Result;
import group.teachingmanagerbk.vo.login.LoginData;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@Tag(name = "登录管理接口")
public class LoginController {

    @Autowired
    LoginService loginService;

    //登录
    @PostMapping("/login")
    @Operation(summary = "用户登录", description = "用户通过账号和密码登录，根据角色判断身份")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "登录成功"),
            @ApiResponse(responseCode = "0", description = "登录失败，账号或密码错误")
    })
    public Result login(@RequestBody LoginParam json) {
        log.info(json.toString());
        // 1代表管理员，2代表学生，3代表教师
        LoginData data = loginService.login(json);
        if (data == null) {
            return new Result().error("登录失败！");
        }
        return new Result().success(data);
    }

    //检查用户登录
    @PostMapping("/check/login")
    @Operation(summary = "检查用户登录状态", description = "检查用户的登录状态，确保用户已登录")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "检查登录成功，用户已登录"),
            @ApiResponse(responseCode = "0", description = "检查登录失败，用户未登录")
    })
    public Result checkLogin(@RequestBody LoginData data) {
        try {
            loginService.checkLogin(data);
            return new Result().success();
        } catch (Exception e) {
            return new Result().error(e.getMessage());
        }
    }

    //更新用户密码
    @PostMapping("/modify/user/password")
    @Operation(summary = "修改用户密码", description = "修改用户的登录密码")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "密码更新成功"),
            @ApiResponse(responseCode = "0", description = "密码更新失败，可能是旧密码不正确")
    })
    public Result modifyUserPassword(@RequestBody ModifyPasswordParam json) {
        loginService.modifyUserPassword(json);
        return new Result().success();
    }
}
