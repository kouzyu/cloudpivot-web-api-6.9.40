package com.authine.cloudpivot.sso.demo;//package com.authine.cloudpivot.web.sso.template.demo;
//
//import cn.hutool.http.HttpUtil;
//import com.authine.cloudpivot.web.sso.exception.AccessTokenInvalidateException;
//import com.authine.cloudpivot.web.sso.template.ResponseTypeEnum;
//import com.authine.cloudpivot.web.sso.template.SimpleOAuth2Template;
//import com.authine.cloudpivot.web.sso.template.SimpleTemplateConfig;
//import lombok.extern.slf4j.Slf4j;
//import net.sf.json.JSONObject;
//import org.apache.commons.lang3.StringUtils;
//import org.springframework.http.HttpMethod;
//import org.springframework.security.crypto.factory.PasswordEncoderFactories;
//import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
//import org.springframework.stereotype.Component;
//
//import java.util.HashMap;
//import java.util.Map;
//
//
//@Component
//@Slf4j
//public class WeChatSecurityLogin extends SimpleOAuth2Template {
//    WeChatSecurityLogin() {
//
//        super(SimpleTemplateConfig.builder()
//                .requestMatcher(new AntPathRequestMatcher("/login/wechat", HttpMethod.GET.name()))
//                //验证通过后选择通过回调还是直接返回带token json串的方式
//                .responseType(ResponseTypeEnum.JSON)
//                //选择回调的话需要添加loginPassredirectUrl 会回调http://127.0.0.1/oauth地址然后把SSO的code传过去   如http://127.0.0.1/oauth?code=pOQrft    需要前端拿code获取SSO的token
////                .loginPassredirectUrl("http://127.0.0.1:8888/oauth/authorize?client_id=api&response_type=code&scope=read&redirect_uri=http://127.0.0.1/oauth")  //？
//                .mobile(true)       //是否手机登录
//                .redirectClientID("api")    //云枢OAuth2登录的ClientId  具体体现在base_security_client表中
//                .build());
//
//    }
//
//    /**
//     * 调用微信接口获取accessToken
//     *   https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=ID&corpsecret=SECRET
//     *   corpid ：配置在 Constants.WECHAT_CORPID
//     *   corpsecret： Constants.WECHAT_SERCRET
//     * @param code
//     * @return
//     * @throws Exception
//     */
//    @Override
//    public String getAccessToken(String code) throws Exception {
//        log.info("进入getAccessToken方法，参数code为：" + code);
//        Map<String,Object> param = new HashMap<>();
//        PasswordEncoderFactories.createDelegatingPasswordEncoder().matches()
//        //企业微信的CORPID
//        param.put("corpid","XXXXXXXX");
//        //微信对应secret
//        param.put("corpsecret","XXXXXXXXXXXXXXXXXXXXXXXXXX");
//        String response =HttpUtil.get("https://qyapi.weixin.qq.com/cgi-bin/gettoken", param);
//        JSONObject jsonObject = JSONObject.fromObject(response);
//        log.info("获取accessToken响应: "+response);
//        String token = jsonObject.get("access_token")==null?null:String.valueOf(jsonObject.get("access_token"));
//
//        if (StringUtils.isBlank(token)) {
//            log.warn("获取accessToken失败，错误信息：" + response);
//            throw new AccessTokenInvalidateException(" accessToken 非法");
//        }
//        log.info("获取Token成功: {}", token);
//        log.info("------------------getAccessToken end ----------------------------" );
//        return token;
//    }
//
//    /**
//     * 获取调用微信接口获取企业微信和云枢的关联字段userId，根据企业微信返回的UserId去云枢查询有没有对应用户
//     *  微信接口URL：https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=ACCESS_TOKEN&code=CODE
//     *  code： 通过成员授权获取到的code，最大为512字节。每次成员授权带上的code将不一样，code只能使用一次，5分钟未被使用自动过期。
//     *  API ：https://work.weixin.qq.com/api/doc#90000/90135/91023
//     * @param code
//     * @return
//     * @throws Exception
//     */
//    @Override
//    public String getSourceId(String code) throws Exception {
//        String accessToken = getAccessToken(code);
//        Map<String,Object> param = new HashMap<>(4);
//        param.put("access_token",accessToken);
//        param.put("code",code);
//        String response = HttpUtil.get("https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo", param);
//        log.info("返回结果： " + response);
//        JSONObject jsonObject = JSONObject.fromObject(response);
//        String sourceId = jsonObject.get("UserId")==null?null:String.valueOf(jsonObject.get("UserId"));
//        if(StringUtils.isBlank(sourceId)){
//            sourceId = jsonObject.get("OpenId")==null?null:String.valueOf(jsonObject.get("OpenId"));
//        }
//        if (StringUtils.isBlank(sourceId)) {
//            log.warn("获取用户关联信息失败，失败响应："+response);
//        }
//        log.info("从企业微信获取的userId为：" + sourceId);
//        log.info("---------------------------getSourceId   end ---------------------------------");
//        return sourceId;
//    }
//
//}