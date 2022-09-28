package com.authine.cloudpivot.web.api.config;

import com.authine.cloudpivot.engine.config.RedisStringHelper;
import com.authine.cloudpivot.web.sso.handler.CustomWebResponseExceptionTranslator;
import com.authine.cloudpivot.web.sso.security.SSOToken;
import com.authine.cloudpivot.web.sso.security.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.ClientDetailsService;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.code.AuthorizationCodeServices;
import org.springframework.security.oauth2.provider.code.RandomValueAuthorizationCodeServices;
import org.springframework.security.oauth2.provider.token.TokenEnhancerChain;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

@Configuration
@EnableAuthorizationServer
public class AuthorizationConfig extends AuthorizationServerConfigurerAdapter {

    public static final String CLOUDPIVOT_AUTHORIZATION_CODE_KEY_PREFIX = "cloudpivot:authorization:code:";
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private CustomWebResponseExceptionTranslator customWebResponseExceptionTranslator;

    @Autowired
    private ClientDetailsService clientDetailsService;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private SSOToken sSOToken;

    @Autowired
    private RedisConnectionFactory redisConnectionFactory;

    @Autowired
    private RedisStringHelper stringHelper;

    @Value("${cloudpivot.authorization.authorizationCode.redis.enabled:true}") // 默认开启
    private boolean authorizationCodeSharedInRedis;

    @Override
    @SuppressWarnings("unchecked")
    public void configure(AuthorizationServerEndpointsConfigurer endpoints) {
        final TokenEnhancerChain tokenEnhancerChain = new TokenEnhancerChain();
        tokenEnhancerChain.setTokenEnhancers(Collections.singletonList(sSOToken.authAccessTokenConverter()));
        endpoints
                .userDetailsService(userDetailsService)
                .tokenStore(sSOToken.authTokenStore())
                .tokenEnhancer(tokenEnhancerChain).reuseRefreshTokens(false)
                .authenticationManager(authenticationManager)
                .exceptionTranslator(customWebResponseExceptionTranslator);

        if (authorizationCodeSharedInRedis) {
            //集群时临时授权码需要共享存储(使用redis服务)
            endpoints.authorizationCodeServices(authorizationCodeServices(redisConnectionFactory));
        }
    }

    @Override
    public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
        clients.withClientDetails(clientDetailsService);
    }

    @Override
    public void configure(AuthorizationServerSecurityConfigurer security) {
        security.tokenKeyAccess("permitAll()")
                .checkTokenAccess("isAuthenticated()")
                .allowFormAuthenticationForClients();
    }

    private AuthorizationCodeServices authorizationCodeServices(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<String, OAuth2Authentication> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory);
        redisTemplate.setKeySerializer(stringHelper);
        redisTemplate.afterPropertiesSet();
        return new RandomValueAuthorizationCodeServices() {
            @Override
            protected void store(String code, OAuth2Authentication authentication) {
                redisTemplate.boundValueOps(CLOUDPIVOT_AUTHORIZATION_CODE_KEY_PREFIX + code).set(authentication, 5, TimeUnit.MINUTES);
            }

            @Override
            protected OAuth2Authentication remove(String code) {
                OAuth2Authentication authentication = redisTemplate.boundValueOps(CLOUDPIVOT_AUTHORIZATION_CODE_KEY_PREFIX + code).get();
                redisTemplate.delete(code);
                return authentication;
            }
        };
    }
}
