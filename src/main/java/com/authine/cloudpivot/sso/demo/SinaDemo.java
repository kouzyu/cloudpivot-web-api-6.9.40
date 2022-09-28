package com.authine.cloudpivot.sso.demo;

import cn.hutool.http.Method;
import com.authine.cloudpivot.web.sso.template.ResponseTypeEnum;
import com.authine.cloudpivot.web.sso.template.SimpleOAuth2Template;
import com.authine.cloudpivot.web.sso.template.SimpleTemplateConfig;
import org.springframework.http.HttpMethod;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

//@Component
public class SinaDemo extends SimpleOAuth2Template {
    SinaDemo() {
        super(SimpleTemplateConfig.builder()
                .requestMatcher(new AntPathRequestMatcher("/login/sina", HttpMethod.GET.name()))
                .clientId("4168894022")
                .clientSecret("33210f6273fab5f31cfe8d78b33c805b")
                .redirectUri("http://3500c.free.idcfengye.com/login/sina")
                .grantType("authorization_code")
                .apiMethod(Method.POST)
                .accessTokenUrl("https://api.weibo.com/oauth2/access_token")
                .userSourceUrl("https://api.weibo.com/oauth2/get_token_info")
                .thirdpartyUserIdCode("uid")
                .responseType(ResponseTypeEnum.JSON)
                //会回调http://127.0.0.1/oauth地址然后把SSO的code传过去   如http://127.0.0.1/oauth?code=pOQrft    需要前端拿code获取SSO的token
                .loginPassredirectUrl("http://127.0.0.1:8888/oauth/authorize?client_id=api&response_type=code&scope=read&redirect_uri=http://127.0.0.1/oauth")
                .mobile(true)
                .redirectClientID("api")
                .build());
        //获取accessToken或获取用户对应SourceID接口可额外添加参数
//        Map<String,Object> param = new HashMap<>();
//        param.put("client_id",config.getClientId());
//        param.put("client_secret",config.getClientSecret());
//        config.setUserInfoRequestParam(param);
    }

}
