package com.authine.cloudpivot;

import com.authine.cloudpivot.engine.component.PropertySourceListener;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;


@SpringBootApplication
@EnableRedisHttpSession(redisNamespace = "${spring.session.redis.namespace}")
public class WebApiBootStartupApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(WebApiBootStartupApplication.class);
        app.addListeners(new PropertySourceListener());
        app.run(args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(WebApiBootStartupApplication.class);
    }
}
