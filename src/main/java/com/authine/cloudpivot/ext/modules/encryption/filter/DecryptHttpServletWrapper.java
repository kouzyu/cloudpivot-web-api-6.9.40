package com.authine.cloudpivot.ext.modules.encryption.filter;

import org.apache.commons.lang3.StringUtils;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

public class DecryptHttpServletWrapper extends HttpServletRequestWrapper {

    private String bodyJsonStr;

    public DecryptHttpServletWrapper(HttpServletRequest request, String bodyJsonStr) {
        super(request);
        this.bodyJsonStr = bodyJsonStr;
    }


    @Override
    public ServletInputStream getInputStream() throws IOException {
        if (StringUtils.isEmpty(bodyJsonStr)) {
            bodyJsonStr = "";
        }
        final ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bodyJsonStr.getBytes("utf-8"));
        ServletInputStream servletInputStream = new ServletInputStream() {
            @Override
            public boolean isFinished() {
                return false;
            }

            @Override
            public boolean isReady() {
                return false;
            }

            @Override
            public void setReadListener(ReadListener readListener) {

            }

            @Override
            public int read() throws IOException {
                return byteArrayInputStream.read();
            }
        };
        return servletInputStream;
    }

    @Override
    public BufferedReader getReader() throws IOException {
        return new BufferedReader(new InputStreamReader(this.getInputStream()));
    }

    public String getBodyJsonStr() {
        return bodyJsonStr;
    }

    public void setBodyJsonStr(String bodyJsonStr) {
        this.bodyJsonStr = bodyJsonStr;
    }
}
