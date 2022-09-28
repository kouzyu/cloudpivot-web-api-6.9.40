package com.authine.cloudpivot.sso.demo;

import com.authine.cloudpivot.engine.api.model.organization.UserModel;
import com.authine.cloudpivot.web.sso.security.BaseAuthenticationToken;
import com.authine.cloudpivot.web.sso.template.BaseSimpleTemplate;
import com.authine.cloudpivot.web.sso.template.ResponseTypeEnum;
import com.authine.cloudpivot.web.sso.template.SimpleTemplateConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/**
 * 前端 xxxx/login/demo?code=UsernameOrMobile
 */
//@Component
@Slf4j
public class Demo extends BaseSimpleTemplate {
    Demo() {
        super(SimpleTemplateConfig.builder()
                .requestMatcher(new AntPathRequestMatcher("/login/demo", HttpMethod.GET.name()))
                .responseType(ResponseTypeEnum.JSON)
                .redirectClientID("api")    //云枢OAuth2登录的ClientId  具体体现在base_security_client表中
                //成功后回调地址   会优先从url中获取redirect_uri，login_fail_redirect_uri。若url中无法携带，可使用默认配置 http://120.24.79.179/admin/#/apps/model/harry/aaa/dispatcher 需要在后台添加白名单
                ///oauth/authorize?client_id=api&response_type=code&scope=read为固定
//                .loginPassredirectUrl("http://120.24.79.179/api/oauth/authorize?client_id=api&response_type=code&scope=read&redirect_uri=http://120.24.79.179/admin/#/apps/model/harry/aaa/dispatcher")
//                .loginFailRedirectUri("http://127.0.0.1/login")
                .build());
    }

    @Override
    public String getSourceId(BaseAuthenticationToken token) throws Exception {
        return token.getCode();
    }

    @Override
    public UserModel getUser(Object sourceId) {
        return dubboConfigService.getSystemSecurityFacade().getUserByUsernameOrMobile(String.valueOf(sourceId));
    }

}
