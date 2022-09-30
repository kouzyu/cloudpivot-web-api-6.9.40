package com.authine.cloudpivot.web.api.controller.system;

import cn.hutool.crypto.asymmetric.RSA;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.model.PutObjectResult;
import com.authine.cloudpivot.engine.api.constants.SystemConfigConstants;
import com.authine.cloudpivot.engine.api.facade.DingTalkFacade;
import com.authine.cloudpivot.engine.api.facade.FileStoreFacade;
import com.authine.cloudpivot.engine.api.facade.OrganizationFacade;
import com.authine.cloudpivot.engine.api.model.application.AppFunctionModel;
import com.authine.cloudpivot.engine.api.model.application.AppPackageModel;
import com.authine.cloudpivot.engine.api.model.bizmodel.BizPermGroupModel;
import com.authine.cloudpivot.engine.api.model.bizmodel.BizPermPropertyModel;
import com.authine.cloudpivot.engine.api.model.bizmodel.BizPropertyModel;
import com.authine.cloudpivot.engine.api.model.bizmodel.BizSchemaModel;
import com.authine.cloudpivot.engine.api.model.organization.DepartmentModel;
import com.authine.cloudpivot.engine.api.model.organization.RoleGroupModel;
import com.authine.cloudpivot.engine.api.model.organization.RoleModel;
import com.authine.cloudpivot.engine.api.model.organization.UserModel;
import com.authine.cloudpivot.engine.api.model.permission.*;
import com.authine.cloudpivot.engine.api.model.system.AdminModel;
import com.authine.cloudpivot.engine.api.model.system.RelatedCorpSettingModel;
import com.authine.cloudpivot.engine.api.model.system.SystemSettingModel;
import com.authine.cloudpivot.engine.api.model.system.UserGuideModel;
import com.authine.cloudpivot.engine.api.utils.oss.OssConfigVO;
import com.authine.cloudpivot.engine.enums.ErrCode;
import com.authine.cloudpivot.engine.enums.status.UserStatus;
import com.authine.cloudpivot.engine.enums.type.*;
import com.authine.cloudpivot.engine.service.utils.oss.OSSClient;
import com.authine.cloudpivot.engine.service.utils.sftp.SFTPClient;
import com.authine.cloudpivot.web.api.cache.RedisCacheService;
import com.authine.cloudpivot.web.api.controller.base.BaseController;
import com.authine.cloudpivot.web.api.controller.orgnization.SelectionHelper;
import com.authine.cloudpivot.web.api.enums.PermSourceType;
import com.authine.cloudpivot.web.api.exception.PortalException;
import com.authine.cloudpivot.web.api.exception.ResultEnum;
import com.authine.cloudpivot.web.api.handler.CustomizedOrigin;
import com.authine.cloudpivot.web.api.helper.AppPermHelper;
import com.authine.cloudpivot.web.api.util.AuthUtils;
import com.authine.cloudpivot.web.api.view.PageVO;
import com.authine.cloudpivot.web.api.view.ResponseResult;
import com.authine.cloudpivot.web.api.view.app.PermVo;
import com.authine.cloudpivot.web.api.view.runtime.DepartmentUnitVO;
import com.authine.cloudpivot.web.api.view.system.*;
import com.dingtalk.api.response.OapiAuthScopesResponse;
import com.dingtalk.api.response.OapiGettokenResponse;
import com.dingtalk.api.response.OapiMessageCorpconversationAsyncsendV2Response;
import com.google.common.base.Splitter;
import com.google.common.base.Strings;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.taobao.api.ApiException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import javax.crypto.Cipher;
import javax.validation.constraints.NotNull;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.authine.cloudpivot.engine.api.constants.Constants.EXTERNAL_USER_ID;
import static com.authine.cloudpivot.engine.enums.type.NodeType.BizModel;

@Api(tags = "系统管理::常规配置")
@RestController
@RequestMapping("/api/system")
@Slf4j
@Validated
@CustomizedOrigin(level = 0)
public class SystemAdminController extends BaseController {

    public static final String IS_CLOUD_PIVOT_KEY = "cloudpivot.load.is_cloud_pivot";
    @Autowired
    private RedisCacheService redisCacheService;
    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private OSSClient ossClient;
    @Autowired
    private SFTPClient sftpClient;
    @Autowired
    private FileStoreFacade fileStoreFacade;
    @Autowired
    private SelectionHelper selectionHelper;

    @Value("${cloudpivot.attachment.sftp.enabled:false}")
    private boolean sftpEnable;
    @Value("${cloudpivot.attachment.oss.enabled:false}")
    private boolean ossEnabled;

    @ApiOperation(value = "加载钉钉集成", notes = "加载钉钉集成")
    @GetMapping("/get_dingtalk_integration")
    public ResponseResult<Map<String, String>> getDingTalkIntegration() {
        List<SystemSettingModel> models = getSystemManagementFacade().
                getSystemSettingsBySettingTypes(ImmutableList.of(SettingType.DINGTALK_BASE, SettingType.DINGTALK_SYN));

        if (CollectionUtils.isEmpty(models)) {
            return getOkResponseResult(null, "加载钉钉集成成功");
        }
        String userId = getUserId();
        UserModel user = getOrganizationFacade().getUser(userId);
        Map<String, String> map = Maps.newHashMap();
        Map<String, String> systemSettings = models.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, SystemSettingModel::getSettingValue));
        map.put("appKey", systemSettings.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPKEY));
        if (ADMIN.equals(user.getUsername())) {
            map.put("appSecret", systemSettings.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPSECRET));
        } else {
            map.put("appSecret", null);
        }
        map.put("agentId", systemSettings.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_AGENTID));
        map.put("pcServerUrl", systemSettings.get(SystemConfigConstants.DINGTALK_PC_SERVERURL));
        map.put("mobileServerUrl", systemSettings.get(SystemConfigConstants.DINGTALK_MOBILE_SERVERURL));

        //加载增量同步的回调地址 V1.16.0
        map.put(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI, systemSettings.get(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI));

        return getOkResponseResult(map, "加载钉钉集成成功");
    }

    @ApiOperation(value = "保存钉钉集成", notes = "保存钉钉集成")
    @Deprecated
    @PostMapping("/save_dingtalk_integration")
    public ResponseResult<Boolean> saveDingTalkIntegration(@RequestBody DingTalkVO dingTalk) {

        validateNotEmpty(dingTalk.getAppKey(), "应用key不能为空.");
        validateNotEmpty(dingTalk.getAppSecret(), "应用密钥不能为空.");
        validateNotEmpty(dingTalk.getAgentId(), "AgentId不能为空");
        validateNotEmpty(dingTalk.getPcServerUrl(), "PC端首页地址不能为空");
        validateNotEmpty(dingTalk.getSynRedirectUri(), "钉钉增量同步地址不能为空");

        dingTalk.setAppKey(dingTalk.getAppKey().trim());
        dingTalk.setAppSecret(dingTalk.getAppSecret().trim());
        dingTalk.setAgentId(dingTalk.getAgentId().trim());
        dingTalk.setPcServerUrl(dingTalk.getPcServerUrl().trim());
        dingTalk.setSynRedirectUri(dingTalk.getSynRedirectUri().trim());

        dingTalk.setMobileServerUrl(Optional.ofNullable(dingTalk.getMobileServerUrl()).orElse("").trim());
        List<SystemSettingModel> models = getSystemManagementFacade().
                getSystemSettingsBySettingTypes(ImmutableList.of(SettingType.DINGTALK_BASE, SettingType.DINGTALK_SYN));
        // 查询出钉钉配置，进行更新或保存
        if (setDingTalkIntegration(dingTalk, models)) {
            return getOkResponseResult(Boolean.TRUE, "成功保存钉钉集成的配置参数");
        } else {
            return getOkResponseResult(Boolean.FALSE, "保存钉钉集成的配置参数失败");
        }
    }

    @ApiOperation(value = "连接测试钉钉集成", notes = "连接测试钉钉集成")
    @PostMapping("/check_dingtalk_integration")
    public ResponseResult<Boolean> checkDingTalkIntegration(@RequestBody DingTalkVO dingTalk) {
        validateNotEmpty(dingTalk.getAppKey(), "应用key不能为空.");
        validateNotEmpty(dingTalk.getAppSecret(), "应用密钥不能为空.");
        validateNotEmpty(dingTalk.getAgentId(), "AgentId不能为空");
        validateNotEmpty(dingTalk.getPcServerUrl(), "PC端首页地址不能为空");
        validateNotEmpty(dingTalk.getSynRedirectUri(), "钉钉增量同步地址不能为空");

        dingTalk.setAppKey(dingTalk.getAppKey().trim());
        dingTalk.setAppSecret(dingTalk.getAppSecret().trim());
        dingTalk.setAgentId(dingTalk.getAgentId().trim());
        dingTalk.setPcServerUrl(dingTalk.getPcServerUrl().trim());
        dingTalk.setMobileServerUrl(dingTalk.getMobileServerUrl().trim());
        dingTalk.setSynRedirectUri(dingTalk.getSynRedirectUri().trim());

        String userId = getUserId();
        UserModel user = getOrganizationFacade().getUser(userId);
        if (user == null) {
            throw new PortalException(ErrCode.ORG_USER_NONEXISTENT);
        }
        if (log.isDebugEnabled()) {
            log.debug("userId = {}, user = {}", userId, JSONObject.toJSONString(user));
        }

        // 校验appKey、appSecret
        OapiGettokenResponse appKeyAndSercretResponse = validateIdAndSecret(dingTalk.getCorpId(), dingTalk.getCorpSecret(), dingTalk.getAppKey(), dingTalk.getAppSecret());
        String accessToken = "";
        if (appKeyAndSercretResponse.isSuccess()) {
            accessToken = appKeyAndSercretResponse.getAccessToken();
        }
        if (log.isDebugEnabled()) {
            log.debug("accessToken = {}", accessToken);
        }
        // 校验agentId、pcServerUrl
        validateAgentId(userId, accessToken, dingTalk.getCorpId(), dingTalk.getAgentId(), dingTalk.getPcServerUrl(), dingTalk.getMobileServerUrl());

        // 检验通讯录权限
        OapiAuthScopesResponse response = validateSeniorContactAuth(accessToken, dingTalk.getCorpId());

        List<String> authUserField = response.getAuthUserField();

        Iterator<String> iterator = authUserField.iterator();

        boolean mobile = false;
        while (iterator.hasNext()) {
            boolean bo = Objects.equals(iterator.next(), "mobile");
            if (bo) {
                mobile = true;
            }
        }
        if (!mobile) {
            throw new PortalException(ErrCode.SYS_MOBILE_ERROR, "连接测试失败，请前往钉钉后台开通手机号码权限");
        }
//        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingTypes(ImmutableList.of(
//                SettingType.DINGTALK_BASE, SettingType.DINGTALK_PORTAL, SettingType.DINGTALK_SYN));
//        if (!setDingTalkIntegration(dingTalk, models)) {
//            throw new PortalException(ErrCode.SYS_PARAMETER_ERROR, "测试钉钉前先保存时失败..");
//        }

        return getOkResponseResult(Boolean.TRUE, "连接测试钉钉集成成功");
    }

    /**
     * 保存或更新钉钉集成的配置
     *
     * @param dingTalk 钉钉对象
     * @param models   配置
     * @return boolean
     */
    private boolean setDingTalkIntegration(DingTalkVO dingTalk, List<SystemSettingModel> models) {
        // 直接保存
        if (CollectionUtils.isEmpty(models)) {
            SystemSettingModel appKey = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPKEY, dingTalk.getAppKey(), SettingType.DINGTALK_BASE);
            SystemSettingModel appSecret = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPSECRET, dingTalk.getAppSecret(), SettingType.DINGTALK_BASE);
            SystemSettingModel agentId = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_AGENTID, dingTalk.getAgentId(), SettingType.DINGTALK_BASE);
            SystemSettingModel pcServerUrl = new SystemSettingModel(SystemConfigConstants.DINGTALK_PC_SERVERURL, dingTalk.getPcServerUrl(), SettingType.DINGTALK_BASE);
            SystemSettingModel mobileServerUrl = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_SERVERURL, dingTalk.getMobileServerUrl(), SettingType.DINGTALK_BASE);
            SystemSettingModel synRedirectUri = new SystemSettingModel(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI, dingTalk.getSynRedirectUri(), SettingType.DINGTALK_SYN);

            getSystemManagementFacade().addSystemSetting(appKey);
            getSystemManagementFacade().addSystemSetting(appSecret);
            getSystemManagementFacade().addSystemSetting(agentId);
            getSystemManagementFacade().addSystemSetting(pcServerUrl);
            getSystemManagementFacade().addSystemSetting(mobileServerUrl);
            getSystemManagementFacade().addSystemSetting(synRedirectUri);
            return Boolean.TRUE;
        }
        Map<String, SystemSettingModel> systemSettingsMap = models.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, Function.identity()));
        if (log.isDebugEnabled()) {
            log.debug("SystemSettingModel = {}", toJson(models));
        }
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPKEY) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPKEY).setSettingValue(dingTalk.getAppKey());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPKEY));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPKEY, dingTalk.getAppKey(), SettingType.DINGTALK_BASE);
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPSECRET) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPSECRET).setSettingValue(dingTalk.getAppSecret());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPSECRET));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_APPSECRET, dingTalk.getAppSecret(), SettingType.DINGTALK_BASE);
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_AGENTID) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_AGENTID).setSettingValue(dingTalk.getAgentId());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_AGENTID));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_LOGIN_AGENTID, dingTalk.getAgentId(), SettingType.DINGTALK_BASE);
            getSystemManagementFacade().addSystemSetting(model);
        }

        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_PC_SERVERURL) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_PC_SERVERURL).setSettingValue(dingTalk.getPcServerUrl());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_PC_SERVERURL));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_PC_SERVERURL, dingTalk.getPcServerUrl(), SettingType.DINGTALK_BASE);
            getSystemManagementFacade().addSystemSetting(model);
        }

        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_SERVERURL) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_SERVERURL).setSettingValue(dingTalk.getMobileServerUrl());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_MOBILE_SERVERURL));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_MOBILE_SERVERURL, dingTalk.getMobileServerUrl(), SettingType.DINGTALK_BASE);
            getSystemManagementFacade().addSystemSetting(model);
        }

        //保存增量同步的回调地址 V1.16.0
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI).setSettingValue(dingTalk.getSynRedirectUri());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI, dingTalk.getSynRedirectUri(), SettingType.DINGTALK_SYN);
            getSystemManagementFacade().addSystemSetting(model);
        }
        return Boolean.TRUE;
    }

    @ApiOperation(value = "配置家校通讯录是否有效", notes = "配置家校通讯录是否有效")
    @GetMapping("/setSynHomeSchollEnable")
    public ResponseResult<Boolean> setSynHomeSchollEnable(@RequestParam Boolean enable) {

        SystemSettingModel systemSettingModel = getSystemManagementFacade().getSystemSettingBySettingCode(SystemConfigConstants.DING_IS_SYN_EDU);
        if (systemSettingModel == null) {
            systemSettingModel = new SystemSettingModel();
            systemSettingModel.setChecked(Boolean.FALSE);
            systemSettingModel.setSettingCode(SystemConfigConstants.DING_IS_SYN_EDU);
            systemSettingModel.setSettingValue(String.valueOf(enable));
        } else {
            systemSettingModel.setSettingValue(String.valueOf(enable));
        }
        systemSettingModel.setSettingType(SettingType.DINGTALK_BASE);
        getSystemManagementFacade().addSystemSetting(systemSettingModel);
        return getOkResponseResult(Boolean.TRUE, "配置成功");
    }

    @ApiOperation(value = "加载增量同步的回调地址", notes = "加载增量同步的回调地址")
    @GetMapping("/get_syn_redirect_uri")
    public ResponseResult<Map<String, String>> getSynRedirectUri() {
        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.DINGTALK_SYN);
        if (CollectionUtils.isEmpty(models)) {
            return getOkResponseResult(null, "加载增量同步的回调地址成功");
        }
        Map<String, String> map = Maps.newHashMap();
        Map<String, String> systemSettings = models.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, SystemSettingModel::getSettingValue));
        map.put(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI, systemSettings.get(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI));
        return getOkResponseResult(map, "加载增量同步的回调地址成功");
    }

    @ApiOperation(value = "保存增量同步的回调地址", notes = "保存增量同步的回调地址")
    @PostMapping("/save_syn_redirect_uri")
    @ApiImplicitParam(name = "params", value = "{\"synRedirectUri\":\"xxx\"}", required = true, dataType = "Map")
    public ResponseResult<Boolean> saveSynRedirectUri(@RequestBody Map<String, String> params) {
        String synRedirectUri = params.get("synRedirectUri");
        validateNotEmpty(synRedirectUri, "地址不能为空");
        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.DINGTALK_SYN);
        if (CollectionUtils.isEmpty(models)) {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI, synRedirectUri.trim(), SettingType.DINGTALK_SYN);
            getSystemManagementFacade().addSystemSetting(model);
        } else {
            for (SystemSettingModel model : models) {
                if (SystemConfigConstants.DINGTALK_SYN_REDIRECT_URI.equals(model.getSettingCode())) {
                    model.setSettingValue(synRedirectUri);
                    getSystemManagementFacade().updateSystemSetting(model);
                    break;
                }
            }
        }
        return getOkResponseResult(Boolean.TRUE, "保存增量同步的回调地址成功");
    }

    @ApiOperation(value = "加载门户访问配置", notes = "加载门户访问配置")
    @GetMapping("/get_portal_config")
    public ResponseResult<Map<String, String>> getPortalConfig() {
        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.DINGTALK_PORTAL);
        if (CollectionUtils.isEmpty(models)) {
            return getOkResponseResult(null, "加载门户访问配置成功");
        }
        String userId = getUserId();
        UserModel user = getOrganizationFacade().getUser(userId);
        Map<String, String> map = Maps.newHashMap();
        Map<String, String> systemSettings = models.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, SystemSettingModel::getSettingValue));
        if (ADMIN.equals(user.getUsername())) {
            map.put("corpSecret", systemSettings.get(SystemConfigConstants.DINGTALK_CORPSECRET));
            map.put("scanAppSecret", systemSettings.get(SystemConfigConstants.DINGTALK_SCAN_APPSECRET));
        } else {
            map.put("corpSecret", null);
            map.put("scanAppSecret", null);
        }
        map.put("corpId", systemSettings.get(SystemConfigConstants.DINGTALK_CORPID));
        map.put("scanAppId", systemSettings.get(SystemConfigConstants.DINGTALK_SCAN_APPID));
        map.put(SystemConfigConstants.DINGTALK_REDIRECT_URI, systemSettings.get(SystemConfigConstants.DINGTALK_REDIRECT_URI));
        map.put(SystemConfigConstants.DINGTALK_SSO_SERVERURL, systemSettings.get(SystemConfigConstants.DINGTALK_SSO_SERVERURL));
        map.put(SystemConfigConstants.DINGTALK_ADMIN_SERVERURL, systemSettings.get(SystemConfigConstants.DINGTALK_ADMIN_SERVERURL));
        return getOkResponseResult(map, "加载门户访问配置成功");
    }

    @ApiOperation(value = "保存门户访问配置", notes = "保存门户访问配置")
    @PostMapping("/save_portal_config")
    public ResponseResult<Boolean> savePortalConfig(@RequestBody DingTalkVO dingTalk) {
        validateNotEmpty(dingTalk.getCorpId(), "CorpId不能为空.");
        validateNotEmpty(dingTalk.getCorpSecret(), "SSOSecret不能为空.");
        validateNotEmpty(dingTalk.getScanAppId(), "门户访问配置 应用id不能为空.");
        validateNotEmpty(dingTalk.getScanAppSecret(), "门户访问配置 应用密钥不能为空.");

        dingTalk.setCorpId(dingTalk.getCorpId().trim());
        dingTalk.setCorpSecret(dingTalk.getCorpSecret().trim());
        dingTalk.setScanAppId(dingTalk.getScanAppId().trim());
        dingTalk.setScanAppSecret(dingTalk.getScanAppSecret().trim());

        dingTalk.setRedirectUri(Optional.ofNullable(dingTalk.getRedirectUri()).orElse("").trim());
        dingTalk.setSsoServerUrl(Optional.ofNullable(dingTalk.getSsoServerUrl()).orElse("").trim());
        dingTalk.setAdminServerUrl(Optional.ofNullable(dingTalk.getAdminServerUrl()).orElse("").trim());


        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.DINGTALK_PORTAL);
        // 查询出门户访问配置，进行更新或保存
        if (setPortalConfig(dingTalk, models)) {
            return getOkResponseResult(Boolean.TRUE, "成功保存门户访问配置参数");
        } else {
            return getOkResponseResult(Boolean.FALSE, "保存门户访问配置参数失败");
        }
    }

    /**
     * 保存或更新门户访问配置
     *
     * @param dingTalk 钉钉对象
     * @param models   配置
     * @return boolean
     */
    private boolean setPortalConfig(DingTalkVO dingTalk, List<SystemSettingModel> models) {
        if (CollectionUtils.isEmpty(models)) { // 直接保存
            SystemSettingModel corpId = new SystemSettingModel(SystemConfigConstants.DINGTALK_CORPID, dingTalk.getCorpId(), SettingType.DINGTALK_PORTAL);
            SystemSettingModel corpSecret = new SystemSettingModel(SystemConfigConstants.DINGTALK_CORPSECRET, dingTalk.getCorpSecret(), SettingType.DINGTALK_PORTAL);
            SystemSettingModel scanAppId = new SystemSettingModel(SystemConfigConstants.DINGTALK_SCAN_APPID, dingTalk.getScanAppId(), SettingType.DINGTALK_PORTAL);
            SystemSettingModel scanAppSecret = new SystemSettingModel(SystemConfigConstants.DINGTALK_SCAN_APPSECRET, dingTalk.getScanAppSecret(), SettingType.DINGTALK_PORTAL);
            SystemSettingModel redirectUri = new SystemSettingModel(SystemConfigConstants.DINGTALK_REDIRECT_URI, dingTalk.getRedirectUri(), SettingType.DINGTALK_PORTAL);
            SystemSettingModel ssoServerUri = new SystemSettingModel(SystemConfigConstants.DINGTALK_SSO_SERVERURL, dingTalk.getSsoServerUrl(), SettingType.DINGTALK_PORTAL);
            SystemSettingModel adminServerUri = new SystemSettingModel(SystemConfigConstants.DINGTALK_ADMIN_SERVERURL, dingTalk.getAdminServerUrl(), SettingType.DINGTALK_PORTAL);

            getSystemManagementFacade().addSystemSetting(corpId);
            getSystemManagementFacade().addSystemSetting(corpSecret);
            getSystemManagementFacade().addSystemSetting(scanAppId);
            getSystemManagementFacade().addSystemSetting(scanAppSecret);
            getSystemManagementFacade().addSystemSetting(redirectUri);
            getSystemManagementFacade().addSystemSetting(ssoServerUri);
            getSystemManagementFacade().addSystemSetting(adminServerUri);
            return Boolean.TRUE;
        }
        Map<String, SystemSettingModel> systemSettingsMap = models.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, Function.identity()));
        if (log.isDebugEnabled()) {
            log.debug("saveOrUpdatePortalConfig = {}", toJson(models));
        }
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_CORPID) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_CORPID).setSettingValue(dingTalk.getCorpId());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_CORPID));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_CORPID, dingTalk.getCorpId(), SettingType.DINGTALK_PORTAL);
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_CORPSECRET) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_CORPSECRET).setSettingValue(dingTalk.getCorpSecret());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_CORPSECRET));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_CORPSECRET, dingTalk.getCorpSecret(), SettingType.DINGTALK_PORTAL);
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_SCAN_APPID) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_SCAN_APPID).setSettingValue(dingTalk.getScanAppId());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_SCAN_APPID));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_SCAN_APPID, dingTalk.getScanAppId(), SettingType.DINGTALK_PORTAL);
            getSystemManagementFacade().addSystemSetting(model);
        }

        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_SCAN_APPSECRET) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_SCAN_APPSECRET).setSettingValue(dingTalk.getScanAppSecret());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_SCAN_APPSECRET));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_SCAN_APPSECRET, dingTalk.getScanAppSecret(), SettingType.DINGTALK_PORTAL);
            getSystemManagementFacade().addSystemSetting(model);
        }

        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_REDIRECT_URI) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_REDIRECT_URI).setSettingValue(dingTalk.getRedirectUri());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_REDIRECT_URI));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_REDIRECT_URI, dingTalk.getRedirectUri(), SettingType.DINGTALK_PORTAL);
            getSystemManagementFacade().addSystemSetting(model);
        }

        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_SSO_SERVERURL) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_SSO_SERVERURL).setSettingValue(dingTalk.getSsoServerUrl());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_SSO_SERVERURL));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_SSO_SERVERURL, dingTalk.getRedirectUri(), SettingType.DINGTALK_PORTAL);
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(SystemConfigConstants.DINGTALK_ADMIN_SERVERURL) != null) {
            systemSettingsMap.get(SystemConfigConstants.DINGTALK_ADMIN_SERVERURL).setSettingValue(dingTalk.getAdminServerUrl());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(SystemConfigConstants.DINGTALK_ADMIN_SERVERURL));
        } else {
            SystemSettingModel model = new SystemSettingModel(SystemConfigConstants.DINGTALK_ADMIN_SERVERURL, dingTalk.getRedirectUri(), SettingType.DINGTALK_PORTAL);
            getSystemManagementFacade().addSystemSetting(model);
        }
        return Boolean.TRUE;
    }

    @ApiOperation(value = "测试连接门户访问配置", notes = "测试连接门户访问配置")
    @PostMapping("/check_portal_config")
    public ResponseResult<Boolean> checkPortalConfig(@RequestBody RelatedCorpSettingModel dingTalk) {
        validateNotEmpty(dingTalk.getCorpId(), "CorpId不能为空.");
        if (CorpRelatedType.DINGTALK == dingTalk.getRelatedType()) {
            validateNotEmpty(dingTalk.getCorpSecret(), "SSOSecret不能为空.");
            validateNotEmpty(dingTalk.getScanAppId(), "门户访问配置 应用id不能为空.");
            validateNotEmpty(dingTalk.getScanAppSecret(), "门户访问配置 应用密钥不能为空.");
            dingTalk.setCorpSecret(dingTalk.getCorpSecret().trim());
            dingTalk.setScanAppId(dingTalk.getScanAppId().trim());
            dingTalk.setScanAppSecret(dingTalk.getScanAppSecret().trim());
        } else if (CorpRelatedType.WECHAT == dingTalk.getRelatedType()) {
            validateNotEmpty(dingTalk.getCorpSecret(), "SSOSecret不能为空.");
            validateNotEmpty(dingTalk.getAgentId(), "agentId不能为空.");
            validateNotEmpty(dingTalk.getSynRedirectUri(), "增量同步地址不能为空");
        }
        dingTalk.setCorpId(dingTalk.getCorpId().trim());
        dingTalk.setRedirectUri(dingTalk.getRedirectUri().trim());

        String userId = getUserId();
        UserModel user = getOrganizationFacade().getUser(userId);
        if (user == null) {
            throw new PortalException(ErrCode.ORG_USER_NONEXISTENT);
        }
        if (log.isDebugEnabled()) {
            log.debug("userId = {}, user = {}", userId, JSONObject.toJSONString(user));
        }

        checkAppkey(dingTalk);

        if (CorpRelatedType.DINGTALK == dingTalk.getRelatedType()) {
            if (!getOrganizationFacade().validateAppKeySecretCorpId(dingTalk.getCorpId(), dingTalk.getAppkey(), dingTalk.getAppSecret())) {
                throw new PortalException(ErrCode.SYS_PARAMETER_ERROR.getErrCode(), "测试钉钉appKey和appSecret不通过.", "");
            }
        } else {
            List<String> errors = getOrganizationFacade().validateRelatedCorpSetting(dingTalk);
            if (errors.size() > 0) {
                throw new PortalException(ErrCode.SYS_PARAMETER_ERROR.getErrCode(), "校验不通过：" + String.join("，", errors));
            }
        }

        // 检验扫码登录的appId和appSecret 暂时无法检验appSecret,需要提供临时码
        if (CorpRelatedType.DINGTALK == dingTalk.getRelatedType()) {
            validateScanAppIdAndSecret(dingTalk.getScanAppId(), dingTalk.getScanAppSecret(), dingTalk.getRedirectUri());
        }

        return getOkResponseResult(Boolean.TRUE, "测试连接门户访问配置成功");
    }

    private void checkAppkey(RelatedCorpSettingModel corpSetting) {
        if (StringUtils.isBlank(corpSetting.getAppkey())) {
            return;
        }
        List<RelatedCorpSettingModel> corpSettings = getSystemManagementFacade()
                .getAllRelatedCorpSettingModelByType(corpSetting.getRelatedType());
        if (CollectionUtils.isNotEmpty(corpSettings)) {
            boolean existOrg = corpSettings.stream()
                    .anyMatch(corp ->
                            !Objects.equals(corp.getId(), corpSetting.getId()) &&
                                    Objects.equals(corp.getAppkey(), corpSetting.getAppkey()));
            if (existOrg) {
                throw new PortalException(ErrCode.SYS_PARAMETER_ERROR.getErrCode(), "appKey已被占用");
            }
        }
    }

    @ApiOperation(value = "统计配置项数量", notes = "统计配置了的配置项数量")
    @GetMapping("/count_config")
    public ResponseResult<Integer> countDingtalkConfig() {
        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingTypes(ImmutableList.of(SettingType.FILE_UPLOAD));
        List<RelatedCorpSettingModel> relatedCorps = getSystemManagementFacade().getAllRelatedCorpSettingModelByOrgType(OrgType.MAIN);

        if (CollectionUtils.isEmpty(models) && CollectionUtils.isEmpty(relatedCorps)) {
            return getOkResponseResult(0, "统计配置项数量成功");
        }

        Map<SettingType, List<SystemSettingModel>> settingTypeListMap = models.stream().collect(Collectors.groupingBy(SystemSettingModel::getSettingType));
        int total = settingTypeListMap.keySet().size() + relatedCorps.size();
        return getOkResponseResult(total, "统计配置项数量成功");
    }

    private OapiAuthScopesResponse validateSeniorContactAuth(String accessToken, String corpId) {
        DingTalkFacade dingTalkFacade = getDingTalkFacade();
        try {
            return dingTalkFacade.validateSeniorContactAuth(accessToken, corpId);
        } catch (ApiException e) {
            throw new PortalException(Long.parseLong(e.getErrCode()), e.getErrMsg());
        }
    }

    /**
     * 检验扫码登录的appId和appSecret
     *
     * @param scanAppId     扫码登录的appId
     * @param scanAppSecret 扫码登录的appSecret
     * @param redirectUri   回调地址
     * @return Boolean
     */
    private Boolean validateScanAppIdAndSecret(String scanAppId, String scanAppSecret, String redirectUri) {
        try {
            scanAppId = URLEncoder.encode(scanAppId, "UTF-8");
            redirectUri = URLEncoder.encode(redirectUri, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            log.error("无法对scanAppId或redirectUri正常编码..");
        }
        String qrConnectTemplateUrl = "https://oapi.dingtalk.com/connect/qrconnect?appid=%s&response_type=code&scope=snsapi_login&state=STATE&redirect_uri=%s";
        String qrConnectUrl = String.format(qrConnectTemplateUrl, scanAppId, redirectUri);
        if (log.isDebugEnabled()) {
            log.debug("qrConnectUrl = {}", qrConnectUrl);
        }
        StringBuilder temp = new StringBuilder();
        try {
            URL qrConnectURL = new URL(qrConnectUrl);
            HttpURLConnection connection = (HttpURLConnection) qrConnectURL.openConnection();
            connection.connect();
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
            String lines;

            while ((lines = reader.readLine()) != null) {
                temp.append(lines);
            }
            reader.close();
            connection.disconnect();
        } catch (Exception e) {
            log.warn(e.getMessage(), e);
        }
        String page = temp.toString();
        if (StringUtils.isEmpty(page)) {
            return Boolean.FALSE;
        }
        boolean hasPermit = page.contains("无权限") || page.contains("无效的appid");
        if (hasPermit) {
            throw new PortalException(ErrCode.SYS_PARAMETER_ERROR, "无效的appid");
        }
        return Boolean.TRUE;
    }

    /**
     * 检验agentId
     *
     * @param accessToken tokenId
     * @param agentId     agentId
     */
    private OapiMessageCorpconversationAsyncsendV2Response validateAgentId(String userId, String accessToken, String corpId, String agentId, String pcServerUrl, String mobileServerUrl) {
        DingTalkFacade dingTalkFacade = getDingTalkFacade();
        try {
            return dingTalkFacade.validateAgentId(userId, accessToken, corpId, agentId, pcServerUrl, mobileServerUrl);
        } catch (ApiException e) {
            throw new PortalException(Long.parseLong(e.getErrCode()), e.getErrMsg());
        }
    }

    /* */

    /**
     * 检验corpId/corpSecret和appKey/appSecret
     *
     * @param corpId     企业id
     * @param corpSecret 企业密钥
     * @param appKey     应用key
     * @param appSecret  应用密钥
     * @return OapiGettokenResponse
     */
    private OapiGettokenResponse validateIdAndSecret(String corpId, String corpSecret, String appKey, String appSecret) {
        DingTalkFacade dingTalkFacade = getDingTalkFacade();
        try {
            return dingTalkFacade.validateIdAndSecret(corpId, corpSecret, appKey, appSecret);
        } catch (ApiException e) {
            throw new PortalException(Long.parseLong(e.getErrCode()), e.getErrMsg());
        }
    }

    @PostConstruct
    public void init() {
        getOssConfig();
    }

    @ApiOperation(value = "获取阿里云OSS的配置参数", notes = "获取阿里云OSS的配置参数")
    @GetMapping("/get_File_config")
    public ResponseResult<FileUploadVO> getOssConfig() {
        FileUploadVO fileUpload = new FileUploadVO();
        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.FILE_UPLOAD);
        List<SystemSettingModel> ossSettings = null;
        List<SystemSettingModel> ftpSettings = null;
        if (ossEnabled) {
            ossSettings = models == null ? null : models.stream().filter(t -> t.getFileUploadType().equals(FileUploadType.OSS)).collect(Collectors.toList());
            if (CollectionUtils.isNotEmpty(ossSettings)){
                OssConfigVO ossConfig = new OssConfigVO();
                Map<String, String> systemSettings = ossSettings.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, SystemSettingModel::getSettingValue));
                ossConfig.setKeyId(systemSettings.get(OSSClient.KEY_ID));
                ossConfig.setKeySecret(systemSettings.get(OSSClient.KEY_SECRET));
                ossConfig.setEndPoint(systemSettings.get(OSSClient.ENDPOINT));
                ossConfig.setBucket(systemSettings.get(OSSClient.BUCKET));
                ossConfig.setChecked(ossSettings.get(0).getChecked());
                fileUpload.setOssConfigVO(ossConfig);
            }else{
                OssConfigVO ossConfigVO = new OssConfigVO();
                ossConfigVO.setChecked(true);
                fileUpload.setOssConfigVO(ossConfigVO);
                fileUpload.setFtpConfigVO(null);
                return getOkResponseResult(fileUpload, "成功获取文件配置信息");
            }
        }else if (sftpEnable) {
            ftpSettings =  models == null ? null : models.stream().filter(t -> t.getFileUploadType().equals(FileUploadType.FTP)).collect(Collectors.toList());
            if (CollectionUtils.isNotEmpty(ftpSettings)){
                Map<String, String> systemSettings = ftpSettings.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, SystemSettingModel::getSettingValue));
                FtpConfigVO ftpConfig = new FtpConfigVO();
                ftpConfig.setFtpServer(systemSettings.get("ftpServer"));
                ftpConfig.setFtpPort(systemSettings.get("ftpPort"));
                ftpConfig.setFtpAccount(systemSettings.get("ftpAccount"));
                ftpConfig.setFtpPassword(systemSettings.get("ftpPassword"));
                ftpConfig.setFtpFilePath(systemSettings.get("ftpFilePath"));
                ftpConfig.setChecked(ftpSettings.get(0).getChecked());
                fileUpload.setFtpConfigVO(ftpConfig);
            }else {
                FtpConfigVO ftpConfigVO = new FtpConfigVO();
                ftpConfigVO.setChecked(true);
                fileUpload.setFtpConfigVO(ftpConfigVO);
                fileUpload.setOssConfigVO(null);
                return getOkResponseResult(fileUpload, "成功获取文件配置信息");
            }
        }
        return getOkResponseResult(fileUpload, "成功获取文件的配置参数");
    }

    @ApiOperation(value = "保存文件上传的配置参数", notes = "保存阿里云OSS的配置参数")
    @PutMapping("/update_file_config")
    public ResponseResult<Boolean> addFileConfig(@RequestBody FileUploadVO fileUploadVO) {
        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.FILE_UPLOAD);
        addOssConfig(fileUploadVO.getOssConfigVO(), models);
        addFtpConfig(fileUploadVO.getFtpConfigVO(), models);
        return getOkResponseResult(Boolean.TRUE, "成功更新文件上传配置参数");
    }


    @ApiOperation(value = "获取在线预览配置参数", notes = "获取在线预览配置参数")
    @GetMapping("/get_idocv_config")
    public ResponseResult<IdocvConfigVO> getIdocvConfig() {
        List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.IDOCV_INFO);
        IdocvConfigVO vo = new IdocvConfigVO();
        for (SystemSettingModel model : models) {
            if (SystemConfigConstants.IDOCV_SERVICE_URL.equals(model.getSettingCode())) {
                vo.setIdocvServiceUrl(model.getSettingValue());
            } else if (SystemConfigConstants.IDOCV_IS_OPEN.equals(model.getSettingCode())) {
                vo.setIsOpen(model.getSettingValue());
            }
        }
        return getOkResponseResult(vo, "查询预览服务器配置参数成功");
    }

    @ApiOperation(value = "保存在线预览配置参数", notes = "保存在线预览配置参数")
    @PostMapping("/save_idocv_config")
    public ResponseResult<Boolean> saveIdocvConfig(@RequestBody IdocvConfigVO vo) {
        Map<String, SystemSettingModel> map = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.IDOCV_INFO).stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, Function.identity()));
        validateNotEmpty(vo.getIsOpen(), "在线预览配置开关是否打开不能为空");
        if (vo.getIdocvServiceUrl() == null) {
            vo.setIdocvServiceUrl("");
        }
        if ("true".equals(vo.getIsOpen())) {
            validateNotEmpty(vo.getIdocvServiceUrl(), "在线预览配置服务地址不能为空");
            validateIsUrl(vo.getIdocvServiceUrl(), "请输入有效的服务地址");
        }
        if (map.get(SystemConfigConstants.IDOCV_IS_OPEN) == null) {
            SystemSettingModel isopen = new SystemSettingModel();
            isopen.setSettingType(SettingType.IDOCV_INFO);
            isopen.setSettingCode(SystemConfigConstants.IDOCV_IS_OPEN);
            isopen.setSettingValue(vo.getIsOpen());
            getSystemManagementFacade().addSystemSetting(isopen);
        } else {
            SystemSettingModel systemSettingModel = map.get(SystemConfigConstants.IDOCV_IS_OPEN);
            systemSettingModel.setSettingValue(vo.getIsOpen());
            getSystemManagementFacade().updateSystemSetting(systemSettingModel);
        }

        if (map.get(SystemConfigConstants.IDOCV_SERVICE_URL) == null) {
            SystemSettingModel isopen = new SystemSettingModel();
            isopen.setSettingType(SettingType.IDOCV_INFO);
            isopen.setSettingCode(SystemConfigConstants.IDOCV_SERVICE_URL);
            isopen.setSettingValue(vo.getIdocvServiceUrl());
            getSystemManagementFacade().addSystemSetting(isopen);
        } else {
            SystemSettingModel systemSettingModel = map.get(SystemConfigConstants.IDOCV_SERVICE_URL);
            systemSettingModel.setSettingValue(vo.getIdocvServiceUrl());
            getSystemManagementFacade().updateSystemSetting(systemSettingModel);
        }

        return getOkResponseResult(Boolean.TRUE, "成功保存在线预览配置参数");
    }


    /**
     * 处理ftp配置
     *
     * @param ftpConfig
     * @param models
     */
    private void addFtpConfig(FtpConfigVO ftpConfig, List<SystemSettingModel> models) {
        if (ftpConfig == null) {
            return;
        }
        if (!ftpConfig.getChecked()) {
            return;
        }
        if (CollectionUtils.isNotEmpty(models)) {
            models = models.stream().filter(t -> t.getFileUploadType().equals(FileUploadType.FTP)).collect(Collectors.toList());
        }
        validateNotEmpty(ftpConfig.getFtpServer(), "SFTP服务器不能为空");
        validateNotEmpty(ftpConfig.getFtpPort(), "SFTP服务器端口号不能为空");
        validateNotEmpty(ftpConfig.getFtpAccount(), "SFTP服务器账号不能为空");
        validateNotEmpty(ftpConfig.getFtpPassword(), "SFTP服务器密码不能为空");
        validateFTPPortByStringValue(ftpConfig.getFtpPort());
        if (CollectionUtils.isEmpty(models)) {
            SystemSettingModel ftpServer = new SystemSettingModel("ftpServer", ftpConfig.getFtpServer(), SettingType.FILE_UPLOAD);
            ftpServer.setFileUploadType(FileUploadType.FTP);
            SystemSettingModel ftpPort = new SystemSettingModel("ftpPort", ftpConfig.getFtpPort(), SettingType.FILE_UPLOAD);
            ftpPort.setFileUploadType(FileUploadType.FTP);
            SystemSettingModel ftpAccount = new SystemSettingModel("ftpAccount", ftpConfig.getFtpAccount(), SettingType.FILE_UPLOAD);
            ftpAccount.setFileUploadType(FileUploadType.FTP);
            SystemSettingModel ftpPassword = new SystemSettingModel("ftpPassword", ftpConfig.getFtpPassword(), SettingType.FILE_UPLOAD);
            ftpPassword.setFileUploadType(FileUploadType.FTP);
            SystemSettingModel ftpFilePath = new SystemSettingModel("ftpFilePath", ftpConfig.getFtpFilePath(), SettingType.FILE_UPLOAD);
            ftpFilePath.setFileUploadType(FileUploadType.FTP);
            getSystemManagementFacade().addSystemSetting(ftpServer);
            getSystemManagementFacade().addSystemSetting(ftpPort);
            getSystemManagementFacade().addSystemSetting(ftpAccount);
            getSystemManagementFacade().addSystemSetting(ftpPassword);
            getSystemManagementFacade().addSystemSetting(ftpFilePath);
            sftpClient.rebuild();
            return;
        }
        Map<String, SystemSettingModel> systemSettingsMap = models.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, Function.identity()));
        if (systemSettingsMap.get("ftpServer") != null) {
            systemSettingsMap.get("ftpServer").setChecked(ftpConfig.getChecked());
            systemSettingsMap.get("ftpServer").setSettingValue(ftpConfig.getFtpServer());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get("ftpServer"));
        }
        if (systemSettingsMap.get("ftpPort") != null) {
            systemSettingsMap.get("ftpPort").setChecked(ftpConfig.getChecked());
            systemSettingsMap.get("ftpPort").setSettingValue(ftpConfig.getFtpPort());
            if (log.isDebugEnabled()) {
                log.debug("ftp port 为{}", ftpConfig.getFtpPort());
            }
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get("ftpPort"));
        }
        if (systemSettingsMap.get("ftpAccount") != null) {
            systemSettingsMap.get("ftpAccount").setChecked(ftpConfig.getChecked());
            systemSettingsMap.get("ftpAccount").setSettingValue(ftpConfig.getFtpAccount());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get("ftpAccount"));
        }
        if (systemSettingsMap.get("ftpPassword") != null) {
            systemSettingsMap.get("ftpPassword").setChecked(ftpConfig.getChecked());
            systemSettingsMap.get("ftpPassword").setSettingValue(ftpConfig.getFtpPassword());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get("ftpPassword"));
        }
        if (systemSettingsMap.get("ftpFilePath") != null) {
            systemSettingsMap.get("ftpFilePath").setChecked(ftpConfig.getChecked());
            systemSettingsMap.get("ftpFilePath").setSettingValue(ftpConfig.getFtpFilePath());
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get("ftpFilePath"));
        }
        sftpClient.rebuild();
    }

    private void validateFTPPortByStringValue(String port) {
        try {
            int parseInt = Integer.parseInt(port);
            // 0 ~ 65535
            if (parseInt < 0 || parseInt > 65535) {
                throw new PortalException(40050, "SFTP服务器端口号不规范,请输入一个0 ~ 65535的整数");
            }
        } catch (NumberFormatException e) {
            throw new PortalException(40050, "SFTP服务器端口号不规范,请输入一个0 ~ 65535的整数");
        }
    }

    /**
     * 处理OSS文件上传配置
     *
     * @param ossConfig
     * @param models
     */
    private void addOssConfig(OssConfigVO ossConfig, List<SystemSettingModel> models) {
        if (ossConfig == null) {
            return;
        }
        if (!ossConfig.getChecked()) {
            return;
        }
        validateNotEmpty(ossConfig.getKeyId(), "阿里云oss的keyId不能为空.");
        validateNotEmpty(ossConfig.getKeySecret(), "阿里云oss的keySecret不能为空.");
        validateNotEmpty(ossConfig.getBucket(), "阿里云oss的Bucket不能为空.");
        validateNotEmpty(ossConfig.getEndPoint(), "阿里云oss的EndPoint不能为空.");
        if (CollectionUtils.isNotEmpty(models)) {
            models = models.stream().filter(t -> t.getFileUploadType().equals(FileUploadType.OSS)).collect(Collectors.toList());
        }
        if (ossConfig.getExpiration() == null) {
            ossConfig.setExpiration(OSSClient.DEFAULT_EXPIRETIME);
        }
        if (CollectionUtils.isEmpty(models)) {
            // 数据库没有，则直接保存
            SystemSettingModel keyId = new SystemSettingModel();
            keyId.setSettingCode(OSSClient.KEY_ID);
            keyId.setSettingValue(ossConfig.getKeyId().trim());
            keyId.setSettingType(SettingType.FILE_UPLOAD);
            keyId.setFileUploadType(FileUploadType.OSS);
            keyId.setChecked(ossConfig.getChecked());

            SystemSettingModel keySecret = new SystemSettingModel();
            keySecret.setSettingCode(OSSClient.KEY_SECRET);
            keySecret.setSettingValue(ossConfig.getKeySecret().trim());
            keySecret.setSettingType(SettingType.FILE_UPLOAD);
            keySecret.setFileUploadType(FileUploadType.OSS);
            keySecret.setChecked(ossConfig.getChecked());

            SystemSettingModel endPoint = new SystemSettingModel();
            endPoint.setSettingCode(OSSClient.ENDPOINT);
            endPoint.setSettingValue(ossConfig.getEndPoint().trim());
            endPoint.setSettingType(SettingType.FILE_UPLOAD);
            endPoint.setFileUploadType(FileUploadType.OSS);
            endPoint.setChecked(ossConfig.getChecked());

            SystemSettingModel bucket = new SystemSettingModel();
            bucket.setSettingCode(OSSClient.BUCKET);
            bucket.setSettingValue(ossConfig.getBucket().trim());
            bucket.setSettingType(SettingType.FILE_UPLOAD);
            bucket.setFileUploadType(FileUploadType.OSS);
            bucket.setChecked(ossConfig.getChecked());

            SystemSettingModel expireTime = new SystemSettingModel();
            expireTime.setSettingCode(OSSClient.EXPIRETIME);
            expireTime.setSettingValue(ossConfig.getExpiration() + "");
            expireTime.setSettingType(SettingType.FILE_UPLOAD);
            expireTime.setFileUploadType(FileUploadType.OSS);
            expireTime.setChecked(ossConfig.getChecked());

            getSystemManagementFacade().addSystemSetting(keyId);
            getSystemManagementFacade().addSystemSetting(keySecret);
            getSystemManagementFacade().addSystemSetting(endPoint);
            getSystemManagementFacade().addSystemSetting(bucket);
            getSystemManagementFacade().addSystemSetting(expireTime);
            ossClient.rebuild();
            return;
        }

        // 查询出OSS配置，进行更新或保存
        Map<String, SystemSettingModel> systemSettingsMap = models.stream().collect(Collectors.toMap(SystemSettingModel::getSettingCode, Function.identity()));
        if (systemSettingsMap.get(OSSClient.KEY_ID) != null) {
            systemSettingsMap.get(OSSClient.KEY_ID).setSettingValue(ossConfig.getKeyId().trim());
            systemSettingsMap.get(OSSClient.KEY_ID).setChecked(ossConfig.getChecked());
            systemSettingsMap.get(OSSClient.KEY_ID).setFileUploadType(FileUploadType.OSS);
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(OSSClient.KEY_ID));
        } else {
            SystemSettingModel model = new SystemSettingModel();
            model.setSettingCode(OSSClient.KEY_ID);
            model.setSettingValue(ossConfig.getKeyId().trim());
            model.setSettingType(SettingType.FILE_UPLOAD);
            model.setFileUploadType(FileUploadType.OSS);
            model.setChecked(ossConfig.getChecked());
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(OSSClient.KEY_SECRET) != null) {
            systemSettingsMap.get(OSSClient.KEY_SECRET).setSettingValue(ossConfig.getKeySecret().trim());
            systemSettingsMap.get(OSSClient.KEY_SECRET).setChecked(ossConfig.getChecked());
            systemSettingsMap.get(OSSClient.KEY_SECRET).setFileUploadType(FileUploadType.OSS);
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(OSSClient.KEY_SECRET));
        } else {
            SystemSettingModel model = new SystemSettingModel();
            model.setSettingCode(OSSClient.KEY_SECRET);
            model.setSettingValue(ossConfig.getKeySecret().trim());
            model.setSettingType(SettingType.FILE_UPLOAD);
            model.setChecked(ossConfig.getChecked());
            model.setFileUploadType(FileUploadType.OSS);
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(OSSClient.ENDPOINT) != null) {
            systemSettingsMap.get(OSSClient.ENDPOINT).setSettingValue(ossConfig.getEndPoint().trim());
            systemSettingsMap.get(OSSClient.ENDPOINT).setChecked(ossConfig.getChecked());
            systemSettingsMap.get(OSSClient.ENDPOINT).setFileUploadType(FileUploadType.OSS);
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(OSSClient.ENDPOINT));
        } else {
            SystemSettingModel model = new SystemSettingModel();
            model.setSettingCode(OSSClient.ENDPOINT);
            model.setSettingValue(ossConfig.getEndPoint().trim());
            model.setSettingType(SettingType.FILE_UPLOAD);
            model.setChecked(ossConfig.getChecked());
            model.setFileUploadType(FileUploadType.OSS);
            getSystemManagementFacade().addSystemSetting(model);
        }
        if (systemSettingsMap.get(OSSClient.BUCKET) != null) {
            systemSettingsMap.get(OSSClient.BUCKET).setSettingValue(ossConfig.getBucket().trim());
            systemSettingsMap.get(OSSClient.BUCKET).setChecked(ossConfig.getChecked());
            systemSettingsMap.get(OSSClient.BUCKET).setFileUploadType(FileUploadType.OSS);
            getSystemManagementFacade().updateSystemSetting(systemSettingsMap.get(OSSClient.BUCKET));
        } else {
            SystemSettingModel model = new SystemSettingModel();
            model.setSettingCode(OSSClient.BUCKET);
            model.setSettingValue(ossConfig.getBucket().trim());
            model.setSettingType(SettingType.FILE_UPLOAD);
            model.setChecked(ossConfig.getChecked());
            model.setFileUploadType(FileUploadType.OSS);
            getSystemManagementFacade().addSystemSetting(model);
        }
        ossClient.rebuild();
    }

    @ApiOperation(value = "连接测试oss的配置参数", notes = "连接测试oss的配置参数")
    @PostMapping("/check_file_config")
    public ResponseResult<Boolean> checkOss(@RequestBody FileUploadVO fileUploadVO) throws Exception {
        OssConfigVO ossConfigVO = fileUploadVO.getOssConfigVO();
        FtpConfigVO ftpConfigVO = fileUploadVO.getFtpConfigVO();
        if (ossConfigVO != null && ossConfigVO.getChecked()) {
            //连接测试前先保存
            List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.FILE_UPLOAD);
            addOssConfig(ossConfigVO, models);
            try {
                // 先上传配置
                String refId = UUID.randomUUID().toString().replace("-", "");

                if (log.isDebugEnabled()) {
                    log.debug("refId = {}", refId);
                }
                PutObjectResult putObjectResult = ossClient.stringUpload(ossConfigVO, refId, "testOssConfig");
                log.debug("PutObjectResult = {}", putObjectResult);

                // 检验完，删除配置
                if (log.isDebugEnabled()) {
                    log.debug("begin delete OssConfig...");
                }
                ossClient.delete(ossConfigVO, refId);
            } catch (PortalException e) {
                throw new PortalException(ResultEnum.FILE_CHECK_ERR.getErrCode(), ResultEnum.FILE_CHECK_ERR.getErrMsg(), e.getData());
            }

            return getOkResponseResult(Boolean.TRUE, "成功连接测试oss的配置参数");
        }
        if (ftpConfigVO != null && ftpConfigVO.getChecked()) {
            List<SystemSettingModel> models = getSystemManagementFacade().getSystemSettingsBySettingType(SettingType.FILE_UPLOAD);
            addFtpConfig(ftpConfigVO, models);
            if (sftpClient.checkSftp()) {
                return getOkResponseResult(Boolean.TRUE, "成功连接测试ftp的配置参数");
            }
            throw new PortalException(ResultEnum.FILE_CHECK_ERR.getErrCode(), ResultEnum.FILE_CHECK_ERR.getErrMsg(), "SFT连接失败请检查参数");
        }
        if (ossConfigVO == null && ftpConfigVO == null) {
            throw new PortalException(ErrCode.SYS_PARAMETER_ERROR, "文件配置信息不存在");
        }
        return getOkResponseResult(Boolean.TRUE, "文件配置连接测试成功");
    }

    @ApiOperation(value = "获取系统的版本参数", notes = "获取系统的版本参数")
    @GetMapping("/get_version")
    public ResponseResult<String> getSysVersion() {
        return getOkResponseResult("BPM 3.0", "成功调用获取流程列表接口");
    }

    /***********************************权限*************************************/

    @ApiOperation(value = "查询系统管理员或应用管理员列表", notes = "查询系统管理员，应用管理员")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "managerType", value = AdminType.DESCRIPTION, required = true, dataType = "Integer", paramType = "query"),
            @ApiImplicitParam(name = "listShow", dataType = "Boolean", paramType = "query"),
            @ApiImplicitParam(name = "searchWord", value = "搜索关键字", dataType = "String", paramType = "query", defaultValue = ""),
            @ApiImplicitParam(name = "page", value = "页码", dataType = "Integer", paramType = "query", defaultValue = "0"),
            @ApiImplicitParam(name = "size", value = "页大小", dataType = "Integer", paramType = "query", defaultValue = "10")
    })
    @GetMapping("/list_manager")
    public ResponseResult listSystemOrAppAdmins(@RequestParam Integer managerType, @RequestParam(required = false) boolean listShow,
                                                @RequestParam(required = false, defaultValue = "") String searchWord,
                                                @RequestParam Integer page, @RequestParam Integer size) {
        if (managerType == null) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "管理员类型不能为空");
        }

        PageRequest pageable = PageRequest.of(page == null ? 0 : page, size == null ? 10 : size);
        AdminType managerTypeEnum = AdminType.get(managerType);
        //fixed bug #46534 增加判断是否过滤权限外展示数据
        Page<AdminModel> admins = null;
        if (managerTypeEnum == AdminType.APP_MNG) {
            List<AdminModel> dataAdmins = getAdminFacade().getAdminsByAdminType(AdminType.DATA_MNG);
            dataAdmins.stream().forEach(it -> getAppManagementFacade().updateAdminGroups(it));
            String userId = getUserId();
            AdminModel sys = getAdminFacade().getAdminByAdminTypeAndUserId(AdminType.SYS_MNG, userId);
            AdminModel admin = getAdminFacade().getAdminByAdminTypeAndUserId(AdminType.ADMIN, userId);
            if (sys == null && admin == null) {
                admins = getAdminFacade().searchAdminByType(managerTypeEnum, userId, searchWord, pageable);
            } else {
                admins = getAdminFacade().searchAdminByType(managerTypeEnum, null, searchWord, pageable);
                if (!listShow && admins != null && CollectionUtils.isNotEmpty(admins.getContent())) {
                    admins.getContent().stream().forEach(adminModel -> {
                        removeLoginUserNoHasAppPackageOrDeptScope(adminModel.getAppPackages(), adminModel.getDepartments(), adminModel.getUserId(), true);
                        removeNotLoginUserAndAppAdminUserMixed(adminModel.getUserId(), adminModel.getDepartments());
                    });
                }
            }
        } else {
            admins = getAdminFacade().searchAdminByType(managerTypeEnum, null, searchWord, pageable);
        }

        Page<AdminVO> adminVOPage = null;
        if (admins != null && CollectionUtils.isNotEmpty(admins.getContent())) {
            List<AdminVO> managerVOS = getAdminVOS(admins.getContent());
            adminVOPage = new PageImpl<>(managerVOS, admins.getPageable(), admins.getTotalElements());
        }
        return getOkResponseResult(new PageVO<>(adminVOPage), "查询管理员列表成功");
    }

    @ApiOperation(value = "查询管理员用户信息", notes = "查询系统管理员，应用管理员")
    @ApiImplicitParam(name = "managerType", value = AdminType.DESCRIPTION, required = true, dataType = "Integer", paramType = "query")
    @GetMapping("/list_manager_user")
    public ResponseResult<List<Map<String, Object>>> listManagerUser(@RequestParam Integer managerType, @RequestParam String selectUserIds) {
        if (managerType == null) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "管理员类型不能为空");
        }
        AdminType managerTypeEnum = AdminType.get(managerType);
        List<AdminModel> managers = getAdminsByAdminType(managerTypeEnum, false);
        Set<String> userIdsSet = managers.stream().map(AdminModel::getUserId).collect(Collectors.toSet());

        List<String> userIds = Lists.newArrayList(userIdsSet);
        Map<String, UserModel> userMap = getOrganizationFacade().getUsers(userIds);
        List<Map<String, Object>> managerUsers = Lists.newLinkedList();
        for (String userId : userIds) {
            UserModel userModel = userMap.get(userId);
            if (userModel != null) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", userId);
                map.put("name", userModel.getName());
                map.put("username", userModel.getUsername());
                map.put("select", true);
                managerUsers.add(map);
            }
        }
        if (StringUtils.isNotEmpty(selectUserIds)) {
            List<String> userIdList = Splitter.on(",").splitToList(selectUserIds);
            Map<String, UserModel> tempMap = getOrganizationFacade().getUsers(userIdList);
            for (String userId : userIdList) {
                if (userIds.contains(userId)) {
                    continue;
                }
                UserModel userModel = tempMap.get(userId);
                if (userModel != null) {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", userId);
                    map.put("name", userModel.getName());
                    map.put("username", userModel.getUsername());
                    map.put("select", false);
                    managerUsers.add(map);
                }
            }
        }

        return getOkResponseResult(managerUsers, "查询管理员列表成功");
    }

    //根据类型获取管理员
    private List<AdminModel> getAdminsByAdminType(AdminType managerTypeEnum, boolean listShow) {
        List<AdminModel> admins = getAdminFacade().getAdminsByAdminType(managerTypeEnum);
        if (managerTypeEnum == AdminType.APP_MNG) {
            List<AdminModel> dataAdmins = getAdminFacade().getAdminsByAdminType(AdminType.DATA_MNG);
            String userId = getUserId();
            AdminModel sys = getAdminFacade().getAdminByAdminTypeAndUserId(AdminType.SYS_MNG, userId);
            AdminModel admin = getAdminFacade().getAdminByAdminTypeAndUserId(AdminType.ADMIN, userId);
            dataAdmins.stream().filter(it -> it.getAdminType().equals(AdminType.DATA_MNG)).forEach(it -> getAppManagementFacade().updateAdminGroups(it));
            admins = getAdminFacade().getAdminsByAdminType(managerTypeEnum);
            if (sys == null && admin == null) {
                //不是系统管理员或者超级管理员,是应用管理员
                Iterator<AdminModel> iterator = admins.iterator();
                while (iterator.hasNext()) {
                    AdminModel adminModel = iterator.next();
                    if (!userId.equals(adminModel.getCreatedBy())) {
                        //当前登录用户
                        iterator.remove();
                    } else {
                        if (!listShow) {
                            removeLoginUserNoHasAppPackageOrDeptScope(adminModel.getAppPackages(), adminModel.getDepartments(), adminModel.getUserId(), true);
                            removeNotLoginUserAndAppAdminUserMixed(adminModel.getUserId(), adminModel.getDepartments());
                        }
                    }
                }
            }
        }
        return admins;
    }

//    @ApiOperation(value = "查询数据管理员列表", notes = "查询数据管理员，分页")
//    @ApiImplicitParams({
//            @ApiImplicitParam(name = "searchWord", value = "搜索关键字", dataType = "String", paramType = "query", defaultValue = "0"),
//            @ApiImplicitParam(name = "page", value = "页码", dataType = "Integer", paramType = "query", defaultValue = "0"),
//            @ApiImplicitParam(name = "size", value = "页大小", dataType = "Integer", paramType = "query", defaultValue = "10")
//    })
//    @GetMapping("/list_datamanager")
//    public ResponseResult<PageVO<AdminVO>> listDataAdmins(@RequestParam(required = false, defaultValue = "") String searchWord,
//                                                          @RequestParam Integer page, @RequestParam Integer size) {
//        PageRequest pageable = PageRequest.of(page == null ? 0 : page, size == null ? 10 : size);
//        Page<AdminModel> managerPage = getPermissionManagementFacade().searchAdminByType(AdminType.DATA_MNG,null,searchWord,pageable);
//
//        List<AdminModel> managers = managerPage.getContent();
//        //添加管理员 所属组织字段 username name 字段
//        List<AdminVO> managerVOS = getAdminVOS(managers);
//        if (managerVOS == null) {
//            return getOkResponseResult(null, "查询系统管理员列表成功");
//        }
//        Page<AdminVO> managerVOPage = new PageImpl<>(managerVOS, pageable, managerPage.getTotalElements());
//        PageVO<AdminVO> pageVO = new PageVO<>(managerVOPage);
//        return getOkResponseResult(pageVO, "查询系统管理员列表成功");
//    }

    /**
     * 管理员添加所属组织，name username 字段
     *
     * @param managers 管理员
     * @return List
     */
    private List<AdminVO> getAdminVOS(List<AdminModel> managers) {
        if (CollectionUtils.isEmpty(managers)) {
            return null;
        }

        Set<String> userIdsSet = managers.stream().map(AdminModel::getUserId).collect(Collectors.toSet());
        List<String> userIds = Lists.newArrayList(userIdsSet);
        if (log.isDebugEnabled()) {
            log.debug("用户id为{}", JSON.toJSONString(userIds));
        }
        Map<String, UserModel> userMap = getOrganizationFacade().getUsers(userIds);

        //获取部门
        List<UserModel> userModels = Lists.newArrayList(userMap.values());
        userModels.removeAll(Collections.singleton(null));
        if (log.isDebugEnabled()) {
            log.debug("用户信息为{}", JSON.toJSONString(userModels));
        }
        List<String> departmentIds = userModels.stream().map(UserModel::getDepartmentId).collect(Collectors.toList());
        Map<String, List<DepartmentModel>> departmentMap = getOrganizationFacade().getDepartmentsByParentIds(departmentIds);

        return managers.stream().map(manager -> {
            AdminVO managerVO = new AdminVO();
            UserModel userModel = userMap.get(manager.getUserId());
            if (userModel != null) {
                managerVO.setUserModel(userModel);
                BeanUtils.copyProperties(manager, managerVO);
                //添加所属组织
                List<DepartmentModel> departments = departmentMap.get(userModel.getDepartmentId());
                if (CollectionUtils.isNotEmpty(departments)) {
                    List<String> departmentNames = departments.stream().map(DepartmentModel::getName).collect(Collectors.toList());
                    managerVO.setDepartmentName(departmentNames);
                }
            }

            return managerVO;
        }).collect(Collectors.toList());
    }


    @ApiOperation(value = "查询管理员", notes = "通过管理员id查询单个管理员")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "管理员id", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "editShow", value = "是编辑展示", dataType = "editShow", paramType = "query")
    })
    @GetMapping("/get_manager")
    public ResponseResult<AdminVO> getAdmin(@RequestParam String id, @RequestParam(required = false) boolean editShow) {
        validateNotEmpty(id, "管理员id不能为空");
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【getAdmin()】,参数：id=【{}】", id);
        }
        AdminModel managerModel = getAdminFacade().getAdmin(id);
        String userId = managerModel.getUserId();
        UserModel userModel = getOrganizationFacade().getUser(userId);
        List<DepartmentModel> departments = getOrganizationFacade().getDepartmentsByParentId(userModel.getDepartmentId());
        AdminVO managerVO = new AdminVO(userModel);
        BeanUtils.copyProperties(managerModel, managerVO);
        //上级部门
        managerVO.setDepartmentName(departments.stream().map(DepartmentModel::getName).collect(Collectors.toList()));
        removeLoginUserNoHasAppPackageOrDeptScope(managerVO.getAppPackages(), managerVO.getDepartments(), managerVO.getUserId(), true);
        List<DepartmentScopeModel> scopeModels = managerVO.getDepartments();
        List<DepartmentScopeModel> tempDepts = Lists.newArrayList(scopeModels);
        removeNotLoginUserAndAppAdminUserMixed(managerVO.getUserId(), scopeModels);
        //fixed bug #46534
        if (editShow) {
            managerVO.setDepartments(tempDepts);
        }
        return getOkResponseResult(managerVO, "查询管理员成功");
    }

    @ApiOperation(value = "查询当前登录用户是否有操作权限", notes = "查询当前登录用户是否有操作权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "targetIds", value = "目标id集合", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "userIds", value = "目标用户ids集合", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "sourceType", required = true, dataType = "PermSourceType", paramType = "query", value = "来源类型:APP-应用范围，DEPT-组织范围，DEPT_USER-部门人员组合")
    })
    @GetMapping("/checkPerm")
    public ResponseResult<List<PermVo>> checkLoginUserIsHasPermByTargetId(String targetIds, String userIds, PermSourceType sourceType) {
        List<PermVo> permVos = new AppPermHelper(this).checkLoginUserIsHasPermByTargetId(targetIds, userIds, sourceType);
        return getOkResponseResult(permVos, "查询当前登录用户是否有操作权限成功");
    }


    @ApiOperation(value = "查询当前登录用户是否有创建应用的操作权限", notes = "查询当前登录用户是否有创建应用的操作权限")
    @GetMapping("/checkUserCreateAppPerm")
    public ResponseResult<Boolean> checkUserCreateAppPerm() {
        boolean state = false;
        state = new AppPermHelper(this).checkLoginUserIsHasCreateAppPerm();

        return getOkResponseResult(state, "查询当前登录用户是否有创建应用权限成功");
    }

    @ApiOperation(value = "查询当前选择用户是否有操作权限", notes = "查询当前选择用户是否有操作权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "targetIds", value = "目标id集合", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "selectUserId", value = "目标用户id", required = true, dataType = "String", paramType = "query"),
    })
    @GetMapping("/checkEditPerm")
    public ResponseResult<List<PermVo>> checkSelectUseHasTargetIdPerm(String targetIds, String selectUserId) {
        List<PermVo> permVos = new AppPermHelper(this).checkSelectUseHasTargetIdPerm(targetIds, selectUserId);
        return getOkResponseResult(permVos, "查询当前选择用户是否有操作权限成功");
    }

    /**
     * 移除应用管理员新增应用管理员交集以外的部门（考虑到部门发生变动，出现权限之外的变动，需要移除）
     *
     * @param userId
     * @param departments
     */
    private void removeNotLoginUserAndAppAdminUserMixed(String userId, List<DepartmentScopeModel> departments) {
        if (CollectionUtils.isEmpty(departments)) {
            return;
        }
        @NotNull Set<String> mixedDeptIds = new HashSet<>();
        int loginUserPermScopeAndSelectUserDeptsMixedDept = new AppPermHelper(this).getLoginUserPermScopeAndSelectUserDeptsMixedDept(userId, mixedDeptIds);
        if (loginUserPermScopeAndSelectUserDeptsMixedDept == 0) {
            //系统或者超级管理员，不需要处理交集
            return;
        }
        Iterator<DepartmentScopeModel> iterator = departments.iterator();
        while (iterator.hasNext()) {
            DepartmentScopeModel next = iterator.next();
            if (!mixedDeptIds.contains(next.getUnitId())) {
                iterator.remove();
            }
        }
    }

    /**
     * 检查当前登录用户是否具有管理应用和组织的范围，如果没有，则移除,保留有权限的部分
     *
     * @param appPackageScopeModels 当前带校验的应用范围权限
     * @param departmentScopeModels 当前待校验的组织范围权限
     * @param selectUserId          当前选择的用户id，编辑或者新增选择的用户id
     * @param isQuery               是否是查询，查询就修改数据管理员字段值和操作类型值，非查询就不修改
     * @return true ,有权限，false，当前编辑的没有权限
     */
    private boolean removeLoginUserNoHasAppPackageOrDeptScope(List<AppPackageScopeModel> appPackageScopeModels, List<DepartmentScopeModel> departmentScopeModels, String selectUserId, boolean isQuery) {
        String loginUserId = getUserId();
        List<AdminModel> adminModels = getAdminFacade().getAdminByUserId(loginUserId);
        List<AppPackageScopeModel> hasAppSocpeMedels = new ArrayList<>();
        List<DepartmentScopeModel> hasDepartmentScopeModels = new ArrayList<>();
        //是否需要检查是否有管理范围权限，true是要检查，false表示是系统管理员或者超级管理员，不需要检查
        boolean check = true;
        for (AdminModel adminModel : adminModels) {
            if (AdminType.SYS_MNG == adminModel.getAdminType() || AdminType.ADMIN == adminModel.getAdminType()) {
                check = false;
                break;
            } else if (AdminType.APP_MNG == adminModel.getAdminType()) {
                hasAppSocpeMedels.addAll(adminModel.getAppPackages());
                hasDepartmentScopeModels.addAll(adminModel.getDepartments());
            }
        }

        boolean isHasPermScope = true;
        if (check) {
            //当前选择的用户，是否拥有数据管理权限
            List<String> appPackageCodes = null;
            if (CollectionUtils.isNotEmpty(appPackageScopeModels)) {
                String adminId = appPackageScopeModels.get(0).getAdminId();
                //找到数据管理员数据
                List<AdminModel> modelList = getAdminFacade().getAdminByParentId(adminId);
                appPackageCodes = getAppPackageCodesByAdmins(modelList);
            }

            //当前登录用户如果没有他人的所拥有的应用范围管理权限时，移除没有权限的应用范围
            Map<String, AppPackageScopeModel> packageScopeModelMap = hasAppSocpeMedels.stream().collect(Collectors.toMap(AppPackageScopeModel::getCode, Function.identity(), (k1, k2) -> k1));
            Iterator<AppPackageScopeModel> iterator = appPackageScopeModels.iterator();
            while (iterator.hasNext()) {
                AppPackageScopeModel appPackageScopeModel = iterator.next();
                appPackageScopeModel.setOperatable(packageScopeModelMap.get(appPackageScopeModel.getCode()) != null);
                if (packageScopeModelMap.get(appPackageScopeModel.getCode()) == null) {
                    //当前登录用户没有该应用的管理权限
                    //迭代36后，应用管理员可以查看系统管理员添加的应用和关联的数据管理员，就不能移除了
//                    iterator.remove();
//                    isHasPermScope=false;
                }
                if (isQuery && CollectionUtils.isNotEmpty(appPackageCodes) && !appPackageScopeModel.isDataManage()) {
                    appPackageScopeModel.setDataManage(appPackageCodes.contains(appPackageScopeModel.getCode()));
                }
            }

            //有权限的部门id集合
            List<String> hasDeptScopeIds = hasDepartmentScopeModels.stream().map(DepartmentScopeModel::getUnitId).collect(Collectors.toList());
            Map<String, DepartmentModel> departmentModelMap = getOrganizationFacade().getDepartmentsChildList(hasDeptScopeIds, false).stream().collect(Collectors.toMap(DepartmentModel::getId, Function.identity(), (k1, k2) -> k1));
            Iterator<DepartmentScopeModel> departmentScopeModelIterator = departmentScopeModels.iterator();
            while (departmentScopeModelIterator.hasNext()) {
                DepartmentScopeModel departmentScopeModel = departmentScopeModelIterator.next();
                if (departmentModelMap.get(departmentScopeModel.getUnitId()) == null) {
                    //当前登录用户没有该部门的管理权限
                    departmentScopeModelIterator.remove();
                    isHasPermScope = false;
                }
            }
        } else {
            if (CollectionUtils.isNotEmpty(appPackageScopeModels)) {
                String adminId = appPackageScopeModels.get(0).getAdminId();
                //找到数据管理员数据
                List<AdminModel> modelList = getAdminFacade().getAdminByParentId(adminId);
                List<String> appPackageCodes = getAppPackageCodesByAdmins(modelList);
                Iterator<AppPackageScopeModel> iterator = appPackageScopeModels.iterator();
                while (iterator.hasNext()) {
                    AppPackageScopeModel appPackageScopeModel = iterator.next();
                    appPackageScopeModel.setOperatable(true);
                    if (isQuery && CollectionUtils.isNotEmpty(appPackageCodes) && !appPackageScopeModel.isDataManage()) {
                        appPackageScopeModel.setDataManage(appPackageCodes.contains(appPackageScopeModel.getCode()));
                    }
                }
            }

        }
        return isHasPermScope;
    }

    /**
     * 根据管理类型和用户id获取应用管理范围集合
     *
     * @param adminType
     * @param selectUserId
     * @return
     */
    private List<String> getAppPackageCodesByAdminTypeAndUserId(AdminType adminType, String selectUserId) {
        List<AdminModel> adminModels = getAdminsByAdminTypeAndUserId(adminType, selectUserId);
        return getAppPackageCodesByAdmins(adminModels);
    }

    private List<String> getAppPackageCodesByAdmins(List<AdminModel> adminModels) {
        if (CollectionUtils.isNotEmpty(adminModels)) {
            List<AppPackageScopeModel> collect = adminModels.stream().map(adminModel -> adminModel.getAppPackages()).flatMap(appPackageScopeModels1 -> appPackageScopeModels1.stream()).collect(Collectors.toList());
            if (CollectionUtils.isNotEmpty(collect)) {
                return collect.stream().map(appPackageScopeModel -> appPackageScopeModel.getCode()).collect(Collectors.toList());
            }
        }
        return null;
    }

    private List<AdminModel> getAdminsByAdminTypeAndUserId(AdminType adminType, String selectUserId) {
        List<AdminModel> adminModels = getAdminFacade().getAdminByUserId(selectUserId);
        if (CollectionUtils.isEmpty(adminModels)) {
            return adminModels;
        }
        Iterator<AdminModel> iterator = adminModels.iterator();
        while (iterator.hasNext()) {
            AdminModel adminModel = iterator.next();
            if (adminModel.getAdminType() != adminType) {
                iterator.remove();
            }
        }
        return adminModels;
    }

    @ApiOperation(value = "创建系统管理员", notes = "创建系统管理员")
    @PostMapping("/create_systemmanager")
    public ResponseResult<Void> createSystemAdmin(@RequestBody SystemMangerVO systemMangerVO) {
        List<Map<String, String>> users = systemMangerVO.getUsers();
        if (CollectionUtils.isEmpty(users)) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id至少有一个");
        }
        String loginUserId = getUserId();
        List<AdminModel> managers = Lists.newArrayList();
        for (Map<String, String> user : users) {
            String userId = user.get("id");
            redisCacheService.clearUserManagers(userId);
            if (Strings.isNullOrEmpty(userId)) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id不能为空");
            }
            UserModel userModel = getOrganizationFacade().getUser(userId);
            if (!selectionHelper.isMainOrg(userModel.getCorpId())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "非主组织用户");
            }
            AdminModel adminByAdminTypeAndUserId = getAdminFacade().getAdminByAdminTypeAndUserId(AdminType.SYS_MNG, userId);
            if (adminByAdminTypeAndUserId != null) {
                return getErrResponseResult(40000L, "系统管理员已经存在");
            }
            AdminModel managerModel = new AdminModel();
            managerModel.setUserId(userId);
            managerModel.setAdminType(AdminType.SYS_MNG);
            managerModel.setRoleManage(true);
            managerModel.setAppManage(true);
            managerModel.setCreatedBy(loginUserId);
            managers.add(managerModel);
        }
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【updateAdmins()】,参数：managers=【{}】", toJson(managers));
        }
        getAdminFacade().updateAdmins(managers);
        return getOkResponseResult("创建系统管理员成功");
    }

    @ApiOperation(value = "创建应用管理员", notes = "创建应用管理员")
    @PostMapping("/create_apppackagemanager")
    public ResponseResult<Void> createAppPackageAdmin(@RequestBody AppPackageMangerVO appPackageMangerVO) {
        List<Map<String, String>> users = appPackageMangerVO.getUsers();

        if (CollectionUtils.isEmpty(users)) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id至少有一个");
        }

        boolean loginUserHasAppPackageOrDeptScope = removeLoginUserNoHasAppPackageOrDeptScope(appPackageMangerVO.getAppPackages(), appPackageMangerVO.getDepartments(), users.get(0).get("id"), false);
        if (!loginUserHasAppPackageOrDeptScope) {
            throw new PortalException(40002, "存在没有权限的应用范围或者组织范围");
        }
        AppPermHelper appPermHelper = new AppPermHelper(this);
        if (!appPermHelper.isHasMixedByLoginUserPermScopeAndSelectUserDepts(users.get(0).get("id"), appPackageMangerVO.getDepartments())) {
            throw new PortalException(40003, "当前管理员的组织权限范围和所选管理员所在部门及子部门没有交集，请重新选择有权限范围的管理员");
        }

        //判断当前子管理员是否已存在
        List<String> ids = users.stream().map(map -> map.get("id")).collect(Collectors.toList());
        PageRequest pageable = PageRequest.of(0, 1);
        Page<AdminModel> adminsByUserIds = getAdminFacade().getAdminsByUserIds(ids, AdminType.APP_MNG, pageable);

        if (adminsByUserIds.getTotalElements() > 0) {
            return getErrResponseResult(40000L, "子管理员已经存在");
        }

        List<AdminModel> managers = Lists.newArrayList();
        for (Map<String, String> user : users) {
            String userId = user.get("id");
            redisCacheService.clearUserManagers(userId);
            if (Strings.isNullOrEmpty(userId)) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id不能为空");
            }
            AdminModel managerModel = new AdminModel();
            managerModel.setUserId(userId);
            managerModel.setAdminType(AdminType.APP_MNG);
            managerModel.setAppPackages(appPackageMangerVO.getAppPackages());
            managerModel.setCreatedBy(getUserId());
            managerModel.setDepartments(appPackageMangerVO.getDepartments());
            managerModel.setDataManage(appPackageMangerVO.getDataManage());
            managerModel.setAppManage(appPackageMangerVO.getAppManage());
            managerModel.setAdminGroups(appPackageMangerVO.getAdminGroups());
            managerModel.setRoleManage(appPackageMangerVO.getRoleManage());
            managerModel.setDataDictionaryManage(appPackageMangerVO.getDataDictionaryManage());
            managers.add(managerModel);
        }
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【updateAdmins()】,参数：managers=【{}】", toJson(managers));
        }
        updateAppAdmins(users, managers);

        return getOkResponseResult("创建管理员成功");
    }


    /**
     * 创建或者更新应用管理员
     *
     * @param users    当前提交的用户数据
     * @param managers 当前提交的数据组装后的管理员数据
     */
    private void updateAppAdmins(List<Map<String, String>> users, List<AdminModel> managers) {
        if (CollectionUtils.isNotEmpty(managers.get(0).getAppPackages())) {
            //去重
            List<AppPackageScopeModel> appPackages = managers.get(0).getAppPackages();
            List<AppPackageScopeModel> collect = appPackages.stream().collect(Collectors.toMap(AppPackageScopeModel::getCode, Function.identity(), (k1, k2) -> k1)).values().stream().collect(Collectors.toList());
            managers.get(0).setAppPackages(collect);
        }

        List<AdminModel> adminModels = getAdminFacade().updateAdmins(managers);
    }

//    @ApiOperation(value = "创建数据管理员", notes = "创建数据管理员")
//    @PostMapping("/create_datamanager")
//    public ResponseResult<Void> createDataAdmin(@RequestBody DataMangerVO dataMangerVO) {
//        List<Map<String, String>> users = dataMangerVO.getUsers();
//        if (CollectionUtils.isEmpty(users)) {
//            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id至少有一个");
//        }
//        //创建数据管理员
//        createDataAdmin(users, dataMangerVO.getAppPackages(), dataMangerVO.getDepartments(), dataMangerVO.getDataManage(), dataMangerVO.getDataQuery(), null);
//        return getOkResponseResult("创建管理员成功");
//    }

    @ApiOperation(value = "查询用户是否有数据管理员权限", notes = "查询用户是否有数据管理员权限")
    @PostMapping("/is_dataadmin")
    public ResponseResult<Map<String, Boolean>> isDataAdmin(@RequestBody List<AppPackageScopeModel> appPackageScopeModels) {
        Map<String, Boolean> result = new HashMap<>();
        if (CollectionUtils.isEmpty(appPackageScopeModels)) {
            return getOkResponseResult(result, "当前用户没有数据管理员权限");
        }
        List<AdminModel> adminModels = getAdminFacade().getAdminByUserId(getUserId());
        if (CollectionUtils.isEmpty(adminModels)) {
            return getOkResponseResult(result, "当前用户没有数据管理员权限");
        }
        Iterator<AdminModel> iterator = adminModels.iterator();
        while (iterator.hasNext()) {
            AdminModel adminModel = iterator.next();
            if (adminModel.getAdminType() == AdminType.ADMIN || adminModel.getAdminType() == AdminType.SYS_MNG) {
                appPackageScopeModels.forEach(appPackageScopeModel -> result.put(appPackageScopeModel.getCode(), true));
                return getOkResponseResult(result, "当前用户有数据管理员权限");
            }
            if (adminModel.getAdminType() == AdminType.APP_MNG) {
                //应用管理员移除，这里校验的是数据管理权限
                iterator.remove();
            }
        }
        List<AppPackageScopeModel> scopeModels = adminModels.stream().map(adminModel -> adminModel.getAppPackages()).flatMap(appPackageScopes -> appPackageScopes.stream()).collect(Collectors.toList());
        Map<String, AppPackageScopeModel> collect = scopeModels.stream().collect(Collectors.toMap(AppPackageScopeModel::getCode, Function.identity(), (k1, k2) -> k2));
        for (AppPackageScopeModel model : appPackageScopeModels) {
            AppPackageScopeModel appPackageScopeModel = collect.get(model.getCode());
            if (appPackageScopeModel == null) {
                result.put(model.getCode(), false);
            } else {
                result.put(model.getCode(), true);
            }
        }
        return getOkResponseResult(result, "当前用户有数据管理员权限");
    }

//    //创建数据管理员
//    private void createDataAdmin(List<Map<String, String>> users, List<AppPackageScopeModel> appPackageScopeModels, List<DepartmentScopeModel> departmentScopeModels, boolean isDataManager, boolean isDataQuery, AdminModel parentModel) {
//        List<AdminModel> managers = Lists.newArrayList();
//        PermissionManagementFacade permissionManagementFacade = getPermissionManagementFacade();
//        for (Map<String, String> user : users) {
//            String userId = user.get("id");
//            if (Strings.isNullOrEmpty(userId)) {
//                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id不能为空");
//            }
//            AdminModel managerModel;
//            String parentModelId = parentModel == null ? null : parentModel.getId();
//
//            managerModel = new AdminModel();
//            managerModel.setUserId(userId);
//            managerModel.setAdminType(AdminType.DATA_MNG);
//            managerModel.setAppPackages(appPackageScopeModels);
//            managerModel.setDepartments(departmentScopeModels);
//            managerModel.setDataManage(isDataManager);
//            managerModel.setDataQuery(isDataQuery);
//
//            if (StringUtils.isNotEmpty(parentModelId)) {
//                managerModel.setParentId(parentModelId);
//            }
//
//            if (parentModel != null && parentModel.getId() != null) {
//                //修改
//                managerModel.setModifiedBy(getUserId());
//            } else {
//                managerModel.setCreatedBy(getUserId());
//            }
//
//            managers.add(managerModel);
//
////            List<AppPackageScopeModel>appPackageScopeModels=new ArrayList<>();
////            List<DepartmentScopeModel>departmentScopeModels=new ArrayList<>();
////            repeatDel(dataMangerVO, adminModel, appPackageScopeModels, departmentScopeModels);
//        }
//        if (log.isDebugEnabled()) {
//            log.debug("\n调用引擎接口【updateAdmins()】,参数：managers=【{}】", toJson(managers));
//        }
//
//        permissionManagementFacade.updateAdmins(managers);
//    }

    //去重
    private void repeatDel(DataMangerVO dataMangerVO, AdminModel adminModel, List<AppPackageScopeModel> appPackageScopeModels, List<DepartmentScopeModel> departmentScopeModels) {
        if (adminModel != null) {
            //已经存在数据管理员权限
            //叠加
            Map<String, AppPackageScopeModel> appPackageScopeModelMapOld = adminModel.getAppPackages().stream().collect(Collectors.toMap(AppPackageScopeModel::getCode, Function.identity()));
            dataMangerVO.getAppPackages().forEach(action -> {
                if (appPackageScopeModelMapOld.get(action.getCode()) != null) {
                    appPackageScopeModelMapOld.remove(action.getCode());
                }
                appPackageScopeModels.add(action);
            });
            appPackageScopeModels.addAll(appPackageScopeModelMapOld.values());

            //部门去重
            Map<String, DepartmentScopeModel> departmentScopeModelMap = adminModel.getDepartments().stream().collect(Collectors.toMap(DepartmentScopeModel::getUnitId, Function.identity()));
            dataMangerVO.getDepartments().forEach(action -> {
                if (departmentScopeModelMap.get(action.getUnitId()) != null) {
                    departmentScopeModelMap.remove(action.getUnitId());
                }
                departmentScopeModels.add(action);
            });

            departmentScopeModels.addAll(departmentScopeModelMap.values());
            getAdminFacade().removeAdmin(adminModel.getId());
        } else {
            appPackageScopeModels.addAll(dataMangerVO.getAppPackages());
        }
    }

    @ApiOperation(value = "修改应用管理员", notes = "修改应用管理员")
    @PutMapping("/update_apppackagemanager")
    public ResponseResult<Void> updateAppPackageAdmin(@RequestBody AppPackageMangerVO appPackageMangerVO) {
        List<Map<String, String>> users = appPackageMangerVO.getUsers();
        if (CollectionUtils.isEmpty(users)) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id至少有一个");
        }

        String managerId = appPackageMangerVO.getId();
        validateNotEmpty(managerId, "管理员id不能为空");

        boolean loginUserHasAppPackageOrDeptScope = removeLoginUserNoHasAppPackageOrDeptScope(appPackageMangerVO.getAppPackages(), appPackageMangerVO.getDepartments(), users.get(0).get("id"), false);
        if (!loginUserHasAppPackageOrDeptScope) {
            throw new PortalException(40002, "存在没有权限的应用范围或者组织范围");
        }
        if (!new AppPermHelper(this).isHasMixedByLoginUserPermScopeAndSelectUserDepts(users.get(0).get("id"), appPackageMangerVO.getDepartments())) {
            throw new PortalException(40003, "当前管理员的组织权限范围和所选管理员所在部门及子部门没有交集，请重新选择有权限范围的管理员");
        }

        //处理编辑时组织管理范围只是用于展示的组织、展示的组织跳过权限校验
        List<DepartmentScopeModel> departments = appPackageMangerVO.getDepartments();
        List<DepartmentScopeModel> notAuthDepartments = appPackageMangerVO.getNotAuthDepartments();
        List<DepartmentScopeModel> totalDepartments = Lists.newArrayList();
        totalDepartments.addAll(departments);
        totalDepartments.addAll(notAuthDepartments);
        appPackageMangerVO.setDepartments(totalDepartments);
        List<DepartmentScopeModel> tempModels = Lists.newArrayList(totalDepartments);

        List<AdminModel> managers = Lists.newArrayList();
        //将没有权限的部分补回来
        addUserNoHasPerm(appPackageMangerVO);
        appPackageMangerVO.setDepartments(tempModels);

        for (Map<String, String> user : users) {
            String userId = user.get("id");
            if (Strings.isNullOrEmpty(userId)) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id不能为空");
            }
            redisCacheService.clearUserManagers(userId);
            AdminModel managerModel = new AdminModel();
            managerModel.setUserId(userId);
            managerModel.setId(managerId);
            managerModel.setAdminType(AdminType.APP_MNG);
            managerModel.setAppPackages(appPackageMangerVO.getAppPackages());
            managerModel.setDepartments(appPackageMangerVO.getDepartments());
            managerModel.setModifiedBy(getUserId());
            managerModel.setDataManage(appPackageMangerVO.getDataManage());
            managerModel.setAppManage(appPackageMangerVO.getAppManage());
            managerModel.setAdminGroups(appPackageMangerVO.getAdminGroups());
            managerModel.setRoleManage(appPackageMangerVO.getRoleManage());
            managerModel.setDataDictionaryManage(appPackageMangerVO.getDataDictionaryManage());
            managers.add(managerModel);
            //清除部门管理员管理范围的缓存
            redisTemplate.delete("app_mng:perm:department:id:" + userId);
            redisTemplate.delete("app_mng:perm:department:child:id:" + userId);
        }
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【updateAdmins()】,参数：managers=【{}】", toJson(managers));
        }
        updateAppAdmins(users, managers);
        return getOkResponseResult("更新管理员成功");
    }

    //添加当前用户没有的权限范围
    private void addUserNoHasPerm(AppPackageMangerVO appPackageMangerVO) {

        //当前登录用户管理权限
        List<AdminModel> adminModels = getAdminFacade().getAdminByUserId(getUserId());
        List<AppPackageScopeModel> hasAppSocpeMedels = new ArrayList<>();
        List<DepartmentScopeModel> hasDepartmentScopeModels = new ArrayList<>();
        //是否需要检查是否有管理范围权限，true是要检查，false表示是系统管理员或者超级管理员，不需要检查
        boolean check = true;
        for (AdminModel adminModel : adminModels) {
            if (AdminType.SYS_MNG == adminModel.getAdminType() || AdminType.ADMIN == adminModel.getAdminType()) {
                check = false;
                break;
            } else if (AdminType.APP_MNG == adminModel.getAdminType()) {
                hasAppSocpeMedels.addAll(adminModel.getAppPackages());
                hasDepartmentScopeModels.addAll(adminModel.getDepartments());
            }
        }


        if (check) {
            AdminModel admin = getAdminFacade().getAdmin(appPackageMangerVO.getId());
            //原应用权限范围
            List<AppPackageScopeModel> appPackages = admin.getAppPackages();
            Map<String, AppPackageScopeModel> appPackageScopeModelMap = appPackages.stream().collect(Collectors.toMap(AppPackageScopeModel::getCode, Function.identity(), (k1, k2) -> k2));

            hasAppSocpeMedels.stream().forEach(appPackageScopeModel -> {
                if (appPackageScopeModelMap.get(appPackageScopeModel.getCode()) != null) {
                    //如果应用管理员的应用权限范围已经在原应用权限范围内存在，则移除原应用权限范围，这样剩下的就是没有权限的了
                    appPackages.remove(appPackageScopeModelMap.get(appPackageScopeModel.getCode()));
                }
            });

            List<DepartmentScopeModel> departments = admin.getDepartments();
            Map<String, DepartmentScopeModel> departmentScopeModelMap = departments.stream().collect(Collectors.toMap(DepartmentScopeModel::getUnitId, Function.identity(), (k1, k2) -> k2));
            hasDepartmentScopeModels.stream().forEach(appPackageScopeModel -> {
                if (departmentScopeModelMap.get(appPackageScopeModel.getUnitId()) != null) {
                    //如果管理员传入的应用权限已经在原应用权限范围内存在，则移除原应用权限范围
                    departments.remove(departmentScopeModelMap.get(appPackageScopeModel.getUnitId()));
                }
            });

//            List<String> appPackageCodes = getAppPackageCodesByAdminTypeAndUserId(AdminType.DATA_MNG, appPackageMangerVO.getUsers().get(0).get("id"));
//            if (CollectionUtils.isNotEmpty(appPackages)) {
//                if (CollectionUtils.isNotEmpty(appPackageCodes)) {
//                    appPackages.forEach(appPackageScopeModel -> {
//                        if (appPackageCodes.contains(appPackageScopeModel.getCode())) {
//                            //已经存在数据管理员
//                            appPackageScopeModel.setDataManage(true);
//                        }
//                    });
//                }
//                appPackageMangerVO.getAppPackages().addAll(appPackages);
//            }
            if (CollectionUtils.isNotEmpty(departments)) {
                Map<String, DepartmentScopeModel> collect = appPackageMangerVO.getDepartments().stream().collect(Collectors.toMap(DepartmentScopeModel::getUnitId, Function.identity(), (k1, k2) -> k2));
                for (DepartmentScopeModel model : departments) {
                    if (collect.get(model.getUnitId()) == null) {
                        appPackageMangerVO.getDepartments().add(model);
                    }
                }

            }

        }
    }

//    @ApiOperation(value = "修改数据管理员", notes = "修改数据管理员")
//    @PutMapping("/update_datamanager")
//    public ResponseResult<Void> updateDataAdmin(@RequestBody DataMangerVO dataMangerVO) {
//        List<Map<String, String>> users = dataMangerVO.getUsers();
//        if (CollectionUtils.isEmpty(users)) {
//            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id至少有一个");
//        }
//        String managerId = dataMangerVO.getId();
//        validateNotEmpty(managerId, "管理员id不能为空");
//        List<AdminModel> managers = Lists.newArrayList();
//        for (Map<String, String> user : users) {
//            String userId = user.get("id");
//            if (Strings.isNullOrEmpty(userId)) {
//                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "用户id不能为空");
//            }
//            AdminModel managerModel = new AdminModel();
//            managerModel.setId(managerId);
//            managerModel.setUserId(userId);
//            managerModel.setAdminType(AdminType.DATA_MNG);
//            managerModel.setAppPackages(dataMangerVO.getAppPackages());
//            managerModel.setDepartments(dataMangerVO.getDepartments());
//            managerModel.setDataManage(dataMangerVO.getDataManage());
//            managerModel.setDataQuery(dataMangerVO.getDataQuery());
//            managerModel.setModifiedBy(getUserId());
//            managers.add(managerModel);
//        }
//        if (log.isDebugEnabled()) {
//            log.debug("\n调用引擎接口【updateAdmins()】,参数：managers=【{}】", toJson(managers));
//        }
//        getPermissionManagementFacade().updateAdmins(managers);
//        return getOkResponseResult("更新管理员成功");
//    }


    @ApiOperation(value = "删除管理员", notes = "系统管理员，应用管理员，数据管理员共用一个接口")
    @ApiImplicitParam(name = "id", value = "管理员id", required = true, dataType = "String", paramType = "query")
    @DeleteMapping("/delete_manager")
    public ResponseResult<Void> deleteAdmin(@RequestParam String id) {
        validateNotEmpty(id, "管理员id不能为空");
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【removeAdmin()】,参数：id=【{}】", id);
        }
        AdminModel admin = getAdminFacade().getAdmin(id);
        redisCacheService.clearUserManagers(admin.getUserId());
        if (admin.getAdminType() == AdminType.APP_MNG) {
            List<AdminModel> models = getAdminFacade().getAdminByParentId(id);
            if (CollectionUtils.isNotEmpty(models)) {
                getAdminFacade().removeAdmin(models.get(0).getId());
            }
        }

        getAdminFacade().removeAdmin(id);
        return getOkResponseResult("删除管理员成功");
    }

    /***********************************应用权限*************************************/
    @ApiOperation(value = "查询应用权限", notes = "通过应用编码查询应用权限")
    @ApiImplicitParam(name = "appCode", value = "应用编码", required = true, dataType = "String", paramType = "query")
    @GetMapping("/permission/get_apppackage")
    public ResponseResult<AppPackagePermissionModel> getAppPackagePermission(@RequestParam String appCode) {
        validateNotEmpty(appCode, "应用编码不能为空");
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【getAppPackagePermission()】appCode:{}", appCode);
        }
        AppPackagePermissionModel appPackagePermission = getPermissionManagementFacade().getAppPackagePermission(appCode);
        List<PermissionGroupModel> permissionGroups = appPackagePermission.getPermissionGroups();
        Iterator<PermissionGroupModel> iterator = permissionGroups.iterator();
        while (iterator.hasNext()) {
            PermissionGroupModel permissionGroupModel = iterator.next();
            department2ExternalUser(permissionGroupModel);
        }

        //处理那些数据模型权限组历史数据(未绑定应用管理权限组)
        List<PermissionGroupModel> permissionGroupModels = dealWithAllLonlyBizPermGroups(appCode);
        permissionGroups.addAll(permissionGroupModels);
        return getOkResponseResult(appPackagePermission, "查询应用权限成功");
    }

    private void updateBizPermGroups(PermissionGroupModel permissionGroupModel) {
        List<AppFunctionPermissionModel> appFunctionPermissionModels = permissionGroupModel.getDataPermissionGroups();
        if (appFunctionPermissionModels == null) {
            return;
        }
        for (AppFunctionPermissionModel appFunctionPermissionModel : appFunctionPermissionModels) {
            String schemaCode = appFunctionPermissionModel.getSchemaCode();
            List<BizPermGroupModel> bizPermGroupModels = getAppManagementFacade().getBizPermGroupsBySchemaCode(schemaCode);
            for (BizPermGroupModel bizPermGroupModel : bizPermGroupModels) {
                if (appFunctionPermissionModel.getPermissionGroupId().equals(bizPermGroupModel.getAppPermGroupId())) {
                    appFunctionPermissionModel.setPropertityPermissionGroups(getAppManagementFacade().getBizPermPropertiesByGroupId(bizPermGroupModel.getId()));
                }
            }
        }
    }

    private List<PermissionGroupModel> dealWithAllLonlyBizPermGroups(String appCode) {
        //获取appCode下所有的bizModel
        List<PermissionGroupModel> permissionGroupModels = Lists.newArrayList();
        List<AppFunctionModel> appFunctionModels = getAppManagementFacade().getAppFunctionsByAppCode(appCode).stream()
                .filter(t -> t.getType() == BizModel).collect(Collectors.toList());
        for (AppFunctionModel appFunctionModel : appFunctionModels) {
            String schemaCode = appFunctionModel.getCode();
            List<BizPermGroupModel> bizPermGroupModels = getAppManagementFacade().getBizPermGroupsBySchemaCode(schemaCode);
            //获取bizModel的所有权限组
            for (BizPermGroupModel bizPermGroupModel : bizPermGroupModels) {
                if (bizPermGroupModel.getAppPermGroupId() == null) {
                    //未绑定应用管理权限组，给生成一个
                    log.debug("have no appPermGroupId schemaCode is {} and bizPermGroupId is {}", schemaCode, bizPermGroupModel.getId());
                    PermissionGroupModel permissionGroupModel = getPermissionManagementFacade().getInitPermissionGroupByAppCode(appCode);
                    updatePermissionGroupWithBizPermGroup(permissionGroupModel, bizPermGroupModel);
                    permissionGroupModel.setAppCode(appCode);
                    //todo 先关掉保存，不然没有历史数据了
                    permissionGroupModel = getPermissionManagementFacade().updatePermissionGroup(permissionGroupModel);
                    //permissionGroupModel.setDataPermissionGroups(null);//增加完权限组之后，前端此时不需要详细数据
                    permissionGroupModels.add(permissionGroupModel);
                    bizPermGroupModel.setAppPermGroupId(permissionGroupModel.getId());
                    //更新关联
                    getAppManagementFacade().addBizPermGroup(bizPermGroupModel);
                }
            }
        }
        return permissionGroupModels;
    }


    private PermissionGroupModel updatePermissionGroupWithBizPermGroup(PermissionGroupModel permissionGroupModel, BizPermGroupModel model) {
        permissionGroupModel.setName(model.getName());
        permissionGroupModel.setAuthorType(model.getAuthorType());
        permissionGroupModel.setDepartments(model.getDepartments());
        permissionGroupModel.setRoles(model.getRoles());
        return permissionGroupModel;
    }


    @ApiOperation(value = "修改应用权限", notes = "修改应用权限")
    @PutMapping("/permission/update_apppackage")
    public ResponseResult<Void> updateAppPackagePermission(@RequestBody AppPackagePermissionVO appPackagePermissionVO) {
        VisibleType visibleType = appPackagePermissionVO.getVisibleType();
        String appCode = appPackagePermissionVO.getAppCode();
        if (visibleType == null) {
            throw new PortalException(ErrCode.PERMISSION_MANAGER_TYPE_EMPTY.getErrCode(),
                    ErrCode.PERMISSION_MANAGER_TYPE_EMPTY.getErrMsg());
        }
        validateNotEmpty(appCode, ErrCode.APP_PACKAGE_CODE_EMPTY.getErrMsg());
        AppPackageModel appPackageModel = new AppPackageModel();
        appPackageModel.setCode(appCode);
        AppPackagePermissionModel appPackagePermissionModel = new AppPackagePermissionModel();
        appPackagePermissionModel.setAppPackage(appPackageModel);
        appPackagePermissionModel.setVisibleType(visibleType);
        appPackagePermissionModel.setModifiedBy(getUserId());
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【updateAppPackagePermission()】appPackagePermissionModel:{}", toJson(appPackagePermissionModel));
        }
        getPermissionManagementFacade().updateAppPackagePermission(appPackagePermissionModel);

        return getOkResponseResult("修改应用权限成功");
    }

    @ApiOperation(value = "查询权限组", notes = "通过权限组id查询权限组")
    @GetMapping("/permission/get_group")
    public ResponseResult<PermissionGroupModel> getPermissionGroup(String id, String appCode) {
        if (StringUtils.isEmpty(id) && StringUtils.isEmpty(appCode)) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "权限组ID和应用编码不能同时为空");
        }
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【getPermissionGroup()】id:{}", id);
        }
        PermissionGroupModel permissionGroupModel = null;
        if (StringUtils.isNotEmpty(id)) {
            permissionGroupModel = getPermissionManagementFacade().getPermissionGroup(id);
            updateBizPermGroups(permissionGroupModel);
            department2ExternalUser(permissionGroupModel);
            return getOkResponseResult(permissionGroupModel, "查询权限组成功");
        }
        if (StringUtils.isNotEmpty(appCode)) {
            permissionGroupModel = getPermissionManagementFacade().getInitPermissionGroupByAppCode(appCode);
            department2ExternalUser(permissionGroupModel);
            return getOkResponseResult(permissionGroupModel, "查询权限组成功");
        }
        return null;
    }

    @ApiOperation(value = "创建权限组", notes = "创建权限组")
    @PostMapping("/permission/create_group")
    public ResponseResult<Void> createPermissionGroup(@RequestBody PermissionGroupModel permissionGroupModel) {
        validatePermissionGroup(permissionGroupModel);
        permissionGroupModel.setCreatedBy(getUserId());
        externalUser2Department(permissionGroupModel);
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【addPermissionGroup()】，permissionGroupModel：{}", toJson(permissionGroupModel));
        }
        getPermissionManagementFacade().addPermissionGroup(permissionGroupModel);
        return getOkResponseResult("创建权限组成功");
    }

    private List<BizPermPropertyModel> getPropertityPermissionGroupsById(String groupId) {
        List<BizPermPropertyModel> permProperties = getAppManagementFacade().getBizPermPropertiesByGroupId(groupId);
        if (CollectionUtils.isEmpty(permProperties)) {
            return null;
        }
        String schemaCode = null;
        List<BizPermPropertyModel> bizPermPropertyModels = permProperties.stream().filter(t -> t.getPropertyType().equals(BizPropertyType.CHILD_TABLE)).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(bizPermPropertyModels)) {
            schemaCode = bizPermPropertyModels.get(0).getSchemaCode();
        } else {
            schemaCode = permProperties.get(0).getSchemaCode();
        }
        BizSchemaModel bizSchema = getAppManagementFacade().getBizSchemaBySchemaCode(schemaCode, true);
        List<BizPropertyModel> bizPropertyModels = bizSchema.getProperties();
        List<BizPropertyModel> bizPropertyModelsTemplate = new ArrayList<>();
        for (BizPropertyModel bizPropertyModel : bizPropertyModels) {
            bizPropertyModelsTemplate.add(bizPropertyModel);
            if (bizPropertyModel.getPropertyType().equals(BizPropertyType.CHILD_TABLE)) {
                bizPropertyModelsTemplate.addAll(bizPropertyModel.getSubSchema().getProperties());
            }
        }
        for (BizPropertyModel bizPropertyModel : bizPropertyModelsTemplate) {
            for (BizPermPropertyModel permProperty : permProperties) {
                if (permProperty.getPropertyCode().equals(bizPropertyModel.getCode()) && permProperty.getSchemaCode().equals(bizPropertyModel.getSchemaCode())) {
                    permProperty.setName(bizPropertyModel.getName());
                    permProperty.setName_i18n(bizPropertyModel.getName_i18n());
                }
            }
        }
        return permProperties;
    }

    private void externalUser2Department(PermissionGroupModel permissionGroupModel) {
        Boolean externalUser = permissionGroupModel.getExternalUser();
        if (externalUser) {
            String departments = permissionGroupModel.getDepartments();
            List<DepartmentUnitVO> list = Lists.newArrayList();
            if (StringUtils.isNotEmpty(departments)) {
                try {
                    list = JSONArray.parseArray(departments, DepartmentUnitVO.class);
                } catch (Exception e) {
                    log.warn(e.getMessage(), e);
                }
            }

            list.add(new DepartmentUnitVO(3, "外部用户", EXTERNAL_USER_ID));
            permissionGroupModel.setDepartments(JSON.toJSONString(list));
        }
    }


    private void department2ExternalUser(PermissionGroupModel permissionGroupModel) {
        String departments = permissionGroupModel.getDepartments();
        String roles = permissionGroupModel.getRoles();
        if (StringUtils.isNotEmpty(departments)) {
            List<DepartmentUnitVO> list = JSONArray.parseArray(departments, DepartmentUnitVO.class);
            List<DepartmentUnitVO> departmentList = Lists.newArrayList();
            for (DepartmentUnitVO arg : list) {
                if (log.isDebugEnabled()) {
                    log.debug("类型：{}", arg.getUnitType());
                }
                if (EXTERNAL_USER_ID.equals(arg.getId())) {
                    permissionGroupModel.setExternalUser(true);
                } else {
                    if (arg.getUnitType() == UnitType.DEPARTMENT.getIndex()) {
                        DepartmentModel department = getOrganizationFacade().getDepartment(arg.getId());
                        if (department == null || department.getDeleted()) {
                            continue;
                        }
                    }
                    if (arg.getUnitType() == UnitType.USER.getIndex()) {
                        UserModel user = getOrganizationFacade().getUser(arg.getId());
                        if (user == null || (user.getStatus() != null && !user.getStatus().equals(UserStatus.ENABLE))) {
                            continue;
                        }
                    }
                    departmentList.add(arg);
                }
            }
            permissionGroupModel.setDepartments(JSON.toJSONString(departmentList));
        }
        if (StringUtils.isNotEmpty(roles)) {
            List<Map> maps = JSONArray.parseArray(roles, Map.class);
            List<Map> mapsTemplate = new ArrayList<>();
            for (Map map : maps) {
                String id = (String) map.get("id");
                RoleModel roleModel = getOrganizationFacade().getRole(id);
                if (roleModel == null) {
                    continue;
                }
                mapsTemplate.add(map);
            }
            permissionGroupModel.setRoles(JSON.toJSONString(mapsTemplate));
        }
    }

    /**
     * 校验权限组相关参数
     *
     * @param permissionGroupModel 应用管理关联对象
     */
    private void validatePermissionGroup(@RequestBody PermissionGroupModel permissionGroupModel) {
        validateName(permissionGroupModel.getName());
        String appCode = permissionGroupModel.getAppCode();
        validateNotEmpty(appCode, "应用编码不能为空");
        String name = permissionGroupModel.getName();
        validateNotEmpty(name, "权限组名称不能为空");
        validateChineseLength(name, 50);
        String departments = permissionGroupModel.getDepartments();
        String roles = permissionGroupModel.getRoles();
        boolean externalUser = permissionGroupModel.getExternalUser() == null ? false : permissionGroupModel.getExternalUser();
        if (Strings.isNullOrEmpty(departments) && Strings.isNullOrEmpty(roles) && !externalUser) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "组织范围，角色范围，外部用户至少一个不能为空");
        }
    }

    @ApiOperation(value = "修改权限组", notes = "修改权限组")
    @PutMapping("/permission/update_group")
    public ResponseResult<PermissionGroupModel> updatePermissionGroup(@RequestBody PermissionGroupModel permissionGroupModel) {
        validatePermissionGroup(permissionGroupModel);
        externalUser2Department(permissionGroupModel);
        String userId = getUserId();
        if (StringUtils.isEmpty(permissionGroupModel.getId())) {
            permissionGroupModel.setCreatedBy(userId);
        }
        permissionGroupModel.setModifiedBy(userId);
        List<AppFunctionPermissionModel> appFunctionPermissionModels = permissionGroupModel.getDataPermissionGroups();
        if (CollectionUtils.isNotEmpty(appFunctionPermissionModels)) {
            for (AppFunctionPermissionModel appFunctionPermissionModel : appFunctionPermissionModels) {

                appFunctionPermissionModel.setModifiedBy(getUserId());
                List<AppFunctionPermissionConditionModel> conditions = appFunctionPermissionModel.getConditions();
                if (CollectionUtils.isNotEmpty(conditions)) {
                    for (AppFunctionPermissionConditionModel condition : conditions) {
                        condition.setModifiedBy(getUserId());
                    }
                }
            }
        }
        if (log.isDebugEnabled()) {
            log.debug("\n 调用引擎接口【updatePermissionGroup() 】，{}", toJson(permissionGroupModel));
        }
        permissionGroupModel = getPermissionManagementFacade().updatePermissionGroup(permissionGroupModel);

        //清除缓存数据

        redisCacheService.clearUserMAppPackages(userId);
        redisCacheService.clearUserPCAppPackages(userId);

        return getOkResponseResult(permissionGroupModel, "修改权限组成功");
    }

    @ApiOperation(value = "删除权限组", notes = "删除权限组")
    @ApiImplicitParam(name = "id", value = "权限组id", required = true, dataType = "String", paramType = "query")
    @DeleteMapping("/permission/delete_group")
    public ResponseResult<Void> deletePermissionGroup(@RequestParam String id) {
        validateNotEmpty(id, "权限组id不能为空");
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【removePermissionGroup()】id:{}", id);
        }
        AdminModel model = getAppAdminByUserId(getUserId(), true);
        if (model != null && model.getAdminType() == AdminType.APP_MNG) {
            //应用管理员
            PermissionGroupModel permissionGroup = getPermissionManagementFacade().getPermissionGroup(id);
            if (isLoginUserHasPermByGroup(permissionGroup)) {
                getPermissionManagementFacade().removePermissionGroup(id);
                deleteAllBizPermGroups(id);
            }
        } else {
            getPermissionManagementFacade().removePermissionGroup(id);
            deleteAllBizPermGroups(id);
        }
        return getOkResponseResult("删除权限组成功");
    }

    private void deleteAllBizPermGroups(String appPermGroupId) {
        //获取appPermGroupId下所有的bizModel
        List<BizPermGroupModel> bizPermGroupModels = getAppManagementFacade().getBizPermGroupsByAppPermGroupId(appPermGroupId);
        for (BizPermGroupModel bizPermGroupModel : bizPermGroupModels) {
            getAppManagementFacade().removeBizPermGroupByGroupId(bizPermGroupModel.getId());
        }
    }

    /**
     * 当前登录用户是否对该权限组有权限，只要组织范围有一个没有权限，就返回false
     */
    private boolean isLoginUserHasPermByGroup(PermissionGroupModel permissionGroupModel) {
        String departments = permissionGroupModel.getDepartments();
        List<String> deptIds = new ArrayList<>();
        List<String> userIds = new ArrayList<>();
        if (StringUtils.isNotEmpty(departments)) {
            JSONArray objects = JSON.parseArray(departments);
            for (int x = 0; x < objects.size(); x++) {
                JSONObject jsonObject = objects.getJSONObject(x);
                String id = jsonObject.getString("id");
                String unitType = jsonObject.getString("unitType");
                if (UnitType.DEPARTMENT.getIndex() == Integer.parseInt(unitType)) {
                    deptIds.add(id);
                } else {
                    userIds.add(id);
                }
            }
        }

        String collect = String.join(",", deptIds);
        String userIdscollect = String.join(",", userIds);
        Map<String, PermVo> permVoMap = null;
        try {
            permVoMap = new AppPermHelper(this).checkLoginUserIsHasPermByTargetId(collect, userIdscollect, PermSourceType.DEPT_USER).stream().collect(Collectors.toMap(PermVo::getTargetId, Function.identity(), (k1, k2) -> k1));
        } catch (Exception e) {
        }
        if (MapUtils.isNotEmpty(permVoMap)) {
//            AtomicBoolean flag= new AtomicBoolean(true);
            permVoMap.forEach((k, v) -> {
                if (!v.isOp()) {
                    throw new PortalException(7000030, "您无此部门/人员的管理范围，无法删除");
                }
            });
            return true;
        }
        return false;
    }


    @ApiOperation(value = "查询权限过滤条件", notes = "查询权限过滤条件")
    @ApiImplicitParam(name = "functionId", value = "模型编码", required = true, dataType = "String", paramType = "query")
    @GetMapping("/permission/list_condition")
    public ResponseResult<List<AppFunctionPermissionConditionModel>> listPermissionCondition(@RequestParam String functionId) {
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【getAppFunctionPermissionConditionsByFunctionId()】functionId:{}", functionId);
        }
        List<AppFunctionPermissionConditionModel> appFunctionPermissionConditions = getPermissionManagementFacade()
                .getAppFunctionPermissionConditionsByFunctionId(functionId);
        return getOkResponseResult(appFunctionPermissionConditions, "查询权限过滤条件成功");
    }


    @ApiOperation(value = "查询是否展示新手引导", notes = "根据用户id，页面类型是否展示新手引导")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "pageType", value = "页面类型", example = PageType.DESCRIPTION, allowableValues = "0,1,2,3,4,5,6,7", required = true, dataType = "int", paramType = "query")
    })
    @GetMapping("/get_user_guide")
    public ResponseResult<UserGuideModel> getUserGuide(@RequestParam Integer pageType) {
        String userId = getUserId();
        validateNotEmpty(userId, "用户id不能为空");
        if (pageType == null) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "页面类型不能为空");
        }
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【getUserGuide()】userId:{}，pageType:{}", userId, pageType);
        }
        UserGuideModel userGuide = getSystemManagementFacade().getUserGuide(userId, PageType.get(pageType));
        if (userGuide == null) {
            userGuide = new UserGuideModel();
            userGuide.setUserId(userId);
            userGuide.setPageType(PageType.get(pageType));
            userGuide.setDisplay(true);
        }
        return getOkResponseResult(userGuide, "查询新手引导成功");
    }

    @ApiOperation(value = "更新新手引导", notes = "更新新手引导")
    @PutMapping("/update_user_guide")
    public ResponseResult<Void> updateUserGuide(@RequestBody UserGuideModel userGuideModel) {

        validateNotEmpty(userGuideModel.getUserId(), "用户id不能为空");
        if (userGuideModel.getPageType() == null) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "页面类型不能为空");
        }

        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【updateUserGuide()】userGuideModel:{}", toJson(userGuideModel));
        }
        getSystemManagementFacade().updateUserGuide(userGuideModel);
        return getOkResponseResult("更新新手引导成功");
    }


    @ApiOperation(value = "修改组织维护配置开关：0-默认钉钉维护，1-云枢客户自主维护", notes = "修改组织配置开关")
    @PutMapping("/modify_cloudpivot")
    public ResponseResult<Void> updateIsCloudPivot(Integer cloudPivotType) {
        if (Objects.isNull(cloudPivotType)) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "配置开关值不能为空");
        }
        SystemSettingModel settingModel = getSystemManagementFacade().getSystemSettingBySettingCode(IS_CLOUD_PIVOT_KEY);

        OrganizationFacade organizationFacade = getOrganizationFacade();
        List<DepartmentModel> models = organizationFacade.getRootDepartment();

        List<RelatedCorpSettingModel> relatedCorpSettingModels = getSystemManagementFacade().getAllRelatedCorpSettingModelByOrgType(OrgType.MAIN);
        String corpId = null;

        if (CollectionUtils.isNotEmpty(relatedCorpSettingModels)) {
            corpId = relatedCorpSettingModels.get(0).getCorpId();
        }

        if (CollectionUtils.isNotEmpty(models)) {
            boolean hasOrgData = false;   //是否有组织数据
            List<DepartmentModel> clearDept = new ArrayList<>();   //如果没有数据的情况下，需要移除的部门和角色数据

            for (DepartmentModel departmentModel : models) {
                if (Objects.nonNull(departmentModel)) {
                    if (StringUtils.isNotEmpty(corpId) && StringUtils.isNotEmpty(departmentModel.getCorpId()) && departmentModel.getCorpId().equals(corpId)) {
                        //只有一个根部门
                        boolean isHasUser = isHasUser(departmentModel);
                        boolean hasDepartment = isHasDepartment(departmentModel);
                        if (isHasUser || hasDepartment) {
                            hasOrgData = true;
                            break;
                        }
                        clearDept.add(departmentModel);
                    }
                }
            }
            if (hasOrgData) {
                return getErrResponseResult(10110L, "已有部门或者用户数据导入，不能再次修改组织维护开关");
            }
            if (!clearDept.isEmpty() && "1".equals(settingModel.getSettingValue()) && cloudPivotType != 1) {
                for (DepartmentModel departmentModel : clearDept) {
                    organizationFacade.removeDepartment(departmentModel);
                }
                //删除默认角色组和部门主管角色
                removeDefaultRoleGroupAndRole();
            }
        }

        if (Objects.isNull(settingModel)) {
            SystemSettingModel systemSettingModel = new SystemSettingModel(IS_CLOUD_PIVOT_KEY, cloudPivotType.toString(), SettingType.CLOUDPIVOT_MODE);
            getSystemManagementFacade().addSystemSetting(systemSettingModel);
        } else {
            settingModel.setSettingValue(cloudPivotType.toString());
            getSystemManagementFacade().updateSystemSetting(settingModel);
        }
        //添加维护relatedsetting的动作
        List<RelatedCorpSettingModel> allRelatedCorpSettingModelByOrgType = getSystemManagementFacade().getAllRelatedCorpSettingModelByOrgType(OrgType.MAIN);
        if (CollectionUtils.isNotEmpty(allRelatedCorpSettingModelByOrgType)) {
            RelatedCorpSettingModel relatedCorpSettingModel = allRelatedCorpSettingModelByOrgType.get(0);
            if (cloudPivotType == 0) {
                relatedCorpSettingModel.setSyncType(OrgSyncType.PULL);
                relatedCorpSettingModel.setRelatedType(CorpRelatedType.DINGTALK);
                relatedCorpSettingModel.setName(null);
            } else if (cloudPivotType == 2) {
                relatedCorpSettingModel.setSyncType(OrgSyncType.PULL);
                relatedCorpSettingModel.setRelatedType(CorpRelatedType.WECHAT);
                relatedCorpSettingModel.setName(null);
            } else {
                relatedCorpSettingModel.setSyncType(OrgSyncType.PUSH);
                relatedCorpSettingModel.setRelatedType(CorpRelatedType.OTHER);
            }
            getSystemManagementFacade().updateRelatedCorpSetting(relatedCorpSettingModel);
        }
        return getOkResponseResult("修改组织维护开关成功");
    }

    //删除默认角色组和部门主管角色
    private void removeDefaultRoleGroupAndRole() {
        OrganizationFacade organizationFacade = getOrganizationFacade();
        //删除默认角色组和部门主管角色
        List<RoleModel> roleModels = organizationFacade.getRoles();
        if (CollectionUtils.isNotEmpty(roleModels)) {
            roleModels.stream().forEach(roleModel -> organizationFacade.removeRole(roleModel));
        }
        List<RoleGroupModel> roleGroupModels = organizationFacade.getRoleGroups();
        if (CollectionUtils.isNotEmpty(roleGroupModels)) {
            roleGroupModels.stream().forEach(roleGroupModel -> organizationFacade.removeRoleGroup(roleGroupModel));
        }
    }

    private boolean isHasUser(DepartmentModel departmentModel) {
        List<UserModel> userModels = getOrganizationFacade().getUsersByDeptId(departmentModel.getId());
        boolean isHasUser = false;
        if (CollectionUtils.isNotEmpty(userModels)) {
            //可以修改
            //原来设置为云枢维护，后来是第三方如钉钉维护，需要将根节点删除
            if (userModels.size() == 1) {
                if (isAdmin(userModels.get(0))) {
                    isHasUser = false;
                } else {
                    isHasUser = true;
                }
            } else {
                isHasUser = true;
            }
        }
        return isHasUser;
    }

    private boolean isAdmin(UserModel userModel) {
        List<AdminModel> adminModels = getAdminFacade().getAdminByUserId(userModel.getId());
        boolean flag = false;
        for (AdminModel adminModel : adminModels) {
            if (adminModel.getAdminType() == AdminType.ADMIN) {
                flag = true;
            }
        }
        return flag;
    }

    //是否已经存在部门
    private boolean isHasDepartment(DepartmentModel rootDept) {
        List<DepartmentModel> departments = getOrganizationFacade().getDepartments();
        if (CollectionUtils.isNotEmpty(departments)) {
            for (DepartmentModel departmentModel : departments) {
                if (!rootDept.getId().equals(departmentModel.getId())) {
                    return true;
                }
            }
        }
        return false;
    }

    @ApiOperation(value = "获取组织配置开关：true,已配置过，false未配置过", notes = "获取组织配置开关")
    @GetMapping("/is_cloudpivot")
    public ResponseResult<Boolean> isCloudPivot() {

        DepartmentModel departmentModel = getOrganizationFacade().getRootDepartment().get(0);
        if (Objects.nonNull(departmentModel)) {
            if (isHasUser(departmentModel)) {
                return getOkResponseResult(true, "获取组织配置开关成功，已有用户,已配置过，不能再修改");
            }
            if (isHasDepartment(departmentModel)) {
                return getOkResponseResult(true, "获取组织配置开关成功,已有部门,已配置过，不能再修改");
            }
        }
        SystemSettingModel settingModel = getSystemManagementFacade().getSystemSettingBySettingCode(IS_CLOUD_PIVOT_KEY);
        if (Objects.isNull(settingModel)) {
            return getOkResponseResult(false, "获取组织配置开关成功,未配置过");
        }
        return getOkResponseResult(false, "获取组织配置开关成功,配置过，但还可以修改");
    }

    private void registerOrUpdateCallbackUrl(RelatedCorpSettingModel relatedCorpSettingModel) {
        if (OrgSyncType.PUSH == relatedCorpSettingModel.getSyncType()) {
            return;
        }
        try {
            if (CorpRelatedType.CUSTOMIZE == relatedCorpSettingModel.getRelatedType() && StringUtils.isNotBlank(relatedCorpSettingModel.getSynRedirectUri())) {
                getOrganizationFacade().registerCallbackUrl(relatedCorpSettingModel);
            }
            if (CorpRelatedType.DINGTALK == relatedCorpSettingModel.getRelatedType()) {
                String url = getSystemManagementFacade().getCallBackUrl(relatedCorpSettingModel);
                if (StringUtils.isBlank(url)) {
                    getSystemManagementFacade().registerCallBackUrl(relatedCorpSettingModel);
                } else {
                    getSystemManagementFacade().updateCallBackUrl(relatedCorpSettingModel);
                }
            }
        } catch (Exception e) {
            log.warn("创建关联组织时注册钉钉回调地址失败：", e);
            throw new PortalException(ResultEnum.DING_SYNC_ERR.getErrCode(), "注册回调地址失败，请修改参数连接测试成功后重新保存");
        }
    }


    @ApiOperation(value = "查询钉钉关联组织", notes = "查询钉钉关联组织 废弃建议使用/all_pull_list 当前只查询钉钉相关的同步组织")
    @GetMapping("/relatedcorp/all_dingtalk_list")
    @Deprecated
    public ResponseResult<List<RelatedCorpSettingModel>> getDingCoprSetting() {
        List<RelatedCorpSettingModel> allRelatedCorpSettingModel = getSystemManagementFacade().getAllRelatedCorpSettingModelByType(CorpRelatedType.DINGTALK);
        if (CollectionUtils.isNotEmpty(allRelatedCorpSettingModel)) {
            allRelatedCorpSettingModel = allRelatedCorpSettingModel.stream().filter(item -> OrgSyncType.PULL == item.getSyncType()).collect(Collectors.toList());
            for (RelatedCorpSettingModel relatedCorpSettingModel : allRelatedCorpSettingModel) {
                if (OrgType.MAIN == relatedCorpSettingModel.getOrgType() && StringUtils.isEmpty(relatedCorpSettingModel.getName())) {
                    relatedCorpSettingModel.setName("主组织");
                }
            }
        }
        return getOkResponseResult(allRelatedCorpSettingModel, "查询钉钉关联组织");
    }

    @ApiOperation(value = "查询需要同步的组织列表", notes = "查询需要同步的组织列表")
    @GetMapping("/relatedcorp/all_pull_list")
    public ResponseResult<List<RelatedCorpSettingModel>> getAllPullList() {
        List<RelatedCorpSettingModel> allRelatedCorpSettingModel = getSystemManagementFacade().getAllRelatedCorpSettingModel();
        if (CollectionUtils.isNotEmpty(allRelatedCorpSettingModel)) {
            allRelatedCorpSettingModel = allRelatedCorpSettingModel.stream().filter(item -> !Boolean.TRUE.equals(item.getDeleted()) && OrgSyncType.PULL == item.getSyncType()).collect(Collectors.toList());
            for (RelatedCorpSettingModel relatedCorpSettingModel : allRelatedCorpSettingModel) {
                if (OrgType.MAIN == relatedCorpSettingModel.getOrgType()) {
                    relatedCorpSettingModel.setName("主组织");
                }
            }
        }
        return getOkResponseResult(allRelatedCorpSettingModel, "查询需要同步组织列表");
    }

    @ApiOperation(value = "创建关联组织", notes = "创建关联组织")
    @PostMapping("/relatedcorp/add")
    public ResponseResult<RelatedCorpSettingModel> createRelatedCorpSetting(@RequestBody RelatedCorpSettingModel relatedCorpSettingModel) {
        if (!isAdmin()) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "非超级管理员不能操作");
        }
        String orgName = relatedCorpSettingModel.getOrgTypeStr();
        RelatedCorpSettingModel save = addRelatedSetting(relatedCorpSettingModel);
        return getOkResponseResult(save, "创建" + orgName + "成功");
    }

    private RelatedCorpSettingModel addRelatedSetting(RelatedCorpSettingModel relatedCorpSettingModel) {
        //TODO 关联组织自维护若corpId为空，自动生成一个corpId
        if (OrgType.RELEVANCE == relatedCorpSettingModel.getOrgType()) {
            if (StringUtils.isEmpty(relatedCorpSettingModel.getCorpId())) {
                relatedCorpSettingModel.setCorpId(OrgType.RELEVANCE.name() + "-" + UUID.randomUUID().toString().replace("-", ""));
            }
            if (CollectionUtils.isEmpty(getSystemManagementFacade().getAllRelatedCorpSettingModel())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "设置关联组织前请设置主组织");
            }
        }
        dingTalkValidation(relatedCorpSettingModel);
        relatedCorpSettingModel.setCreatedBy(getUserId());

        checkOrgName(relatedCorpSettingModel);
        checkAppkey(relatedCorpSettingModel);
        checkConfigSetting(relatedCorpSettingModel);

        registerOrUpdateCallbackUrl(relatedCorpSettingModel);
        RelatedCorpSettingModel save = getSystemManagementFacade().addRelatedCorpSetting(relatedCorpSettingModel);
        createDefaultRole(save);
        return save;
    }

    @ApiOperation(value = "删除关联组织", notes = "删除关联组织")
    @DeleteMapping("/relatedcorp/delete")
    public ResponseResult<Boolean> deleteRelatedCorpSetting(@RequestParam String id) {
        RelatedCorpSettingModel relatedCorpSettingModel = getSystemManagementFacade()
                .getRelatedCorpSettingModel(id);
        if (relatedCorpSettingModel == null) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "删除的关联组织不存在");
        }
        if (!isAdmin()) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "非超级管理员不能操作");
        }
        if (OrgType.MAIN == relatedCorpSettingModel.getOrgType()) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "主组织不能删除");
        }
        String orgName = relatedCorpSettingModel.getOrgTypeStr();
        boolean delete = deleteRelatedSetting(relatedCorpSettingModel);
        if (delete) {
            return getOkResponseResult(Boolean.TRUE, "删除" + orgName + "成功");
        }
        return getOkResponseResult(Boolean.FALSE, "删除" + orgName + "失败");
    }

    @ApiOperation(value = "删除关联组织判断", notes = "删除关联组织判断")
    @DeleteMapping("/relatedcorp/delete_check")
    public ResponseResult<Boolean> deleteCheckRelatedCorpSetting(@RequestParam String id) {
        RelatedCorpSettingModel relatedCorpSettingModel = getSystemManagementFacade()
                .getRelatedCorpSettingModel(id);
        if (relatedCorpSettingModel == null) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "删除的关联组织不存在");
        }
        if (!isAdmin()) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "非超级管理员不能操作");
        }
        if (OrgType.MAIN == relatedCorpSettingModel.getOrgType()) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "主组织不能删除");
        }
        String orgName = relatedCorpSettingModel.getOrgTypeStr();
        boolean delete = deleteCheckRelatedSetting(relatedCorpSettingModel);
        if (delete) {
            return getOkResponseResult(Boolean.TRUE, orgName + "可以删除");
        }
        return getOkResponseResult(Boolean.FALSE, orgName + "不可删除");
    }

    private boolean deleteRelatedSetting(RelatedCorpSettingModel source) {
        List<DepartmentModel> departmentsByCorpId = getOrganizationFacade().getDepartmentsByCorpId(source.getCorpId(), false);
        if (CollectionUtils.isNotEmpty(departmentsByCorpId) && departmentsByCorpId.size() > 1) {
            log.error("该组织已存在子部门，请清空后再删除:" + source.getCorpId());
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "该组织已存在子部门，请清空部门后再删除");
        }
        if (getOrganizationFacade().countUser(source.getCorpId(), false) != 0) {
            log.error("该组织已存在用户，请清空后再删除:" + source.getCorpId());
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "该组织已存在用户，请清空后再删除");
        }
        List<RoleGroupModel> roleGroupsByCorpId = getOrganizationFacade().getRoleGroupByCorpId(source.getCorpId());
        if (CollectionUtils.isNotEmpty(roleGroupsByCorpId) && roleGroupsByCorpId.size() > 1) {
            log.error("该组织已存在除默认角色组外的角色组，请清空后再删除:" + source.getCorpId());
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "该组织已存在除默认角色组外的角色组，请清空后再删除");
        }
        return getSystemManagementFacade().deleteRelatedCorpSettingModel(source);
    }

    private boolean deleteCheckRelatedSetting(RelatedCorpSettingModel source) {
        List<DepartmentModel> departmentsByCorpId = getOrganizationFacade().getDepartmentsByCorpId(source.getCorpId(), false);
        if (CollectionUtils.isNotEmpty(departmentsByCorpId) && departmentsByCorpId.size() > 1) {
            log.debug("该组织已存在子部门，请清空部门后再删除:" + source.getCorpId());
            return false;
        }
        if (getOrganizationFacade().countUser(source.getCorpId(), false) != 0) {
            log.debug("该组织已存在用户，请清空后再删除:" + source.getCorpId());
            return false;
        }
        List<RoleGroupModel> roleGroupsByCorpId = getOrganizationFacade().getRoleGroupByCorpId(source.getCorpId());
        if (CollectionUtils.isNotEmpty(roleGroupsByCorpId) && roleGroupsByCorpId.size() > 1) {
            log.debug("该组织已存在除默认角色组外的角色组，请清空后再删除:" + source.getCorpId());
            return false;
        }
        return true;
    }

    private boolean updateRelatedSetting(RelatedCorpSettingModel relatedCorpSettingModel) {
        String orgName = relatedCorpSettingModel.getOrgTypeStr();
        checkOrgName(relatedCorpSettingModel);
        dingTalkValidation(relatedCorpSettingModel);
        RelatedCorpSettingModel source = getSystemManagementFacade().getRelatedCorpSettingModel(relatedCorpSettingModel.getId());
        if (source == null) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "更新组织不存在");
        }
        if (source.getOrgType() != relatedCorpSettingModel.getOrgType()) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "部门类型不可更改");
        }

        checkConfigSetting(relatedCorpSettingModel);

        //更新部门的校验
        DepartmentModel rootDepartment = getOrganizationFacade().getRootDepartmentByCorpId(source.getCorpId());
        if (rootDepartment != null &&
                ((StringUtils.isNotEmpty(rootDepartment.getParentId()) && !rootDepartment.getParentId().equals(relatedCorpSettingModel.getParentId())) ||
                        (StringUtils.isNotEmpty(relatedCorpSettingModel.getParentId()) && !relatedCorpSettingModel.getParentId().equals(rootDepartment.getParentId())))
        ) {
            if (rootDepartment.getId().equals(relatedCorpSettingModel.getParentId())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "不能挂载本企业跟部门作为父部门");
            }
            List<DepartmentModel> departmentsByCorpId = getOrganizationFacade().getDepartmentsByCorpId(source.getCorpId(), false);
            if (CollectionUtils.isNotEmpty(departmentsByCorpId) && departmentsByCorpId.size() > 1) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "该组织已存在子部门，请清空部门后再更改父部门");
            }
        }
        List<RelatedCorpSettingModel> allSettingList = getSystemManagementFacade().getAllRelatedCorpSettingModel();
        for (RelatedCorpSettingModel relatedCorpSetting : allSettingList) {
            if (relatedCorpSetting.getId().equals(relatedCorpSettingModel.getId())) {
                continue;
            }
            if (relatedCorpSetting.getCorpId().equals(relatedCorpSettingModel.getCorpId())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "更新的" + orgName + "corpid已存在");
            }
            if (relatedCorpSetting.getName() != null && relatedCorpSetting.getName().equals(relatedCorpSettingModel.getName())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "更新的" + orgName + "名称已存在");
            }
            if (!Objects.equals(relatedCorpSetting.getId(), relatedCorpSettingModel.getId())
                    && relatedCorpSetting.getRelatedType() == relatedCorpSettingModel.getRelatedType()
                    && relatedCorpSetting.getOrgType() == OrgType.MAIN
                    && StringUtils.isNotEmpty(relatedCorpSettingModel.getAppkey())
                    && Objects.equals(relatedCorpSetting.getAppkey(), relatedCorpSettingModel.getAppkey())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "appKey已被占用");
            }
        }
        relatedCorpSettingModel.setModifiedBy(getUserId());
        registerOrUpdateCallbackUrl(relatedCorpSettingModel);
        return getSystemManagementFacade().updateRelatedCorpSetting(relatedCorpSettingModel);
    }

    private void checkOrgName(RelatedCorpSettingModel settingModel) {
        //处理tapd单号：1006219 关联企业名称与挂载的主企业中子部门名称相同校验
        String parentId = settingModel.getParentId();
        if (StringUtils.isBlank(parentId)) {
            return;
        }
        List<DepartmentModel> departments = getOrganizationFacade().getDepartmentsByParentId(parentId);
        if (CollectionUtils.isEmpty(departments)) {
            return;
        }
        //过滤原数据
        departments = departments.stream().filter(t -> !t.getCorpId().equals(settingModel.getCorpId())).collect(Collectors.toList());
        Set<String> names = departments.stream().map(DepartmentModel::getName)
                .filter(Objects::nonNull).collect(Collectors.toSet());
        if (names.contains(settingModel.getName())) {
            throw new PortalException(ErrCode.SYS_PARAMETER_ERROR.getErrCode(), "当前目录下组织名称已存在");
        }
    }

    private void checkConfigSetting(@RequestBody RelatedCorpSettingModel relatedCorpSettingModel) {
        if (StringUtils.isNotEmpty(relatedCorpSettingModel.getCorpId()) && !StringUtils.isAllBlank(relatedCorpSettingModel.getAppkey(), relatedCorpSettingModel.getAppSecret(), relatedCorpSettingModel.getCorpSecret(), relatedCorpSettingModel.getAgentId(), relatedCorpSettingModel.getScanAppId(), relatedCorpSettingModel.getScanAppSecret())) {
            if (CorpRelatedType.DINGTALK == relatedCorpSettingModel.getRelatedType()) {
                if (!getOrganizationFacade().validateAppKeySecretCorpId(relatedCorpSettingModel.getCorpId(), relatedCorpSettingModel.getAppkey(), relatedCorpSettingModel.getAppSecret())) {
                    throw new PortalException(ErrCode.SYS_PARAMETER_ERROR.getErrCode(), "测试钉钉appKey和appSecret不通过.", "");
                }
            } else if (CorpRelatedType.WECHAT == relatedCorpSettingModel.getRelatedType()) {
                List<String> error = getOrganizationFacade().validateRelatedCorpSetting(relatedCorpSettingModel);
                if (CollectionUtils.isNotEmpty(error)) {
                    throw new PortalException(ErrCode.SYS_PARAMETER_ERROR.getErrCode(), "连接测试不通过：" + String.join(",", error));
                }
            }

        }
    }

    private void createDefaultRole(RelatedCorpSettingModel save) {
        //自维护 （云枢维护）时添加默认角色
        if (OrgSyncType.PUSH == save.getSyncType() && save.getHeaderNum() != null) {
            boolean isExist = false;
            List<RoleGroupModel> roleGroupModels = getOrganizationFacade().getRoleGroupByCorpId(save.getCorpId());
            if (CollectionUtils.isNotEmpty(roleGroupModels)) {
                roleGroupModels = roleGroupModels.stream().filter(Objects::nonNull).filter(item -> StringUtils.isNotEmpty(item.getName()) && "默认".equals(item.getName())).collect(Collectors.toList());
                if (CollectionUtils.isNotEmpty(roleGroupModels)) {
                    isExist = true;
                }
            }
            if (!isExist) {
                RoleGroupModel defaultGroupModel = new RoleGroupModel();
                defaultGroupModel.setRoleType(RoleType.SYS);
                defaultGroupModel.setName("默认");
                defaultGroupModel.setDefaultGroup(false);
                defaultGroupModel.setSourceId("CP_" + save.getHeaderNum() + "000000");
                defaultGroupModel.setCode("SYS_" + save.getHeaderNum() + "000000");
                defaultGroupModel.setCorpId(save.getCorpId());
                defaultGroupModel.setRemarks("系统自动添加的默认角色组");
                RoleGroupModel defaultGroup = getOrganizationFacade().addRoleGroup(defaultGroupModel);
                RoleModel defaultRoleModel = new RoleModel();
                defaultRoleModel.setName("主管");
                defaultRoleModel.setCode("SYS_" + save.getHeaderNum() + "000000");
                defaultRoleModel.setGroupId(defaultGroup.getId());
                defaultRoleModel.setRoleType(RoleType.SYS);
                defaultRoleModel.setSourceId("CP_" + save.getHeaderNum() + "000000");
                defaultRoleModel.setCorpId(save.getCorpId());
                getOrganizationFacade().addRole(defaultRoleModel);
            }
        }
    }


    @ApiOperation(value = "更新关联组织", notes = "更新关联组织")
    @PutMapping("/relatedcorp/update")
    public ResponseResult<Boolean> updateRelatedCorpSetting(@RequestBody RelatedCorpSettingModel relatedCorpSettingModel) {
        if (!isAdmin()) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "非超级管理员不能操作");
        }
        String orgName = relatedCorpSettingModel.getOrgTypeStr();
        if (CollectionUtils.isNotEmpty(relatedCorpSettingModel.getSyncConfigModels())) {
            relatedCorpSettingModel.setMailListConfig(JSON.toJSONString(relatedCorpSettingModel.getSyncConfigModels()));
        }
        boolean update = updateRelatedSetting(relatedCorpSettingModel);
        if (update) {
            return getOkResponseResult(true, "更新" + orgName + "成功");
        }
        return getOkResponseResult(false, "更新" + orgName + "失败");
    }

    private void dingTalkValidation(RelatedCorpSettingModel relatedCorpSettingModel) {
        //钉钉维护时需要非空校验
        if (CorpRelatedType.DINGTALK == relatedCorpSettingModel.getRelatedType() && OrgSyncType.PULL == relatedCorpSettingModel.getSyncType()) {
            if (StringUtils.isBlank(relatedCorpSettingModel.getAgentId())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "AgentId不能为空");
            }
            if (StringUtils.isBlank(relatedCorpSettingModel.getAppkey())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "Appkey不能为空");
            }
            if (StringUtils.isBlank(relatedCorpSettingModel.getAppSecret())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "AppSecret不能为空");
            }
            if (StringUtils.isBlank(relatedCorpSettingModel.getCorpSecret())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "SSOSecret不能为空");
            }
            if (StringUtils.isBlank(relatedCorpSettingModel.getScanAppId())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "扫码登录appId不能为空");
            }
            if (StringUtils.isBlank(relatedCorpSettingModel.getScanAppSecret())) {
                throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "扫码登录AppSecret不能为空");
            }
        }

        if (CorpRelatedType.WECHAT == relatedCorpSettingModel.getRelatedType() && OrgSyncType.PULL == relatedCorpSettingModel.getSyncType()) {
            validateNotEmpty(relatedCorpSettingModel.getAgentId(), "agentId不能为空");
            validateNotEmpty(relatedCorpSettingModel.getCorpId(), "corpId不能为空");
            validateNotEmpty(relatedCorpSettingModel.getCorpSecret(), "Provider_Secret不能为空");
            validateNotEmpty(relatedCorpSettingModel.getAppSecret(), "AppSecret不能为空");
            validateNotEmpty(relatedCorpSettingModel.getRedirectUri(), "回调地址不能为空");
        }

        if (OrgType.MAIN == relatedCorpSettingModel.getOrgType() && OrgSyncType.PULL == relatedCorpSettingModel.getSyncType() && StringUtils.isEmpty(relatedCorpSettingModel.getName())) {
            //主组织钉钉维护的时候可以名称为空
            relatedCorpSettingModel.setName("");
        } else if (StringUtils.isEmpty(relatedCorpSettingModel.getName())) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "组织名称不能为空");
        }
        if (!(CorpRelatedType.OTHER == relatedCorpSettingModel.getRelatedType() && OrgType.MAIN == relatedCorpSettingModel.getOrgType()) && StringUtils.isEmpty(relatedCorpSettingModel.getCorpId())) {
            throw new PortalException(ResultEnum.ILLEGAL_PARAMETER_ERR.getErrCode(), "组织corpId不能为空");
        }

    }


    @ApiOperation(value = "查询关联组织", notes = "查询关联组织")
    @GetMapping("/relatedcorp/all_list")
    public ResponseResult<List<RelatedCorpSettingModel>> listRelatedCorpSetting() {
        List<RelatedCorpSettingModel> allRelatedCorpSettingModel = getSystemManagementFacade().getAllRelatedCorpSettingModel();
        Map<String, Long> map = getOrganizationFacade().countUserGroupByCorpId();
        Map<String, Long> mapDept = getOrganizationFacade().countDeptGroupByCorpId();
        allRelatedCorpSettingModel.forEach(item -> {
            if (Objects.isNull(item)) {
                return;
            }
            //若组织下没有人，则判断组织下有没有部门
            Long count = Objects.isNull(map.get(item.getCorpId())) ? new Long("0") : map.get(item.getCorpId());
            if (count > 0) {
                item.setIsEnableOperat(count > 0);
            } else {
                Long deptCount = Objects.isNull(mapDept.get(item.getCorpId())) ? new Long("0") : mapDept.get(item.getCorpId());
                //根部门以外的下级部门
                item.setIsEnableOperat(deptCount > 1);
            }
            //如果组织下有人员，则传递给前端不可以 编辑，否则继续判断组织下是否有子组织
            if (!item.getIsEnableOperat()) {
                List<DepartmentModel> departments = getOrganizationFacade().getDepartmentsByCorpId(item.getCorpId(), false);
                if (CollectionUtils.isEmpty(departments) || departments.size() < 2) {
                    item.setIsEnableEditRelatedDept(true);
                }

                Optional<DepartmentModel> first = departments.stream().filter(dept ->
                        Objects.equals(dept.getName(), item.getName())).findFirst();
                if (!first.isPresent()) {
                    item.setIsEnableEditRelatedDept(true);
                    return;
                }

                String parentId = first.get().getId();
                List<DepartmentModel> models = getOrganizationFacade().getDepartmentsByParentId(parentId, true);
                if (CollectionUtils.isEmpty(models)) {
                    item.setIsEnableEditRelatedDept(true);
                }
            }
        });


        return getOkResponseResult(allRelatedCorpSettingModel, "查询关联组织成功");
    }

    @ApiOperation(value = "根据关联组织id查询关联组织", notes = "根据关联组织id查询关联组织")
    @ApiImplicitParam(name = "id", value = "关联组织id", required = true, dataType = "String", paramType = "query")
    @GetMapping("/relatedcorp/by_id")
    public ResponseResult<RelatedCorpSettingModel> getRelatedCorpSettingById(@RequestParam String id) {
        RelatedCorpSettingModel relatedCorpSettingModel = getSystemManagementFacade().getRelatedCorpSettingModel(id);
        return getOkResponseResult(relatedCorpSettingModel, "查询关联组织成功");
    }

    @ApiOperation(value = "查询关联组织是否有用户存在", notes = "查询关联组织是否有用户存在")
    @ApiImplicitParam(name = "id", value = "关联组织id", required = true, dataType = "String")
    @GetMapping("/relatedcorp/all_list_user")
    public ResponseResult<List<UserModel>> listRelatedCorpSettingUser(@RequestParam String id) {
        //判断是否超级管理员或者系统管理员
        if (!isAdmin(AuthUtils.getUserId()) && !isSysManager(AuthUtils.getUserId())) {
            throw new PortalException(ResultEnum.NO_PERMISSION.getErrCode(), ResultEnum.NO_PERMISSION.getErrMsg(), AuthUtils.getUserId());
        }
        validateNotEmpty(id, "Id不能为空!");
        RelatedCorpSettingModel relatedCorpSettingModel = getSystemManagementFacade().getRelatedCorpSettingModel(id);
        if (ObjectUtils.isEmpty(relatedCorpSettingModel)) {
            return getErrResponseResult(null, ErrCode.RELATED_SETTING_CORP_NOT_EXIST.getErrCode(), ErrCode.RELATED_SETTING_CORP_NOT_EXIST.getErrMsg());
        }
        String corpId = relatedCorpSettingModel.getCorpId();
        validateNotEmpty(corpId, "corpId不能为空!");
        List<UserModel> userModelList = getOrganizationFacade().getUsersByCorpId(corpId);
        if (CollectionUtils.isNotEmpty(userModelList)) {
            userModelList = userModelList.stream().filter(userModel -> UserStatus.ENABLE.equals(userModel.getStatus())).collect(Collectors.toList());
        }
        return getOkResponseResult(userModelList, "查询关联组织成员成功");
    }

    @ApiOperation(value = "启动或禁用关联组织", notes = "启动或禁用关联组织")
    @PostMapping("/relatedcorp/isEnable")
    @ApiImplicitParam(name = "params", value = "{\"password\":\"超级管理员密码\",\"id\":\"关联组织id\",\"isEnable\":\"是否禁用关联组织\"}", required = true, dataType = "Map")
    public ResponseResult disableRelatedCorpSetting(@RequestBody Map<String, Object> params) {
        //判断是否超级管理员
        if (!isAdmin(AuthUtils.getUserId())) {
            throw new PortalException(ResultEnum.NO_PERMISSION.getErrCode(), ResultEnum.NO_PERMISSION.getErrMsg(), AuthUtils.getUserId());
        }
        UserModel user = getOrganizationFacade().getUser(AuthUtils.getUserId());
        String password = (String) params.get("password");
        String index = (String) params.get("index");
        String id = (String) params.get("id");
        Boolean isEnable = (Boolean) params.get("isEnable");

        if (StringUtils.isEmpty(id)) {
            log.error("关联组织id为空");
            return getErrResponseResult(null, ErrCode.RELATED_SETTING_ID_EMPTY.getErrCode(), ErrCode.RELATED_SETTING_ID_EMPTY.getErrMsg());
        }

        if (StringUtils.isEmpty(password)) {
            log.error("输入的密码为空");
            return getErrResponseResult(null, ErrCode.SYSTEM_SETTING_VALUE_EMPTY.getErrCode(), ErrCode.SYSTEM_SETTING_VALUE_EMPTY.getErrMsg());
        }

        if (StringUtils.isEmpty(index)) {
            return getErrResponseResult(10001L, "index缺失，请重新操作!");
        }

        Boolean result = false;
        RelatedCorpSettingModel relatedCorpSettingModel = null;
        if (StringUtils.isNotEmpty(index)) {
            String privateKey = (String) redisTemplate.opsForValue().get(index);
            if (StringUtils.isEmpty(privateKey)) {
                log.debug("rsa key不存在");
                return getErrResponseResult(10001L, "index缺失，请重新操作!");
            }
            redisTemplate.delete(index);
            RSA r = new RSA(privateKey, null);
            try {
                Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
                cipher.init(Cipher.DECRYPT_MODE, r.getPrivateKey());
                byte[] cipherText = cipher.doFinal(Base64.getDecoder().decode(password.getBytes()));
                password = new String(cipherText, "UTF-8");
                PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
                boolean matches = encoder.matches(password, user.getPassword());
                if (matches) {
                    //禁用关联组织
                    relatedCorpSettingModel = getSystemManagementFacade().getRelatedCorpSettingModel(id);
                    relatedCorpSettingModel.setEnabled(isEnable);
                    result = getSystemManagementFacade().updateRelatedCorpSetting(relatedCorpSettingModel);
                    //禁用关联组织下的所有部门
                    if (result) {
                        List<DepartmentModel> departments = getOrganizationFacade().getDepartmentsByCorpId(relatedCorpSettingModel.getCorpId(), false);
                        departments.forEach(departmentModel -> {
                            departmentModel.setEnabled(isEnable);
                            DepartmentModel department = getOrganizationFacade().updateDepartment(departmentModel);
                            //禁用部门下的用户
                            List<UserModel> userModelList = getOrganizationFacade().getUsersByDeptId(department.getId());
                            userModelList.forEach(userModel -> {
                                userModel.setEnabled(isEnable);
                                getOrganizationFacade().updateUser(userModel);
                            });
                        });
                    }
                } else {
                    return getErrResponseResult(ErrCode.SYS_PASSWORD_ERROR.getErrCode(), ErrCode.SYS_PASSWORD_ERROR.getErrMsg());
                }
            } catch (Exception e) {
                log.warn(e.getMessage(), e);
                return getErrResponseResult(100000L, "操作失败");
            }
        }
        if (result) {

            if (isEnable) {
                return getOkResponseResult(ErrCode.OK.getErrCode(), relatedCorpSettingModel.getName() + "启用成功");
            } else {
                return getOkResponseResult(ErrCode.OK.getErrCode(), relatedCorpSettingModel.getName() + "禁用成功");
            }
        } else {
            return getErrResponseResult(100000L, "操作失败");
        }
    }

    @ApiOperation(value = "是否显示立即同步", notes = "是否显示立即同步")
    @GetMapping("/relatedcorp/need_sync")
    public ResponseResult<Map<String, Object>> needDingTalkSync() {
        List<RelatedCorpSettingModel> allRelatedCorpSettingModel = getSystemManagementFacade().getAllRelatedCorpSettingModel();
        Map<String, Object> result = new HashMap<>();
        if (CollectionUtils.isEmpty(allRelatedCorpSettingModel)) {
            result.put("needSync", false);
//            return getOkResponseResult(false, "不显示立即同步");
        }
        for (RelatedCorpSettingModel relatedCorpSettingModel : allRelatedCorpSettingModel) {
            if (OrgSyncType.PULL == relatedCorpSettingModel.getSyncType()) {
                result.put("needSync", true);
//                return getOkResponseResult(true, "显示立即同步");
            }
        }
        if (isAdmin()) {
            Optional<RelatedCorpSettingModel> any = allRelatedCorpSettingModel.stream().filter(setting -> setting.getSyncType() == OrgSyncType.PUSH).findAny();
            result.put("hasCloudPivotPerm", any.isPresent());
        } else {
            AdminModel appAdminByUser = getAppAdminByUserId(getUserId());
            if (appAdminByUser != null) {
                switch (appAdminByUser.getAdminType()) {
                    case ADMIN:
                    case SYS_MNG:
                        Optional<RelatedCorpSettingModel> any = allRelatedCorpSettingModel.stream().filter(setting -> setting.getSyncType() == OrgSyncType.PUSH).findAny();
                        result.put("hasCloudPivotPerm", any.isPresent());
                        break;
                    case APP_MNG:
                        List<DepartmentScopeModel> departments = appAdminByUser.getDepartments();
                        List<String> collect = departments.stream().map(DepartmentScopeModel::getUnitId).collect(Collectors.toList());
                        Map<String, List<DepartmentModel>> corps = getOrganizationFacade().getDepartmentsChildList(collect, true).stream().collect(Collectors.groupingBy(DepartmentModel::getCorpId));
                        Optional<RelatedCorpSettingModel> any1 = allRelatedCorpSettingModel.stream().filter(setting -> corps.keySet().contains(setting.getCorpId()) && setting.getSyncType() == OrgSyncType.PUSH).findAny();
                        result.put("hasCloudPivotPerm", any1.isPresent());
                        result.put("needSync", false);
                        break;
                    default:
                        result.put("hasCloudPivotPerm", false);
                        break;
                }
            }
        }

        return getOkResponseResult(result, "");
    }

}
