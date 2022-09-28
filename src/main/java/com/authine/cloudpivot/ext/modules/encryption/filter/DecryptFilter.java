package com.authine.cloudpivot.ext.modules.encryption.filter;

import com.alibaba.fastjson.JSON;
import com.authine.cloudpivot.web.api.util.AESUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @since 2021-03-08
 * 全局解密
 */
@Slf4j
@Component
@ConditionalOnProperty(value = "cloudpivot.encryption", havingValue = "true")
public class DecryptFilter extends OncePerRequestFilter {

    @Value("${cloudpivot.encryption:false}")
    private boolean isEncrypt;

    @Value("${cloudpivot.encrypt.secret}")
    private String SECRET;

    @Override
    @SuppressWarnings("unchecked")
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        response.addHeader("isEncrypt", String.valueOf(isEncrypt));
        if (isEncrypt) {
            String requestURI = request.getRequestURI();
            if (requestURI.contains("/v1")) {
                filterChain.doFilter(request, response);
            } else {
                String method = request.getMethod();
                if ("GET".equals(method)) {
                    //获取请求参数
                    Map<String, String[]> map = request.getParameterMap();
                    if (map.isEmpty()) {
                        filterChain.doFilter(request, response);
                        return;
                    }
                    Map<String, String[]> parameterMap = new LinkedHashMap<>();
                    for (String key : map.keySet()) {
                        String[] value = map.get(key);
                        String result = Arrays.toString(value);
                        //解密
                        String decrypt = AESUtils.decrypt(result, SECRET);
                        if (decrypt == null) {
                            parameterMap.put(key, value);
                        } else {
                            parameterMap.put(key, new String[]{decrypt});
                        }
                    }
                    //重构request
                    DecryptHttpWrapper wrapper = new DecryptHttpWrapper(request, parameterMap);
                    filterChain.doFilter(wrapper, response);
                } else if ("POST".equals(method)) {
                    ServletInputStream is = request.getInputStream();
                    ByteArrayOutputStream out = new ByteArrayOutputStream();
                    byte[] b = new byte[4096];
                    int n = 0;
                    while ((n = is.read(b)) > 0) {
                        out.write(b, 0, n);
                    }

                    //解密 解密 plainBody是未解密的参数串
                    String plainBody = out.toString();
                    log.info("现在的参数是：" + plainBody);
                    if (StringUtils.isEmpty(plainBody)) {
                        filterChain.doFilter(request, response);
                        return;
                    }
                    Map<String, Object> hashMap = JSON.parseObject(plainBody, HashMap.class);
                    Map<String, Object> resultMap = new HashMap<>();
                    String result = null;
                    for (Map.Entry<String, Object> entry : hashMap.entrySet()) {
                        Object value = entry.getValue();
                        //解密 重新
                        result = AESUtils.decrypt((String) value, SECRET);

                        resultMap = JSON.parseObject(result, HashMap.class);
                    }
                    String jsonString = JSON.toJSONString(resultMap);
                    //重构request
                    DecryptHttpServletWrapper wrapper = new DecryptHttpServletWrapper(request, jsonString);
                    filterChain.doFilter(wrapper, response);
                } else {
                    filterChain.doFilter(request, response);
                }
            }
        } else {
            filterChain.doFilter(request, response);
        }
    }
}
