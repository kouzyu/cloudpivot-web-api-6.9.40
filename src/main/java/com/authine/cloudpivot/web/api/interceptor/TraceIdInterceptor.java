package com.authine.cloudpivot.web.api.interceptor;

import com.authine.cloudpivot.engine.api.constants.Constants;
import org.slf4j.MDC;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.UUID;

/**
 * @since 2020-04-20
 */
public class TraceIdInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // generate traceId
        String traceId = UUID.randomUUID().toString().replace("-", "").toUpperCase();

        // put traceId
        MDC.put(Constants.TRACE_ID, traceId);

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

        // clear traceId
        MDC.remove(Constants.TRACE_ID);
    }
}
