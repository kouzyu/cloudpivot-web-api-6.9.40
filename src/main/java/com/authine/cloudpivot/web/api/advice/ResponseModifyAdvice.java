package com.authine.cloudpivot.web.api.advice;

import com.authine.cloudpivot.engine.api.constants.Constants;
import com.authine.cloudpivot.web.api.config.RunTimeConfig;
import com.authine.cloudpivot.web.api.view.ResponseResult;
import org.apache.skywalking.apm.toolkit.trace.TraceContext;
import org.slf4j.MDC;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;


@RestControllerAdvice
public class ResponseModifyAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter methodParameter, Class<? extends HttpMessageConverter<?>> aClass) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object obj, MethodParameter methodParameter, MediaType mediaType, Class<? extends HttpMessageConverter<?>> aClass, ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse) {
        // put traceId to response
        if (obj instanceof ResponseResult) {
            ResponseResult<?> rr = (ResponseResult<?>) obj;
            if (RunTimeConfig.INSTANCE.isOpenSkyWalkingAgent()) {
                rr.setTraceId(TraceContext.traceId());
            } else {
                rr.setTraceId(MDC.get(Constants.TRACE_ID));
            }
        }

        return obj;
    }
}
