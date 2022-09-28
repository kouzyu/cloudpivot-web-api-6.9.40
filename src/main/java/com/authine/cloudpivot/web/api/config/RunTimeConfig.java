package com.authine.cloudpivot.web.api.config;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;

@Slf4j
@Getter
public enum RunTimeConfig {
    INSTANCE;
    private boolean isOpenSkyWalkingAgent;

    RunTimeConfig() {
        init();
    }

    public void init() {
        RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
        java.util.List<String> inputArguments = runtimeMXBean.getInputArguments();
        for (String inputArgument : inputArguments) {
            if (inputArgument.startsWith("-javaagent")) {
                try {
                    String param = inputArgument.substring(inputArgument.indexOf(":") + 1);
                    if (StringUtils.isNotBlank(param) && param.contains("skywalking-agent.jar")) {
                        isOpenSkyWalkingAgent = true;
                        return;
                    }
                } catch (Exception e) {
                    log.error(e.getMessage(), e);
                }
            }
        }
    }
}
