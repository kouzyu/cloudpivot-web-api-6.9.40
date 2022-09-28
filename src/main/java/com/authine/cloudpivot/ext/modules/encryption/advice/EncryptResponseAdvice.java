package com.authine.cloudpivot.ext.modules.encryption.advice;

import com.authine.cloudpivot.web.api.util.AESUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * @since 2021-03-08
 * 全局返回加密
 */
@Slf4j
@Component
@ControllerAdvice
@ConditionalOnProperty(value = "cloudpivot.encryption", havingValue = "true")
public class EncryptResponseAdvice implements ResponseBodyAdvice {

    private final ObjectMapper objectMapper = new ObjectMapper();
    @Value("${cloudpivot.encryption:false}")
    private boolean isEncrypt;

    @Value("${cloudpivot.encrypt.secret}")
    private String SECRET;

    @Override
    public boolean supports(MethodParameter methodParameter, Class aClass) {
        return isEncrypt;
    }

    @Override
    public Object beforeBodyWrite(Object o, MethodParameter methodParameter, MediaType mediaType, Class aClass, ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse) {
        String path = serverHttpRequest.getURI().getPath();
        if (path.contains("/v1")) {
            return o;
        }

        String result = null;
        if (null != o) {
            try {
                String json = objectMapper.writeValueAsString(o);
                // 加密
                result = AESUtils.encrypt(json, SECRET);
                log.debug("加密后的json: {}", result);
            } catch (Exception e) {
                log.warn(e.getMessage(), e);
            }
        }
        return result;
    }
}
