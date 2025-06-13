package group.teachingmanagerbk.config;

import group.teachingmanagerbk.utils.ReturnResult.Result;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.OK) // 返回200而不是500
    public Result handleRuntimeException(RuntimeException ex) {
        // 所有未处理的异常都会进入这里，返回统一错误结构
        return new Result(0, ex.getMessage(), null);
    }
}
