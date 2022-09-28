package com.authine.cloudpivot.sso.demo;

import com.authine.cloudpivot.web.sso.dingtalk.SSODingTalkClientService;
import com.authine.cloudpivot.web.sso.template.ResponseTypeEnum;
import com.authine.cloudpivot.web.sso.template.SimpleOAuth2Template;
import com.authine.cloudpivot.web.sso.template.SimpleTemplateConfig;
import com.authine.cloudpivot.web.sso.view.ThreadLocalValue;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

//@Component
@Slf4j
public class DingTalkScanDemo extends SimpleOAuth2Template {
    @Autowired
    private SSODingTalkClientService dingTalkClientService;

    /**
     * 前端请求URL
     * https://oapi.dingtalk.com/connect/oauth2/sns_authorize?appid=dingoasofw2uxsuqmig9t8&response_type=code&scope=snsapi_login&state=STATE
     * &redirect_uri=http://127.0.0.1:8888/login/dingtalk?redirect_uri=http://127.0.0.1:8888/oauth/authorize?client_id=api&response_type=code&scope=read&redirect_uri=http://127.0.0.1/oauth
     * &login_fail_redirect_uri=http://127.0.0.1/login
     * &loginTmpCode=16b9aed9960333b5840bf17ecc109ff5
     * <p>
     * 钉钉通过以后会携带钉钉的code回调127.0.0.1:8888/login/dingtalk  在SSO以下的过滤验证身份通过后会重定向到127.0.0.1:8888/oauth/authorize中再做一次本地的OAuth2的授权流程，然后会携带code
     * 回调地址127.0.0.1/oauth （例：http://127.0.0.1/oauth?code=pOQrft） 然后需要前端页面拿到code后再向SSO请求一次accessToken
     * <p>
     * <p>
     * 钉钉扫码登录获取用户信息不需要accesstoken，所以直接覆盖getSourceId方法即可
     */

    DingTalkScanDemo() {
        super(SimpleTemplateConfig.builder()
                .requestMatcher(new AntPathRequestMatcher("/login/dingtalk/demo", HttpMethod.GET.name()))
                .responseType(ResponseTypeEnum.REDIRECT)
                //成功后回调地址   会优先从url中获取redirect_uri，login_fail_redirect_uri。若url中无法携带，可使用默认配置
                .loginPassredirectUrl("http://127.0.0.1:8888/oauth/authorize?client_id=api&response_type=code&scope=read&redirect_uri=http://127.0.0.1/oauth")
                .loginFailRedirectUri("http://127.0.0.1/login")
                .build());
    }

    @Override
    public String getSourceId(String code) throws Exception {
        log.info("-----------------------");
        log.info("使用模板方法");
        String corpId = ThreadLocalValue.localCorpId.get();
        return dingTalkClientService.getUserinfoByCode(code, corpId);
    }


}
