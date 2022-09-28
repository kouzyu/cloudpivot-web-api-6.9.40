package com.authine.cloudpivot.ext.modules.encryption.config;

import com.authine.cloudpivot.ext.modules.encryption.filter.DecryptFilter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConditionalOnProperty(value = "cloudpivot.encryption", havingValue = "true")
public class EncryptionConfig {

    @Bean
    @ConditionalOnProperty(value = "cloudpivot.encryption", havingValue = "true")
    public FilterRegistrationBean<DecryptFilter> customEncryptFilter() {
        FilterRegistrationBean<DecryptFilter> registration = new FilterRegistrationBean<>();
        registration.setFilter(new DecryptFilter());
        registration.addUrlPatterns("/**");
        registration.setName(DecryptFilter.class.getName());
        registration.setOrder(Integer.MAX_VALUE);
        return registration;
    }
}
