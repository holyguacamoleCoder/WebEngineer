package group.teachingmanagerbk.interceptor;

import com.alibaba.fastjson.JSONObject;
import group.teachingmanagerbk.utils.JwtUtil;
import group.teachingmanagerbk.utils.ReturnResult.Result;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;

@Slf4j
@CrossOrigin
@Component
public class LoginCheckInterceptor implements HandlerInterceptor {

    private static final String[] SWAGGER_PATHS = {
            "/swagger-ui/**",
            "/v3/api-docs/**",
            "/swagger-ui.html",
            "/swagger-resources/**",
            "/webjars/**"
    };
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 如果请求的路径是 Swagger UI 相关路径，直接放行
        for (String swaggerPath : SWAGGER_PATHS) {
            if (request.getRequestURI().startsWith(swaggerPath)) {
                log.info("Swagger UI 请求，直接放行");
                return true;
            }
        }
        //拦截器取到请求先进行判断，如果是OPTIONS请求，则放行
        if("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            log.info(request.getMethod());
            log.info("Method:OPTIONS");
            return true;
        }

        //获取请求头中的JWT令牌
        String jwt = request.getHeader("Authorization");

        if (!StringUtils.hasLength(jwt)) {
            log.info("未携带jwt令牌信息");
            promptNotLogin(response);
            return false;
        }

        //相应的身份只能访问相应的接口，不能说登录成功了就将接口全部暴露给用户了（待实现）

        try {
            JwtUtil.parseJWT(jwt);
        } catch (Exception e) {
            log.info("jwt令牌解析失败");
            promptNotLogin(response);
            return false;
        }

        return true;
    }

    private void promptNotLogin(HttpServletResponse response) throws IOException {
        Result result = new Result().error("NOT_LOGIN");
        response.getWriter().write(JSONObject.toJSONString(result));
    }

}
