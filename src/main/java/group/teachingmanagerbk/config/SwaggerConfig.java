package group.teachingmanagerbk.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig{
    // 以下配置(是个Bean)是外部Bean, 如果需要生效,得加入启动类对应的spring容器下
    // 见该包中resources中的配置, 注意创建时不要开空目录自动合并, META_INF和spring必须是两个不同目录
    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("教务管理系统")
                        .description("接⼝⽂档")
                        .version("v1"));
    }
}
