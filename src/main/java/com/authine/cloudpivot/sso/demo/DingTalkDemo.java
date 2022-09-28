package com.authine.cloudpivot.sso.demo;

import com.alibaba.fastjson.JSON;
import com.authine.cloudpivot.engine.api.constants.SystemConfigConstants;
import com.authine.cloudpivot.engine.api.exceptions.ServiceException;
import com.authine.cloudpivot.engine.api.model.system.SystemSettingModel;
import com.authine.cloudpivot.engine.enums.ErrCode;
import com.authine.cloudpivot.engine.enums.type.SettingType;
import com.authine.cloudpivot.web.sso.config.Constants;
import com.authine.cloudpivot.web.sso.exception.AccessTokenInvalidateException;
import com.authine.cloudpivot.web.sso.exception.UserException;
import com.authine.cloudpivot.web.sso.template.ResponseTypeEnum;
import com.authine.cloudpivot.web.sso.template.SimpleOAuth2Template;
import com.authine.cloudpivot.web.sso.template.SimpleTemplateConfig;
import com.dingtalk.api.DefaultDingTalkClient;
import com.dingtalk.api.DingTalkClient;
import com.dingtalk.api.request.OapiGettokenRequest;
import com.dingtalk.api.request.OapiUserGetuserinfoRequest;
import com.dingtalk.api.response.OapiGettokenResponse;
import com.dingtalk.api.response.OapiUserGetuserinfoResponse;
import com.google.common.base.Strings;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

//@Component
@Slf4j
public class DingTalkDemo extends SimpleOAuth2Template {
    DingTalkDemo() {
        super(SimpleTemplateConfig.builder()
                .requestMatcher(new AntPathRequestMatcher("/login/mobile/ajax/demo", HttpMethod.GET.name()))
                .responseType(ResponseTypeEnum.JSON)
                .redisTokenKey("ding_talk_access_token")
                .redisTicketKey("ding_talk_ticker")
                .build());
    }

    private Map<String, String> getSystemConfig() {
        List<SystemSettingModel> systemSettingModels = dubboConfigService.getSystemManagementFacade()
                .getSystemSettingsBySettingTypes(ImmutableList.of(SettingType.DINGTALK_BASE, SettingType.DINGTALK_SYN, SettingType.DINGTALK_PORTAL));
        if (log.isDebugEnabled()) {
            log.debug("获取到系统配置的信息为{}", JSON.toJSONString(systemSettingModels));
        }
        if (CollectionUtils.isEmpty(systemSettingModels)) {
            log.error("钉钉集成参数未配置");
            throw new ServiceException(ErrCode.DING_TALK_CONFIG_EMPTY);
        }
        Map<String, String> systemConfig = Maps.newHashMap();
        systemSettingModels.forEach(setting -> systemConfig.put(setting.getSettingCode(), setting.getSettingValue()));
        return systemConfig;
    }

    @Override
    public String getAccessToken(String code) throws Exception {
        String accessToken = redisTemplate.opsForValue().get(config.getRedisTokenKey());
        if (!StringUtils.isEmpty(accessToken)) {
            if (log.isDebugEnabled()) {
                log.debug("缓存 accessToken 存在使用缓存 accessToken：{}", accessToken);
            }
            return accessToken;
        }
        DingTalkClient client = new DefaultDingTalkClient(Constants.DING_GET_TOKEN_URL);
        OapiGettokenRequest oapiGettokenRequest = new OapiGettokenRequest();
        String appkey = getSystemConfig().get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPKEY);
        String appsecret = getSystemConfig().get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPSECRET);
        oapiGettokenRequest.setAppkey(appkey);
        oapiGettokenRequest.setAppsecret(appsecret);
        oapiGettokenRequest.setHttpMethod(HttpMethod.GET.name());

        OapiGettokenResponse response = null;
        response = client.execute(oapiGettokenRequest);
        if (Strings.isNullOrEmpty(response.getAccessToken())) {
            throw new AccessTokenInvalidateException(" accessToken 非法");
        }
        if (response.isSuccess()) {
            log.info("获取钉钉Token成功");
            // 设置redis缓存
            redisTemplate.opsForValue().set(config.getRedisTokenKey(), response.getAccessToken(),
                    response.getExpiresIn(), TimeUnit.SECONDS);
            return response.getAccessToken();
        }
        log.warn("获取钉钉Token失败，错误信息：{}", response.getErrmsg());

        throw new ServiceException(response.getErrcode(), response.getErrmsg());
    }

    @Override
    public String getSourceId(String code) throws Exception {
        DingTalkClient client = new DefaultDingTalkClient(Constants.DING_GET_USER_INFO_URL);
        OapiUserGetuserinfoRequest request = new OapiUserGetuserinfoRequest();
        request.setCode(code);
        request.setHttpMethod(HttpMethod.GET.name());
        OapiUserGetuserinfoResponse response = client.execute(request, this.getAccessToken(code));
        String userId = response.getUserid();
        if (Strings.isNullOrEmpty(userId)) {
            log.error(response.getErrmsg());
            throw new UserException("获取钉钉用户信息失败");
        }
        return userId;
    }


}
