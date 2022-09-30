package com.authine.cloudpivot.web.api.controller.orgnization;

import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.authine.cloudpivot.engine.api.model.organization.*;
import com.authine.cloudpivot.engine.api.model.permission.DepartmentScopeModel;
import com.authine.cloudpivot.engine.api.model.runtime.SelectionValue;
import com.authine.cloudpivot.engine.api.model.system.AdminModel;
import com.authine.cloudpivot.engine.api.model.system.RelatedCorpSettingModel;
import com.authine.cloudpivot.engine.api.model.system.SystemSettingModel;
import com.authine.cloudpivot.engine.enums.ErrCode;
import com.authine.cloudpivot.engine.enums.type.AdminType;
import com.authine.cloudpivot.engine.enums.type.OrgSyncType;
import com.authine.cloudpivot.engine.enums.type.RoleType;
import com.authine.cloudpivot.engine.enums.type.UnitType;
import com.authine.cloudpivot.web.api.cache.RedisCacheService;
import com.authine.cloudpivot.web.api.controller.base.PermissionController;
import com.authine.cloudpivot.web.api.exception.PortalException;
import com.authine.cloudpivot.web.api.exception.ResultEnum;
import com.authine.cloudpivot.web.api.handler.CustomizedOrigin;
import com.authine.cloudpivot.web.api.helper.RoleGroupHelper;
import com.authine.cloudpivot.web.api.helper.RoleHelper;
import com.authine.cloudpivot.web.api.view.ResponseResult;
import com.authine.cloudpivot.web.api.view.organization.RoleGroupVO;
import com.authine.cloudpivot.web.api.view.organization.RoleUserOuScopeVO;
import com.authine.cloudpivot.web.api.view.organization.RoleUserVO;
import com.authine.cloudpivot.web.api.view.organization.RoleVO;
import com.google.common.base.Strings;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

import static com.authine.cloudpivot.web.api.controller.system.SystemAdminController.IS_CLOUD_PIVOT_KEY;

/**
 * @ClassName: RoleController
 * @Description: 角色相关类
 * @Author: dengchao
 * @Date: 2018年10月24日
 * @Version 1.0
 */
@Api(tags = "组织机构::角色")
@Validated
@RestController
@RequestMapping("/api/organization/role")
@Slf4j
@CustomizedOrigin(level = 0)
public class RoleController extends PermissionController {

    @Autowired
    private RedisCacheService redisCacheService;
    @Autowired
    private SelectionHelperExt selectionHelperExt;

    private static String DEFAULT_ROLE_GROUP = "默认分组";

    private static String DEFAULT_ROLE_DEPTMANAGER = "部门主管";

    /**
     * @return ResponseResult<?>
     * @Description:
     * @Param []
     * @author dengchao
     * @date 2018/10/29 14:06
     */
    @GetMapping("/list")
    @ApiOperation(value = "查询角色组列表", notes = "获取角色组列表，默认展开第一级")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "expandAll", value = "分批加载 null false:只展开第一级，true 展开所有", allowableValues = "{null,true,false}", defaultValue = "null", dataType = "Boolean", paramType = "query"),
            @ApiImplicitParam(name = "filterDefaultRoleGroup", value = "过滤类型", dataType = "Boolean", paramType = "query")
    })
    public ResponseResult<List<RoleGroupModel>> list(@RequestParam(required = false) Boolean expandAll, @RequestParam(required = false) String roleName, @RequestParam(required = false) String roleType, @RequestParam(required = false) Boolean filterDefaultRoleGroup) {
        RoleHelper roleHelper = new RoleHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        //确定开关是否打开

        boolean isFilter = false;
        List<String> corpIds = Lists.newArrayList();
        AdminModel appAdminByUser = getAppAdminByUserId(getUserId());
        if (appAdminByUser != null && appAdminByUser.getAdminType() == AdminType.APP_MNG) {
            Set<String> managePermChildDepartment = getManagePermChildDepartmentId(getUserId());
            corpIds = getOrganizationFacade().getCorpIdsByDeptIds(Lists.newArrayList(managePermChildDepartment));
            isFilter = true;
        }

        List<RoleGroupModel> roleGroupList = getOrganizationFacade().getRoleGroups();
        RoleType roleTypeN = null;
        if (StringUtils.isNotEmpty(roleType)) {
            try {
                roleTypeN = RoleType.valueOf(roleType);
            } catch (Exception e) {
            }
        }
        if (null != roleTypeN && CollectionUtils.isNotEmpty(roleGroupList)) {
            final RoleType temp = roleTypeN;
            roleGroupList = roleGroupList.stream().filter(Objects::nonNull).filter(item -> temp == item.getRoleType()).collect(Collectors.toList());
            if (RoleType.SYS == temp) {
                roleGroupList = roleGroupList.stream().filter(item -> !DEFAULT_ROLE_GROUP.equals(item.getName().trim())).collect(Collectors.toList());
            }
        }

        //应用管理员角色
        if (isFilter && CollectionUtils.isNotEmpty(roleGroupList)) {
            final List<String> corpList = CollectionUtils.isEmpty(corpIds) ? Lists.newLinkedList() : corpIds;
            roleGroupList = roleGroupList.stream().filter(item -> corpList.contains(item.getCorpId()) || RoleType.SYS == item.getRoleType()).collect(Collectors.toList());
            roleGroupList = roleGroupList.stream().filter(item -> !DEFAULT_ROLE_GROUP.equals(item.getName().trim())).collect(Collectors.toList());
        }

        //展开所有
        if (Objects.equals(expandAll, Boolean.TRUE)) {
            log.debug("expandAll:{}", expandAll);
            List<RoleModel> roles = getOrganizationFacade().getRoles();
            Map<String, List<RoleModel>> roleMap = roles.stream().collect(Collectors.groupingBy(RoleModel::getGroupId));
            roleGroupList.forEach(roleGroupModel -> roleGroupModel.setChildren(roleMap.get(roleGroupModel.getId())));
            if (Boolean.TRUE.equals(filterDefaultRoleGroup)) {
                roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !DEFAULT_ROLE_GROUP.equals(roleGroupModel.getName())).collect(Collectors.toList());
            }
            if (isCloudpivot()) {
                roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !roleGroupModel.isDefaultGroup()).collect(Collectors.toList());
            }
            return getOkResponseResult(roleGroupList, "获取展开的角色列表成功");
        }

        //只展开第一级
        if (roleGroupList == null) {
            return getErrResponseResult(null, ResultEnum.GET_DEPARTMENT_ERR.getErrCode(), ResultEnum.GET_DEPARTMENT_ERR.getErrMsg());
        }
        if (isCloudpivot()) {
            roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !roleGroupModel.isDefaultGroup()).collect(Collectors.toList());
        }

        if (Boolean.TRUE.equals(filterDefaultRoleGroup)) {
            roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !DEFAULT_ROLE_GROUP.equals(roleGroupModel.getName())).collect(Collectors.toList());
        }

        if (roleGroupList.size() > 0) {
            //默认展开第一级
            RoleGroupModel roleGroup = roleGroupList.get(0);
            String groupId = roleGroup.getId();
            List<RoleModel> childrenList = getOrganizationFacade().getRolesByGroupId(groupId);
            roleGroup.setChildren(childrenList);
        }

        return getOkResponseResult(roleGroupList, "角色组列表成功");
    }

    @GetMapping("/listNesting")
    @ApiOperation(value = "查询嵌套角色组列表", notes = "获取嵌套角色组列表，默认展开第一级")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "expandAll", value = "分批加载 null false:只展开第一级，true 展开所有", allowableValues = "{null,true,false}", defaultValue = "null", dataType = "Boolean", paramType = "query"),
            @ApiImplicitParam(name = "filterDefaultRoleGroup", value = "过滤类型", dataType = "Boolean", paramType = "query"),
            @ApiImplicitParam(name = "filterEmptyRelatedSetting", value = "过滤空的关联组织类型", dataType = "Boolean", paramType = "query"),
            @ApiImplicitParam(name = "onlyGroup", value = "只需要角色组", dataType = "Boolean", defaultValue = "false", paramType = "query"),
            @ApiImplicitParam(name = "onlySYS", value = "只需要自维护组织", dataType = "Boolean", defaultValue = "false", paramType = "query"),
            @ApiImplicitParam(name = "reqSource", value = "请求来源", dataType = "String", defaultValue = "false", paramType = "query")
    })
    public ResponseResult<List<RoleGroupModel>> listNesting(@RequestParam(required = false) Boolean expandAll,
                                                            @RequestParam(required = false) String roleName,
                                                            @RequestParam(required = false) String roleType,
                                                            @RequestParam(required = false) Boolean filterDefaultRoleGroup,
                                                            @RequestParam(defaultValue = "false") Boolean filterEmptyRelatedSetting,
                                                            @RequestParam(defaultValue = "false") Boolean onlyGroup,
                                                            @RequestParam(defaultValue = "false") Boolean onlySYS,
                                                            @RequestParam(required = false) String reqSource) {
        //确定开关是否打开
        boolean isFilter = false;
        List<String> corpIds = Lists.newArrayList();
        AdminModel appAdminByUser = getAppAdminByUserId(getUserId());
        if (appAdminByUser != null && appAdminByUser.getAdminType() == AdminType.APP_MNG) {
            Set<String> managePermChildDepartment = getManagePermChildDepartmentId(getUserId());
            corpIds = getOrganizationFacade().getCorpIdsByDeptIds(Lists.newArrayList(managePermChildDepartment));
            isFilter = true;
        }

        //从数据库中获取关联组织
        List<RelatedCorpSettingModel> relatedCorpSettingModelByCorpIdIn = getSystemManagementFacade().getAllRelatedCorpSettingModel();

        Map<String, String> relatedNameMap = new HashMap<>();
        for (RelatedCorpSettingModel relatedCorpSettingModel : relatedCorpSettingModelByCorpIdIn) {
            relatedNameMap.put(relatedCorpSettingModel.getCorpId(), relatedCorpSettingModel.getName());
        }

        List<RoleGroupModel> allRoleGroupList = getOrganizationFacade().getRoleGroups();

        for (RoleGroupModel roleGroupModel : allRoleGroupList) {
            String corpName = relatedNameMap.get(roleGroupModel.getCorpId());
            if (Objects.isNull(corpName)) {
                corpName = "无组织来源角色组";
            }
            roleGroupModel.setCorpName(corpName);
        }

        //先获取顶级的角色，由于是顶级其parentId为空
        List<RoleGroupModel> roleGroupList = allRoleGroupList.stream().filter(roleGroupModel -> StringUtils.isBlank(roleGroupModel.getParentId())).collect(Collectors.toList());


        RoleType roleTypeN = null;
        if (StringUtils.isNotEmpty(roleType)) {
            try {
                roleTypeN = RoleType.valueOf(roleType);
            } catch (Exception e) {
            }
        }
        if (null != roleTypeN && CollectionUtils.isNotEmpty(roleGroupList)) {
            final RoleType temp = roleTypeN;
            roleGroupList = roleGroupList.stream().filter(Objects::nonNull).filter(item -> temp == item.getRoleType()).collect(Collectors.toList());
            if (RoleType.SYS == temp) {
                roleGroupList = roleGroupList.stream().filter(item -> !DEFAULT_ROLE_GROUP.equals(item.getName().trim())).collect(Collectors.toList());
            }
        }

        //应用管理员角色
        if (isFilter && CollectionUtils.isNotEmpty(roleGroupList)) {
            final List<String> corpList = CollectionUtils.isEmpty(corpIds) ? Lists.newLinkedList() : corpIds;
            roleGroupList = roleGroupList.stream().filter(item -> corpList.contains(item.getCorpId()) || RoleType.SYS == item.getRoleType()).collect(Collectors.toList());
            roleGroupList = roleGroupList.stream().filter(item -> !DEFAULT_ROLE_GROUP.equals(item.getName().trim())).collect(Collectors.toList());
        }

        //展开所有
        if (Objects.equals(expandAll, Boolean.TRUE)) {
            log.debug("expandAll:{}", expandAll);
            List<RoleModel> roles = getOrganizationFacade().getRoles();
            Map<String, List<RoleModel>> roleMap = roles.stream().collect(Collectors.groupingBy(RoleModel::getGroupId));

            roleGroupList.forEach(roleGroupModel -> {
                List children = new ArrayList();
                // 如果当前角色组下有角色 则赋予角色成员 否则赋予为空
                //角色
                if (!onlyGroup) {
                    children.addAll(roleMap.containsKey(roleGroupModel.getId()) ? roleMap.get(roleGroupModel.getId()) : Lists.newArrayList());
                }
                //角色组
                List<RoleGroupModel> childRoleGroupList = allRoleGroupList.stream().filter(groupChild -> StringUtils.isNotBlank(groupChild.getParentId()) && roleGroupModel.getId().equals(groupChild.getParentId())).collect(Collectors.toList());
                childRoleGroupList = expandAllRoleGroup(childRoleGroupList, onlyGroup);
                children.addAll(childRoleGroupList);
                roleGroupModel.setChildren(children);
            });

            if (Boolean.TRUE.equals(filterDefaultRoleGroup)) {
                roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !DEFAULT_ROLE_GROUP.equals(roleGroupModel.getName())).collect(Collectors.toList());
            }
            if (isCloudpivot()) {
                roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !roleGroupModel.isDefaultGroup()).collect(Collectors.toList());
            }

            List<RoleGroupModel> list = appendCatalogForRoleGroupModel(roleGroupList, filterEmptyRelatedSetting, onlySYS, true);
            List<RoleGroupModel> roleGroupModels = selectionHelperExt.filterRoleGroupByCorpId(list, corpIds);
            List<RoleGroupModel> models = selectionHelperExt.filterModifyUserRole(reqSource, corpIds, roleGroupModels);
            return getOkResponseResult(models, "获取展开的角色列表成功");
        }

        //只展开第一级
        if (roleGroupList == null) {
            return getErrResponseResult(null, ResultEnum.GET_DEPARTMENT_ERR.getErrCode(), ResultEnum.GET_DEPARTMENT_ERR.getErrMsg());
        }
        if (isCloudpivot()) {
            roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !roleGroupModel.isDefaultGroup()).collect(Collectors.toList());
        }

        if (Boolean.TRUE.equals(filterDefaultRoleGroup)) {
            roleGroupList = roleGroupList.stream().filter(roleGroupModel -> !DEFAULT_ROLE_GROUP.equals(roleGroupModel.getName())).collect(Collectors.toList());
        }

        if (roleGroupList.size() > 0) {
            //默认展开第一级
            RoleGroupModel roleGroup = roleGroupList.get(0);
            String groupId = roleGroup.getId();
            List children = new ArrayList();
            List<RoleModel> roleList = getOrganizationFacade().getRolesByGroupId(groupId);
            //角色
            if (!onlyGroup) {
                children.addAll(roleList);
            }
            //角色组
            children.addAll(allRoleGroupList.stream().filter(groupChild -> StringUtils.isNotBlank(groupChild.getParentId()) && roleGroup.getId().equals(groupChild.getParentId())).collect(Collectors.toList()));
            roleGroup.setChildren(children);
        }

        List<RoleGroupModel> list = appendCatalogForRoleGroupModel(roleGroupList, filterEmptyRelatedSetting, onlySYS, true);
        List<RoleGroupModel> roleGroupModels = selectionHelperExt.filterRoleGroupByCorpId(list, corpIds);
        List<RoleGroupModel> models = selectionHelperExt.filterModifyUserRole(reqSource, corpIds, roleGroupModels);
        return getOkResponseResult(models, "角色组列表成功");
    }

    /**
     * create by chensm
     * 目的： 迭代10任务 【组织角色-组织角色组按组织划分】
     * https://www.tapd.cn/31542502/prong/tasks/view/1131542502001006335
     * 核心逻辑 ： 入参 roleGroupList 为没有分组的角色，需要为其设置目录
     * 1. 对roleGroupList 根据corpId分组
     * 2. 从数据库取出所有关联组织 根据corpId分组去重
     * 3 .以关联组织的name字段设置目录，如果不存在关联组织，则放在 noResource 下面，表示无组织
     * @param roleGroupList 角色组数据 包含角色
     * @param onlySYS       只需要自维护组织
     * @return
     */
    public List<RoleGroupModel> appendCatalogForRoleGroupModel(List<RoleGroupModel> roleGroupList, boolean filterEmptyRelatedSetting, boolean onlySYS, boolean isShowSysGroup) {
        if (CollectionUtils.isEmpty(roleGroupList)) {
            log.info("入参roleGroupList是空的");
            return Collections.emptyList();
        }


        LinkedList<RoleGroupModel> list = new LinkedList<>();
        //根据corpId分组
        log.info("入参roleGroupList为{}", roleGroupList);
        List<String> corpIdList = roleGroupList.stream().map(roleGroupModel -> roleGroupModel.getCorpId()).distinct().collect(Collectors.toList());

        //从数据库中获取关联组织
        List<RelatedCorpSettingModel> relatedCorpSettingModelByCorpIdIn = getSystemManagementFacade().getAllRelatedCorpSettingModel();
        log.info("从数据库中获取关联组织个数为{}", relatedCorpSettingModelByCorpIdIn.size());
        //分组
        Map<String, List<RelatedCorpSettingModel>> relatedCorpSettingModelMap = new HashMap<>();

        Map<String, List<RelatedCorpSettingModel>> allRelatedCorpSettingModelMap = new HashMap<>();

        if (onlySYS) {
            // 只查找自维护 ， OrgSyncType.PUSH 表示自维护
            relatedCorpSettingModelMap = relatedCorpSettingModelByCorpIdIn.stream().filter(relatedCorpSettingModel -> Objects.equals(OrgSyncType.PUSH, relatedCorpSettingModel.getSyncType()))
                    .collect(Collectors.groupingBy(RelatedCorpSettingModel::getCorpId));

            allRelatedCorpSettingModelMap = relatedCorpSettingModelByCorpIdIn.stream().collect(Collectors.groupingBy(RelatedCorpSettingModel::getCorpId));


        } else {
            relatedCorpSettingModelMap = relatedCorpSettingModelByCorpIdIn.stream().collect(Collectors.groupingBy(RelatedCorpSettingModel::getCorpId));
        }

        //标记排在第一个的组织id
        String firstCorpId = roleGroupList.get(0).getCorpId();
        //分组后不改变排序
        Map<String, List<RoleGroupModel>> roleGroupListGroupByCorpId = roleGroupList.stream()
                .sorted(Comparator.comparing(RoleGroupModel::getCreatedTime))
                .collect(Collectors.groupingBy(RoleGroupModel::getCorpId, LinkedHashMap::new, Collectors.toList()));


        //由于需要把没有来源组织的数据放到最后，所以就声明 noResourceList 暂时存放没有来源组织的数据，最后list添加该集合
        List<RoleGroupModel> noResourceList = new ArrayList<>();

        //赋值
        Map<String, List<RelatedCorpSettingModel>> finalRelatedCorpSettingModelMap = relatedCorpSettingModelMap;
        Map<String, List<RelatedCorpSettingModel>> finalAllRelatedCorpSettingModelMap = allRelatedCorpSettingModelMap;
        roleGroupListGroupByCorpId.forEach((k, v) -> {
            // k -> corpId,   v -> List<RoleGroupModel>

            if (finalRelatedCorpSettingModelMap.containsKey(k)) {
                RoleGroupModel model = new RoleGroupModel();
                model.setName(finalRelatedCorpSettingModelMap.get(k).get(0).getName());
                model.setId(finalRelatedCorpSettingModelMap.get(k).get(0).getId());
                model.setChildren(v);
                model.setRemarks(k);
                // roleGroupListGroupByCorpId 是分组来的 v肯定有值
                model.setRoleType(v.get(0).getRoleType());
                if (k.equals(firstCorpId)) {
                    list.addFirst(model);
                } else {
                    list.add(model);
                }
                finalRelatedCorpSettingModelMap.remove(k);
            } else if ((onlySYS && !finalAllRelatedCorpSettingModelMap.containsKey(k)) || !onlySYS) {
                // OrgSyncType.PUSH, relatedCorpSettingModel.getSyncType()
                log.info("{}没有来源组织", k);
                noResourceList.addAll(v);
            }
        });

        // 如果filterEmptyRelatedSetting 为false，表明需要所有的关联组织（即使没下一级）
        if (!filterEmptyRelatedSetting && finalRelatedCorpSettingModelMap.size() > 0) {
            finalRelatedCorpSettingModelMap.forEach((k, v) -> {
                RoleGroupModel model = new RoleGroupModel();
                model.setName(finalRelatedCorpSettingModelMap.get(k).get(0).getName());
                model.setId(finalRelatedCorpSettingModelMap.get(k).get(0).getId());
                model.setRemarks(k);
                list.add(model);
            });
        }
        if (isShowSysGroup || CollectionUtils.isNotEmpty(noResourceList)) {
            RoleGroupModel model = new RoleGroupModel();
            model.setName("系统自建分组");
            model.setId("other");
            model.setChildren(noResourceList);
            list.add(model);
        }
        return list;
    }

    //展开所有分组，需要递归实现
    public List<RoleGroupModel> expandAllRoleGroup(List<RoleGroupModel> roleGroupModels, boolean onlyGroup) {
        roleGroupModels.stream().forEach(roleGroupModel -> {
            List<RoleGroupModel> childGroup = expandAllRoleGroupOperate(roleGroupModel, onlyGroup);
            roleGroupModel.setChildren(childGroup);
        });
        return roleGroupModels;
    }

    public List<RoleGroupModel> expandAllRoleGroupOperate(RoleGroupModel roleGroupModel, boolean onlyGroup) {
        List<RoleGroupModel> childRoleGroup = getOrganizationFacade().getByParentId(roleGroupModel.getId());
        childRoleGroup.stream().forEach(roleGroup -> {
            //获取角色组
            List<RoleGroupModel> tempChildRoleGroup = expandAllRoleGroupOperate(roleGroup, onlyGroup);
            roleGroup.setChildren(tempChildRoleGroup);
            //获取角色
            if (!onlyGroup) {
                List<RoleModel> rolesByGroupId = getOrganizationFacade().getRolesByGroupId(roleGroup.getId());
                roleGroup.getChildren().addAll(rolesByGroupId);
            }
        });
        return childRoleGroup;
    }

    /**
     * 是否云枢自主维护
     * @return
     */
    private boolean isCloudpivot() {
        SystemSettingModel settingModel = getSystemManagementFacade().getSystemSettingBySettingCode(IS_CLOUD_PIVOT_KEY);
        return Optional.ofNullable(settingModel).map(model -> 1 == Integer.parseInt(model.getSettingValue())).orElse(false);
    }

    @GetMapping("/get")
    @ApiOperation(value = "根据角色id查询角色", notes = "根据角色id查询角色")
    @ApiImplicitParam(name = "roleId", value = "roleId", required = true, dataType = "String", paramType = "query")
    public ResponseResult<RoleModel> get(@NotBlank(message = "roleId 不能为空")
                                         @RequestParam String roleId) {
        RoleModel role = getOrganizationFacade().getRole(roleId);
        if (ObjectUtil.isNotNull(role)) {
            RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroup(role.getGroupId());
            role.setGroupName(roleGroup.getName());
        }
        return getOkResponseResult(role, "查询成功");
    }

    @GetMapping("/get_rolegroup")
    @ApiOperation(value = "根据角色id查询角色组", notes = "根据角色id查询角色组")
    @ApiImplicitParam(name = "roleId", value = "roleId", required = true, dataType = "String", paramType = "query")
    public ResponseResult<RoleGroupModel> getRoleGroup(@NotBlank(message = "roleId 不能为空")
                                                       @RequestParam String roleId) {
        RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroupByRoleId(roleId);
        return getOkResponseResult(roleGroup, "查询成功");
    }

    @GetMapping("/get_rolegroup_by_code")
    @ApiOperation(value = "根据角色编码查询角色组装信息", notes = "根据角色编码查询角色组")
    @ApiImplicitParam(name = "roleCode", value = "roleCode", required = true, dataType = "String", paramType = "query")
    public ResponseResult<RoleVO> getRoleGroupByCode(@NotBlank(message = "roleCode 不能为空")
                                                     @RequestParam String roleCode) {
        RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroupByRoleCode(roleCode);
        RoleModel roleModel = getOrganizationFacade().getRoleByCode(roleCode);
        RoleVO roleVO = new RoleVO();
        roleVO.setCode(roleCode);
        roleVO.setRoleId(roleModel.getId());
        roleVO.setRoleName(roleModel.getName());
        roleVO.setRoleGroupId(roleGroup.getId());
        roleVO.setRoleGroupName(roleGroup.getName());
        return getOkResponseResult(roleVO, "查询成功");
    }

    @GetMapping("/get_role_by_name")
    @ApiOperation(value = "根据角色名称模糊查询角色", notes = "根据角色名称模糊查询角色组")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleName", value = "roleName", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "filterDefaultRoleGroup", value = "过滤类型", dataType = "Boolean", paramType = "query"),
            @ApiImplicitParam(name = "filterDingRoleGroup", value = "过滤类型", dataType = "Boolean", paramType = "query")
    })
    public ResponseResult<List<RoleVO>> searchRolesByName(@NotBlank(message = "roleName 不能为空")
                                                          @RequestParam String roleName, @RequestParam(required = false) String roleType,
                                                          @RequestParam(required = false) Boolean filterDefaultRoleGroup,
                                                          @RequestParam(required = false) Boolean filterDingRoleGroup
    ) {
        RoleType roleTypeN = null;
        List<RoleModel> roleModels;
        if (StringUtils.isNotEmpty(roleType)) {
            try {
                roleTypeN = RoleType.valueOf(roleType);
            } catch (Exception e) {

            }
        }
        if (roleTypeN != null) {
            roleModels = getOrganizationFacade().searchRoleByRoleName(roleName);
            if (CollectionUtils.isNotEmpty(roleModels)) {
                final RoleType temp = roleTypeN;
                roleModels = roleModels.stream().filter(roleModel -> temp == roleModel.getRoleType()).collect(Collectors.toList());
            }
        } else {
            roleModels = getOrganizationFacade().searchRoleByRoleName(roleName);
        }

        if (Boolean.TRUE.equals(filterDefaultRoleGroup) && CollectionUtils.isNotEmpty(roleModels)) {
            roleModels = roleModels.stream().filter(roleModel -> !DEFAULT_ROLE_DEPTMANAGER.equals(roleModel.getName())).collect(Collectors.toList());
        }

        if (Boolean.TRUE.equals(filterDingRoleGroup) && CollectionUtils.isNotEmpty(roleModels)) {
            roleModels = roleModels.stream().filter(item -> RoleType.DINGTALK != item.getRoleType()).collect(Collectors.toList());
        }

        List<RoleVO> roleVOS = Lists.newArrayList();
        if (CollectionUtils.isNotEmpty(roleModels)) {
            for (RoleModel roleModel : roleModels) {
                RoleVO role = new RoleVO();
                role.setRoleGroupId(roleModel.getGroupId());
                RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroupByRoleId(roleModel.getId());
                role.setRoleGroupName(roleGroup.getName());
                role.setRoleId(roleModel.getId());
                role.setRoleName(roleModel.getName());
                role.setCode(roleModel.getCode());
                role.setRoleType(roleModel.getRoleType());
                roleVOS.add(role);
            }
            return getOkResponseResult(roleVOS, "查询成功");
        } else {
            return getOkResponseResult(null, "没有符合搜索要求的内容");
        }
    }

    /**
     * 根据角色名称模糊搜索角色
     * @param name
     * @return
     */
    @GetMapping("/search")
    @ApiOperation(value = "查询角色列表", notes = "查询角色列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "角色名称", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "filterDefaultRoleGroup", value = "过滤类型", dataType = "Boolean", paramType = "query")
    })
    public ResponseResult searchRoles(@NotBlank(message = "搜索内容不能为空") @RequestParam String name, @RequestParam(required = false) Boolean filterDefaultRoleGroup) {
        validateNotEmpty(name);
        List<RoleGroupModel> roleGroupModels = getOrganizationFacade().searchRoleGroupByRoleName(name);

        if (Boolean.TRUE.equals(filterDefaultRoleGroup) && CollectionUtils.isNotEmpty(roleGroupModels)) {
            roleGroupModels = roleGroupModels.stream().filter(roleGroupModel -> !DEFAULT_ROLE_GROUP.equals(roleGroupModel.getName())).collect(Collectors.toList());
        }

        List<RoleModel> roleModels = getOrganizationFacade().searchRoleByRoleName(name);
        if (Boolean.TRUE.equals(filterDefaultRoleGroup) && CollectionUtils.isNotEmpty(roleModels)) {
            roleModels = roleModels.stream().filter(roleModel -> !DEFAULT_ROLE_DEPTMANAGER.equals(roleModel.getName())).collect(Collectors.toList());
        }

        if (isCloudpivot()) {
            //自主维护不显示默认角色
            if (CollectionUtils.isNotEmpty(roleGroupModels)) {
                roleGroupModels = roleGroupModels.stream().filter(roleGroupModel -> !roleGroupModel.isDefaultGroup()).collect(Collectors.toList());
            }
            if (CollectionUtils.isNotEmpty(roleModels)) {
                Iterator<RoleModel> iterator = roleModels.iterator();
                while (iterator.hasNext()) {
                    RoleModel next = iterator.next();
                    if (isDefaultRoleGroup(next.getId())) {
                        iterator.remove();
                    }
                }
            }
        }
        List<RoleGroupModel> roleGroupModelList = Lists.newArrayList();
        Set<String> roleGroupIds = Sets.newHashSet();
        for (RoleModel roleModel : roleModels) {
            RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroupByRoleId(roleModel.getId());
            String id = roleGroupModel.getId();
            roleGroupIds.add(id);
        }
        Set<String> roleGroupModelIds = roleGroupModels.stream().filter(Objects::nonNull).map(RoleGroupModel::getId).collect(Collectors.toSet());
        if (CollectionUtils.isEmpty(roleGroupIds) && CollectionUtils.isEmpty(roleGroupModelIds)) {
            return getOkResponseResult("没有搜索到符合要求的内容");
        }
        roleGroupModelIds.removeAll(roleGroupIds);
        if (CollectionUtils.isNotEmpty(roleGroupModelIds)) {
            for (String roleGroupId : roleGroupModelIds) {
                RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroup(roleGroupId);
                roleGroupModel.setChildren(null);
                roleGroupModelList.add(roleGroupModel);
            }
        }
        Iterator<String> iterator = roleGroupIds.iterator();
        while (iterator.hasNext()) {
            String roleGroupId = iterator.next();
            RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroup(roleGroupId);
            List<RoleModel> childrens = Lists.newArrayList();
            for (RoleModel roleModel : roleModels) {
                String groupId = roleModel.getGroupId();
                String id = roleGroupModel.getId();
                if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(groupId) && Objects.equals(id, groupId)) {
                    childrens.add(roleModel);
                }
            }
            roleGroupModel.setChildren(childrens);
            roleGroupModelList.add(roleGroupModel);
        }

        return getOkResponseResult(roleGroupModelList, "查询角色列表成功");

    }

    @GetMapping("/searchNesting")
    @ApiOperation(value = "查询嵌套角色列表", notes = "查询嵌套角色列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "角色名称", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "filterDefaultRoleGroup", value = "过滤类型", dataType = "Boolean", paramType = "query"),
            @ApiImplicitParam(name = "reqSource", value = "请求来源", dataType = "String", defaultValue = "false", paramType = "query")
    })
    public ResponseResult searchRolesNesting(@NotBlank(message = "搜索内容不能为空") @RequestParam String name,
                                             @RequestParam(required = false) Boolean filterDefaultRoleGroup,
                                             @RequestParam(required = false) String reqSource) {
        validateNotEmpty(name);
        List<RoleGroupModel> roleGroupModels = getOrganizationFacade().searchRoleGroupByRoleName(name);

        //从数据库中获取关联组织
        List<RelatedCorpSettingModel> relatedCorpSettingModelByCorpIdIn = getSystemManagementFacade().getAllRelatedCorpSettingModel();

        Map<String, String> relatedNameMap = new HashMap<>();
        for (RelatedCorpSettingModel relatedCorpSettingModel : relatedCorpSettingModelByCorpIdIn) {
            relatedNameMap.put(relatedCorpSettingModel.getCorpId(), relatedCorpSettingModel.getName());
        }

        for (RoleGroupModel roleGroupModel : roleGroupModels) {
            String corpName = relatedNameMap.get(roleGroupModel.getCorpId());
            if (Objects.isNull(corpName)) {
                corpName = "无组织来源角色组";
            }
            roleGroupModel.setCorpName(corpName);
        }

        if (Boolean.TRUE.equals(filterDefaultRoleGroup) && CollectionUtils.isNotEmpty(roleGroupModels)) {
            roleGroupModels = roleGroupModels.stream().filter(roleGroupModel -> !DEFAULT_ROLE_GROUP.equals(roleGroupModel.getName())).collect(Collectors.toList());
        }

        List<RoleModel> roleModels = getOrganizationFacade().searchRoleByRoleName(name);
        if (Boolean.TRUE.equals(filterDefaultRoleGroup) && CollectionUtils.isNotEmpty(roleModels)) {
            roleModels = roleModels.stream().filter(roleModel -> !DEFAULT_ROLE_DEPTMANAGER.equals(roleModel.getName())).collect(Collectors.toList());
        }

        if (isCloudpivot()) {
            //自主维护不显示默认角色
            if (CollectionUtils.isNotEmpty(roleGroupModels)) {
                roleGroupModels = roleGroupModels.stream().filter(roleGroupModel -> !roleGroupModel.isDefaultGroup()).collect(Collectors.toList());
            }
            if (CollectionUtils.isNotEmpty(roleModels)) {
                Iterator<RoleModel> iterator = roleModels.iterator();
                while (iterator.hasNext()) {
                    RoleModel next = iterator.next();
                    if (isDefaultRoleGroup(next.getId())) {
                        iterator.remove();
                    }
                }
            }
        }
        List<RoleGroupModel> roleGroupModelList = Lists.newArrayList();
        Set<String> roleGroupIds = Sets.newHashSet();
        for (RoleModel roleModel : roleModels) {
            RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroupByRoleId(roleModel.getId());
            String id = roleGroupModel.getId();
            roleGroupIds.add(id);
        }
        Set<String> roleGroupModelIds = roleGroupModels.stream().filter(Objects::nonNull).map(RoleGroupModel::getId).collect(Collectors.toSet());
        if (CollectionUtils.isEmpty(roleGroupIds) && CollectionUtils.isEmpty(roleGroupModelIds)) {
            return getOkResponseResult("没有搜索到符合要求的内容");
        }
        roleGroupModelIds.removeAll(roleGroupIds);
        if (CollectionUtils.isNotEmpty(roleGroupModelIds)) {
            for (String roleGroupId : roleGroupModelIds) {
                RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroup(roleGroupId);
                roleGroupModel.setChildren(null);
                roleGroupModelList.add(roleGroupModel);
            }
        }
        Iterator<String> iterator = roleGroupIds.iterator();
        while (iterator.hasNext()) {
            String roleGroupId = iterator.next();
            RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroup(roleGroupId);
            List<RoleModel> childrens = Lists.newArrayList();
            for (RoleModel roleModel : roleModels) {
                String groupId = roleModel.getGroupId();
                String id = roleGroupModel.getId();
                if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(groupId) && Objects.equals(id, groupId)) {
                    childrens.add(roleModel);
                }
            }
            roleGroupModel.setChildren(childrens);
            roleGroupModelList.add(roleGroupModel);
        }

        roleGroupModelList = appendCatalogForRoleGroupModel(roleGroupModelList, true, false, false);
        AdminModel adminModel = getAppAdminByUserId(getUserId());
        if (Objects.nonNull(adminModel) && adminModel.getAdminType() == AdminType.APP_MNG) {
            Set<String> childrenDept = getManagePermChildDepartmentId(getUserId());
            List<String> corpIds = getOrganizationFacade().getCorpIdsByDeptIds(Lists.newArrayList(childrenDept));
            roleGroupModelList = selectionHelperExt.filterRoleGroupByCorpId(roleGroupModelList, corpIds);
            roleGroupModelList = selectionHelperExt.filterModifyUserRole(reqSource, corpIds, roleGroupModelList);
        }
        return getOkResponseResult(roleGroupModelList, "查询角色列表成功");
    }

    @GetMapping("/page/users")
    @ApiOperation(value = "查询角色用户详情列表", notes = "根据 角色id和用户名模糊查询角色用户详情列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId", value = "角色id", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "page", value = "页码", dataType = "Integer", paramType = "query", defaultValue = "0"),
            @ApiImplicitParam(name = "size", value = "页面大小", dataType = "Integer", paramType = "query", defaultValue = "20"),
            @ApiImplicitParam(name = "name", value = "用户名称", dataType = "String", required = true, paramType = "query")
    })
    public ResponseResult<Page<RoleUserVO>> userPage(@NotBlank(message = "roleId 不能为空") @RequestParam String roleId, Integer page, Integer size,
                                                     @RequestParam(required = false) String name,
                                                     @RequestParam(required = false) String deptId,
                                                     @RequestParam(required = false) String filterType) {
        Pageable pageable = PageRequest.of(page == null ? 0 : page, size == null ? 20 : size);
        RoleModel role = getOrganizationFacade().getRole(roleId);
        if (role == null) {
            log.error("未查询到角色信息,roleId:{}", roleId);
            throw new PortalException(999999L, "未查询到角色信息");
        }
        List<RoleUserModel> roleUserModels = getOrganizationFacade().getRoleUsersByRoleId(roleId);
        if (CollectionUtils.isEmpty(roleUserModels)) {
            return getOkResponseResult(null, "没有符合搜索要求的内容");
        }
        List<String> userIdList = roleUserModels.stream().map(RoleUserModel::getUserId).collect(Collectors.toList());
        if (StringUtils.isNotEmpty(filterType) && "admin".equals(filterType)) {
            AdminModel appAdminByUser = getAppAdminByUserId(getUserId());
            if (appAdminByUser != null && appAdminByUser.getAdminType() == AdminType.APP_MNG) {
                Set<String> managePermChildDepartment = getManagePermChildDepartmentId(getUserId());
                Set<String> managerUserIdList = getOrganizationFacade().getUserIdsByDepartmentIds(new ArrayList<>(managePermChildDepartment));
                userIdList = userIdList.stream().filter(managerUserIdList::contains).collect(Collectors.toList());
            }
        }
        Map<String, UserModel> userModelMap = getOrganizationFacade().getUsers(userIdList);
        List<UserModel> userModelList = userModelMap.values().stream().filter(Objects::nonNull).collect(Collectors.toList());
        if (CollectionUtils.isEmpty(userModelList)) {
            return getOkResponseResult(null, "没有符合搜索要求的内容");
        }
        if (StringUtils.isNotBlank(name)) {
            userModelList = userModelList.stream().filter(item -> item.getName().contains(name) || item.getUsername().contains(name) || item.getPinYin().contains(name)).collect(Collectors.toList());
        }
        if (CollectionUtils.isEmpty(userModelList)) {
            return getOkResponseResult(null, "没有符合搜索要求的内容");
        }
        List<DepartmentUserModel> deptUserList = getOrganizationFacade().getDepartmentUsersByUserIdsIn(userModelList.stream().map(UserModel::getId).collect(Collectors.toList()));
        Map<String, List<String>> userDeptMap = deptUserList.stream().collect(Collectors.groupingBy(DepartmentUserModel::getUserId, Collectors.mapping(DepartmentUserModel::getDeptId, Collectors.toList())));
        if (StringUtils.isNotBlank(deptId)) {
            List<String> idList = Arrays.asList(deptId.split(","));
            userModelList = userModelList.stream().filter(item -> userDeptMap.get(item.getId()).stream().anyMatch(idList::contains)).collect(Collectors.toList());
        }
        if (CollectionUtils.isEmpty(userModelList)) {
            return getOkResponseResult(null, "没有符合搜索要求的内容");
        }
        List<String> deptIdList = new ArrayList<>();
        userModelList.forEach(item -> deptIdList.addAll(userDeptMap.get(item.getId())));
        List<DepartmentModel> deptList = getOrganizationFacade().getDepartmentsByDeptIds(deptIdList);
        Map<String, DepartmentModel> deptMap = deptList.stream().collect(Collectors.toMap(DepartmentModel::getId, item -> item));
        Map<String, RoleUserModel> roleUserMap = roleUserModels.stream().collect(Collectors.toMap(RoleUserModel::getUserId, item -> item));
        List<RoleUserVO> result = userModelList.stream().map(userModel -> {
            RoleUserModel roleUserModel = roleUserMap.get(userModel.getId());
            RoleUserVO roleUserVO = new RoleUserVO();
            List<String> userDeptIdList = userDeptMap.get(userModel.getId());
            List<String> deptNameList = userDeptIdList.stream().map(item -> deptMap.get(item).getName()).collect(Collectors.toList());
            roleUserVO.setDepartmentName(StringUtils.join(deptNameList, ","));
            roleUserVO.setOuScope(getOuScope(roleUserModel.getOuScope(), roleUserModel.getUsScope()));
            roleUserVO.setRoleName(role.getName());
            roleUserVO.setRoleId(roleId);
            roleUserVO.setName(userModel.getName());
            roleUserVO.setUserId(userModel.getUserId());
            //搜索角色下的用户和 直接查询查询角色用户 接口返回的id不统一 返回的id统一用userId
            roleUserVO.setId(userModel.getId());
            roleUserVO.setUnitType(UnitType.USER);
            roleUserVO.setCorpId(userModel.getCorpId());
            return roleUserVO;
        }).collect(Collectors.toList());
        int totalElement = result.size();
        Page<RoleUserVO> roleUserVOPage = new PageImpl<>(result, pageable, totalElement);
        return getOkResponseResult(roleUserVOPage, "查询角色用户列表成功");
    }

    @GetMapping("/page/childs")
    @ApiOperation(value = "查询角色详情列表", notes = "根据 groupId 查询角色详情列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "groupId", value = "角色组id", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "page", value = "页码", dataType = "Integer", paramType = "query", defaultValue = "0"),
            @ApiImplicitParam(name = "size", value = "页面大小", dataType = "Integer", paramType = "query", defaultValue = "20")
    })
    public ResponseResult<Page<RoleVO>> childPages(@NotBlank(message = "groupId 不能为空")
                                                   @RequestParam String groupId, Integer page, Integer size) {
        Pageable pageable = PageRequest.of(page == null ? 0 : page, size == null ? 20 : size);
        Page<RoleModel> rolePage;
        rolePage = getOrganizationFacade().getRolePagesByGroupId(groupId, pageable);
        List<RoleModel> roleList = rolePage.getContent();
        final String finalGroupId = groupId;
        List<RoleVO> roleVOs = roleList.stream().filter(Objects::nonNull).map(roleModel -> {
            RoleVO role = new RoleVO();
            role.setRoleGroupId(roleModel.getGroupId());
            RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroupByRoleId(roleModel.getId());
            role.setRoleGroupName(roleGroup.getName());
            role.setRoleId(roleModel.getId());
            role.setRoleName(roleModel.getName());
            role.setCode(roleModel.getCode());
            return role;
        }).collect(Collectors.toList());
        Page<RoleVO> roleVOPage = new PageImpl<>(roleVOs, pageable, rolePage.getTotalElements());
        return getOkResponseResult(roleVOPage, "角色组列表成功");

    }

    @GetMapping("/childs")
    @ApiOperation(value = "查询角色详情列表", notes = "根据 groupId 查询角色详情列表")
    @ApiImplicitParam(name = "groupId", value = "groupId", required = true, dataType = "String", paramType = "query")
    public ResponseResult<List<RoleModel>> childs(@NotBlank(message = "groupId 不能为空")
                                                  @RequestParam String groupId) {
        List<RoleModel> roleList = getOrganizationFacade().getRolesByGroupId(groupId);
        return getOkResponseResult(roleList, "角色组列表成功");
    }

    @GetMapping("/childsNesting")
    @ApiOperation(value = "查询嵌套角色详情列表", notes = "根据 groupId 嵌套查询角色详情列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "groupId", value = "groupId", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "onlyGroup", value = "只需要角色组", dataType = "Boolean", paramType = "query")
    })
    public ResponseResult<List> childsNesting(@NotBlank(message = "groupId 不能为空")
                                              @RequestParam String groupId, @RequestParam(defaultValue = "false") Boolean onlyGroup) {
        List list = new ArrayList();
        List<RoleGroupModel> roleGroupList = getOrganizationFacade().getByParentId(groupId);

        //从数据库中获取关联组织
        List<RelatedCorpSettingModel> relatedCorpSettingModelByCorpIdIn = getSystemManagementFacade().getAllRelatedCorpSettingModel();

        Map<String, String> relatedNameMap = new HashMap<>();
        for (RelatedCorpSettingModel relatedCorpSettingModel : relatedCorpSettingModelByCorpIdIn) {
            relatedNameMap.put(relatedCorpSettingModel.getCorpId(), relatedCorpSettingModel.getName());
        }

        for (RoleGroupModel roleGroupModel : roleGroupList) {
            String corpName = relatedNameMap.get(roleGroupModel.getCorpId());
            if (Objects.isNull(corpName)) {
                corpName = "无组织来源角色组";
            }
            roleGroupModel.setCorpName(corpName);
        }
        list.addAll(roleGroupList);

        if (!onlyGroup) {
            List<RoleModel> roleList = getOrganizationFacade().getRolesByGroupId(groupId);
            list.addAll(roleList);
        }

        return getOkResponseResult(list, "角色组列表成功");
    }

    @GetMapping("/users")
    @ApiOperation(value = "查询角色用户列表", notes = "根据角色 roleId 获取角色下的用户列表,传空表示获取第一级角色的用户")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId", value = "角色id", dataType = "String", paramType = "query", defaultValue = "''"),
            @ApiImplicitParam(name = "page", value = "页码", dataType = "Integer", paramType = "query", defaultValue = "0"),
            @ApiImplicitParam(name = "size", value = "页面大小", dataType = "Integer", paramType = "query", defaultValue = "10")
    })
    public ResponseResult<Page<RoleUserVO>> users(@RequestParam(required = false, defaultValue = "") String roleId,
                                                  @Min(value = 0, message = "页码最小为0")
                                                  @RequestParam(required = false) Integer page,
                                                  @RequestParam(required = false) Integer size, @RequestParam(required = false) String filterType) {

        Pageable pageable = PageRequest.of(page == null ? 0 : page, size == null ? 10 : size);

        Page<RoleUserModel> userPage;
        final String[] tempRoleId = new String[1];

        Set<String> permUserIdSet;
        Set<String> managePermChildDepartment;
        boolean needFilter = false;
        if (StringUtils.isNotEmpty(filterType) && "admin".equals(filterType)) {
            AdminModel appAdminByUser = getAppAdminByUserId(getUserId());
            if (appAdminByUser != null && appAdminByUser.getAdminType() == AdminType.APP_MNG) {
                managePermChildDepartment = getManagePermChildDepartmentId(getUserId());
                permUserIdSet = getOrganizationFacade().getUserIdsByDepartmentIds(new ArrayList<>(managePermChildDepartment));
                needFilter = true;
            } else {
                permUserIdSet = new HashSet<>();
                managePermChildDepartment = new HashSet<>();
            }
        } else {
            permUserIdSet = new HashSet<>();
            managePermChildDepartment = new HashSet<>();
        }

        if (StringUtils.isBlank(roleId)) {
            //自主维护默认角色组不显示在前端
            List<RoleGroupModel> roleGroupList = getOrganizationFacade().getRoleGroups();
            if (isCloudpivot() && CollectionUtils.isNotEmpty(roleGroupList)) {
                roleGroupList = roleGroupList.stream().filter(item -> !DEFAULT_ROLE_GROUP.equals(item.getName())).collect(Collectors.toList());
            }
            // 传空获取第一级角色下的用户
            AtomicReference<Page<RoleUserModel>> userPageRef = new AtomicReference<>(Page.empty());
            //Sort sort = new Sort(Sort.Direction.ASC, "sortKey");
            //拿到第一级角色组
            Optional.ofNullable(roleGroupList).flatMap(l -> l.stream().filter(Objects::nonNull).findFirst())
                    .map(RoleGroupModel::getId).ifPresent(groupId -> {

                List<RoleModel> childrenList = getOrganizationFacade().getRolesByGroupId(groupId);
                Optional.ofNullable(childrenList).flatMap(l -> l.stream().filter(role -> role != null && !"部门主管".equals(role.getName())).findFirst())
                        .map(RoleModel::getId).ifPresent(firstRoleId -> {
                    tempRoleId[0] = firstRoleId;
                    Page<RoleUserModel> roleUserModels = getOrganizationFacade().getRoleUsersByRoleId(firstRoleId, pageable);
                    userPageRef.set(roleUserModels);
                });
            });

            //加个判空，避免取出optional中的值抛空；
            Optional<String> result = Optional.of(tempRoleId).filter(temp -> !Strings.isNullOrEmpty(temp[0]))
                    .map(strings -> strings[0]);
            if (result.isPresent()) {
                roleId = result.get();
            }
            userPage = userPageRef.get();

        } else {
            if (isCloudpivot() && isDefaultRoleGroup(roleId)) {
                Page<RoleUserVO> roleUserVOPage = new PageImpl<>(Lists.newArrayList(), pageable, 0L);
                return getOkResponseResult(roleUserVOPage, "查询用户信息成功");
            }
            userPage = getOrganizationFacade().getRoleUsersByRoleId(roleId, pageable);
        }
        List<RoleUserModel> roleUserList = userPage.getContent();
        final String finalRoleId = roleId;
        if (CollectionUtils.isEmpty(roleUserList)) {
            Page<RoleUserVO> roleUserVOPage = new PageImpl<>(Lists.newArrayList(), pageable, 0L);
            return getOkResponseResult(roleUserVOPage, "查询用户信息成功");
        }

        List<String> userIds = roleUserList.stream().filter(item -> (UnitType.USER == item.getUnitType() && StringUtils.isNotBlank(item.getUserId()))).map(RoleUserModel::getUserId).collect(Collectors.toList());
        //List<String> deptIds = roleUserList.stream().filter(item -> UnitType.DEPARTMENT == item.getUnitType() && StringUtils.isNotBlank(item.getDeptId())).map(RoleUserModel::getDeptId).collect(Collectors.toList());
        Map<String, UserModel> userMaps = getOrganizationFacade().getUsers(userIds);
        //List<DepartmentModel> deptList = getOrganizationFacade().getDepartmentsByDeptIds(deptIds);

        boolean finalNeedFilter = needFilter;
        List<RoleUserVO> roleUserVOList = roleUserList.stream().filter(user ->
                //finalNeedFilter ? Objects.nonNull(user) && (permUserIdSet.contains(user.getUserId()) || managePermChildDepartment.contains(user.getDeptId())) : Objects.nonNull(user)).map(roleUser -> {
                finalNeedFilter ? Objects.nonNull(user) && permUserIdSet.contains(user.getUserId()) : Objects.nonNull(user)).map(roleUser -> {
            RoleUserVO roleUserVO = new RoleUserVO();
            UserModel userModel = userMaps.get(roleUser.getUserId());
            if (userModel != null) {
                BeanUtils.copyProperties(userModel, roleUserVO);
            } else {
                return null;
            }
            roleUserVO.setId(roleUser.getUserId());
            roleUserVO.setRoleId(finalRoleId);
            return roleUserVO;
        }).collect(Collectors.toList());

        roleUserVOList = roleUserVOList.stream().filter(Objects::nonNull).collect(Collectors.toList());
        if (!CollectionUtils.isEmpty(roleUserVOList)) {
            //添加管理范围 ouScope
            Set<String> permIds = new HashSet<>(managePermChildDepartment);
            permIds.addAll(permUserIdSet);
            setOuScope(roleUserVOList, roleId, userIds, permIds, needFilter);
            //添加所属部门
            setDepartment(roleUserVOList, userIds);
        }
        Page<RoleUserVO> roleUserVOPage = new PageImpl<>(roleUserVOList, pageable, userPage.getTotalElements());
        return getOkResponseResult(roleUserVOPage, "查询用户信息成功");
    }

    /**
     * 是否默认角色组
     * @param roleId
     * @return
     */
    private boolean isDefaultRoleGroup(String roleId) {
        RoleModel roleModel = getOrganizationFacade().getRole(roleId);
        RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroup(roleModel.getGroupId());
        return roleGroup.isDefaultGroup();
    }

    private String getClassPathName(String deptId) {
        String classPathName = "";
        List<DepartmentModel> parentDepts = getOrganizationFacade().getParentDepartments(deptId, Boolean.TRUE);
        if (!org.springframework.util.CollectionUtils.isEmpty(parentDepts)) {
            Collections.reverse(parentDepts);
            if (parentDepts.size() > 3) {
                parentDepts = parentDepts.subList(2, parentDepts.size());
            }
            List<String> eduClassName = parentDepts.stream().map(item -> item.getName()).collect(Collectors.toList());
            classPathName = StringUtils.join(eduClassName, "/");
        }
        return classPathName;
    }

    @GetMapping("/get_ouscope")
    @ApiOperation(value = "查询角色用户管理范围", notes = "根据角色 userId 获取角色用户管理范围")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId", value = "角色Id", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "userId", value = "用户id", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "unitType", value = "关联类型", dataType = "Integer", paramType = "query", defaultValue = "3")

    })
    public ResponseResult<List<Map<String, String>>> getOuScope(@RequestParam String roleId, @RequestParam String userId, @RequestParam(defaultValue = "3") Integer unitType) {
        validateNotEmpty(userId, "用户id不能为空");
        validateNotEmpty(roleId, "角色id不能为空");
        if (log.isDebugEnabled()) {
            log.debug("\n调用引擎接口【getRoleUsersByRoleIdAndUserIds()】,参数：roleId=【{}】,userId=【{}】", roleId, userId);
        }

        Map<String, RoleUserModel> roleUsersMap;
        RoleUserModel roleUserModel = null;
        if (UnitType.USER == UnitType.get(unitType)) {
            roleUsersMap = getOrganizationFacade().getRoleUsersByRoleIdAndUserIds(roleId, ImmutableList.of(userId));
            if (!MapUtils.isEmpty(roleUsersMap)) {
                roleUserModel = roleUsersMap.get(userId);
            }
        } else if (UnitType.DEPARTMENT == UnitType.get(unitType)) {
            roleUserModel = getOrganizationFacade().getRoleUserByRoleIdAndDeptId(roleId, userId);
        }
        if (null == roleUserModel) {
            return getOkResponseResult(null, "查询角色用户管理范围成功");
        }
        String ouScope = roleUserModel.getOuScope();
        String usScope = roleUserModel.getUsScope();
        List<Map<String, String>> result = Lists.newArrayList();

        AdminModel appAdminByUser = getAppAdminByUserId(getUserId());
        Set<String> permDeptIdSet;
        Set<String> permUserIdSet = new HashSet<>();
        boolean needFilter = false;
        if (appAdminByUser != null && appAdminByUser.getAdminType() == AdminType.APP_MNG) {
            needFilter = true;
            permDeptIdSet = getManagePermChildDepartmentId(getUserId());
        } else {
            permDeptIdSet = new HashSet<>();
        }
        if (!Strings.isNullOrEmpty(ouScope)) {
            List<String> departmentIds = JSON.parseArray(ouScope, String.class);
            for (String departmentId : departmentIds) {
                if (needFilter && !permDeptIdSet.contains(departmentId)) {
                    continue;
                }
                DepartmentModel department = getOrganizationFacade().getDepartment(departmentId);
                //fixed bug #44949
                if (null != department) {
                    Map<String, String> departmentMap = Maps.newHashMap();
                    departmentMap.put("id", departmentId);
                    departmentMap.put("name", department.getName());
                    departmentMap.put("type", "1");
                    result.add(departmentMap);
                    continue;
                }

            }
        }
        if (!Strings.isNullOrEmpty(usScope)) {
            //fixed bug #45957
            List<String> userIds = JSON.parseArray(usScope, String.class);
            if (needFilter) {
                if (!permDeptIdSet.isEmpty()) {
                    permUserIdSet.addAll(getOrganizationFacade().getUserIdsByDepartmentIds(new ArrayList<>(permDeptIdSet)));
                }
            }
            for (String scopeuserId : userIds) {
                if (needFilter && !permUserIdSet.contains(scopeuserId)) {
                    continue;
                }
                UserModel user = getOrganizationFacade().getUser(scopeuserId);
                if (null != user) {
                    Map<String, String> userMap = Maps.newHashMap();
                    userMap.put("id", scopeuserId);
                    userMap.put("name", user.getName());
                    userMap.put("type", "3");
                    result.add(userMap);
                }
            }
        }
        return getOkResponseResult(result, "查询角色用户管理范围成功");
    }

    @PutMapping("/update_ouscope")
    @ApiOperation(value = "更新角色用户管理范围", notes = "更新角色用户管理范围")
    public ResponseResult<Void> updateOuScope(@RequestBody RoleUserOuScopeVO roleUserOuScopeVO) {
        if (StringUtils.isBlank(roleUserOuScopeVO.getUserId()) && StringUtils.isBlank(roleUserOuScopeVO.getDeptId())) {
            validateNotEmpty(StringUtils.EMPTY, "用户ID和部门ID不能同时为空");
        }
        validateNotEmpty(roleUserOuScopeVO.getRoleId(), "角色id不能为空");

        RoleUserModel roleUserModel = new RoleUserModel();
        roleUserModel.setUserId(roleUserOuScopeVO.getUserId());
        roleUserModel.setRoleId(roleUserOuScopeVO.getRoleId());
        roleUserModel.setDeptId(roleUserOuScopeVO.getDeptId());
        roleUserModel.setUnitType(UnitType.get(roleUserOuScopeVO.getUnitType()));

        List<String> ouScopeList = new ArrayList<>();
        List<String> usScopeList = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(roleUserOuScopeVO.getOuScopeList())) {
            roleUserOuScopeVO.getOuScopeList().stream().forEach(scope -> {
                if (UnitType.DEPARTMENT == scope.getType()) {
                    ouScopeList.add(scope.getId());
                } else if (UnitType.USER == scope.getType()) {
                    usScopeList.add(scope.getId());
                }
            });
        }


        //应用管理员添加逻辑 把原有的管理部门拿出来与应用管理员管理范围对比，不在里面的（管理范围外的）拿出来重新加进去（因现在前端显示的用户管理范围）
        AdminModel appAdminByUser = getAppAdminByUserId(getUserId());
        if (appAdminByUser != null && appAdminByUser.getAdminType() == AdminType.APP_MNG) {
            Set<String> managePermChildDepartment = getManagePermChildDepartmentId(getUserId());
            Set<String> managePermUsers = getOrganizationFacade().getDepartmentUsersByDeptIdsIn(new ArrayList<>(managePermChildDepartment)).stream().map(DepartmentUserModel::getUserId).collect(Collectors.toSet());
            if (roleUserOuScopeVO.getUnitType() == UnitType.USER.getIndex()) {
                if (StringUtils.isNotEmpty(roleUserOuScopeVO.getUserId())) {
                    String[] userIds = roleUserOuScopeVO.getUserId().split(",");
                    for (String userId : userIds) {
                        RoleUserModel source = getOrganizationFacade().getRoleUserByRoleIdAndUserId(roleUserOuScopeVO.getRoleId(), userId);
                        if (source != null) {
                            String ouScope = source.getOuScope();
                            if (StringUtils.isNotEmpty(ouScope)) {
                                List<String> _ouScope = JSON.parseArray(ouScope, String.class);
                                for (String deptId : _ouScope) {
                                    if (!managePermChildDepartment.contains(deptId)) {
                                        ouScopeList.add(deptId);
                                    }
                                }
                            }
                            String usScope = source.getUsScope();
                            if (StringUtils.isNotEmpty(usScope)) {
                                List<String> _usScope = JSON.parseArray(usScope, String.class);
                                for (String socpeUserId : _usScope) {
                                    if (!managePermUsers.contains(socpeUserId)) {
                                        usScopeList.add(socpeUserId);
                                    }
                                }
                            }
                        }
                    }
                }
            } else if (roleUserOuScopeVO.getUnitType() == UnitType.DEPARTMENT.getIndex()) {
                if (StringUtils.isNotEmpty(roleUserOuScopeVO.getDeptId())) {
                    String[] deptIds = roleUserOuScopeVO.getDeptId().split(",");
                    for (String deptVoId : deptIds) {
                        RoleUserModel source = getOrganizationFacade().getRoleUserByRoleIdAndDeptId(roleUserOuScopeVO.getRoleId(), deptVoId);
                        if (source != null) {
                            String ouScope = source.getOuScope();
                            if (StringUtils.isNotEmpty(ouScope)) {
                                List<String> _ouScope = JSON.parseArray(ouScope, String.class);
                                for (String deptId : _ouScope) {
                                    if (!managePermChildDepartment.contains(deptId)) {
                                        ouScopeList.add(deptId);
                                    }
                                }

                            }
                            String usScope = source.getUsScope();
                            if (StringUtils.isNotEmpty(usScope)) {
                                List<String> _usScope = JSON.parseArray(usScope, String.class);
                                for (String socpeUserId : _usScope) {
                                    if (!managePermUsers.contains(socpeUserId)) {
                                        usScopeList.add(socpeUserId);
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }

        if (CollectionUtils.isNotEmpty(ouScopeList)) {
            //组织管理域去重
            Set ouScopeSet = Sets.newHashSet(ouScopeList);
            String ouScopeStr = JSON.toJSONString(ouScopeSet);
            roleUserModel.setOuScope(ouScopeStr);
        }
        roleUserModel.setUsScope(CollectionUtils.isEmpty(usScopeList) ? null : JSON.toJSONString(new HashSet<>(usScopeList)));

        getOrganizationFacade().batchUpdateRoleUser(roleUserModel);
        return getOkResponseResult("更新角色用户管理范围成功");
    }

    /**
     * @return void
     * @Description: 设置所属部门
     * @Param [roleUserVOList, idList]
     * @author dengchao
     * @date 2018/11/1 20:56
     */
    private void setDepartment(List<RoleUserVO> roleUserVOList, List<String> idList) {
        Map<String, List<String>> departmentNameMap = getOrganizationFacade().getDepartmentsByUserIds(idList);
        if (MapUtils.isNotEmpty(departmentNameMap)) {
            roleUserVOList.forEach(roleUserVO -> {
                if (roleUserVO != null) {
                    List<String> departmentNameList = departmentNameMap.get(roleUserVO.getId());
                    if (!CollectionUtils.isEmpty(departmentNameList)) {
                        roleUserVO.setDepartmentName(String.join(",", departmentNameList));
                    }
                }
            });
        }
    }

    /**
     * @return void  人员跟部门信息都设置到vo的OuScope
     * @Description: 设置管理范围      permIdSet:应用管理员  管理范围内的部门和人员的ID
     * @Param [roleUserVOList, idList]
     * @author dengchao
     * @date 2018/11/1 20:57
     */
    private void setOuScope(List<RoleUserVO> roleUserVOList, String roleId, List<String> idList, Set<String> permIdSet, boolean needFilter) {
        Map<String, RoleUserModel> roleUserMap = getOrganizationFacade().getRoleUsersByRoleIdAndUserIds(roleId, idList);
        roleUserVOList.forEach(roleUserVO -> {
            if (roleUserVO == null) {

            } else if (UnitType.DEPARTMENT == roleUserVO.getUnitType()) {
                roleUserVO.setOuScope(getOuScope(roleUserVO.getExtend3(), roleUserVO.getExtend2()).stream().filter(map ->
                        !needFilter || permIdSet.contains(map.get("id"))).collect(Collectors.toList()));
            } else {
                RoleUserModel roleUser = roleUserMap.get(roleUserVO.getId());
                if (roleUser != null) {
                    // 暂且认定 ouScope 字段存放格式 id1,id2
                    String ouScope = roleUser.getOuScope();
                    roleUserVO.setOuScope(getOuScope(ouScope, roleUser.getUsScope()).stream().filter(map ->
                            !needFilter || permIdSet.contains(map.get("id"))).collect(Collectors.toList()));
                }
            }
        });
    }


    private List<Map<String, String>> getOuScope(String ouScope, String usScope) {
        List<Map<String, String>> ouScopeList = Lists.newArrayList();
        if (StringUtils.isNotBlank(ouScope)) {
            List<String> deptIdList = JSON.parseArray(ouScope, String.class);
            List<DepartmentModel> departmentsByDeptIds = getOrganizationFacade().getDepartmentsByDeptIds(deptIdList);
            departmentsByDeptIds.forEach(department -> {
                String departmentName = Optional.ofNullable(department).map(DepartmentModel::getName).orElse(null);
                if (StringUtils.isNotBlank(departmentName)) {
                    Map<String, String> ouScopeMap = Maps.newHashMap();
                    ouScopeMap.put("id", department.getId());
                    ouScopeMap.put("name", departmentName);
                    ouScopeMap.put("type", "1");
                    ouScopeList.add(ouScopeMap);
                }
            });
        }
        if (StringUtils.isNotBlank(usScope)) {
            List<String> userIdList = JSON.parseArray(usScope, String.class);
            Map<String, UserModel> userModelMap = getOrganizationFacade().getUsers(userIdList);
            userModelMap.values().forEach(userModel -> {
                String userName = Optional.ofNullable(userModel).map(UserModel::getName).orElse(null);
                if (StringUtils.isBlank(userName)) {
                    return;
                }
                Map<String, String> ouScopeUserMap = Maps.newHashMap();
                ouScopeUserMap.put("id", userModel.getId());
                ouScopeUserMap.put("name", userName);
                ouScopeUserMap.put("type", "3");
                ouScopeList.add(ouScopeUserMap);
            });
        }
        return ouScopeList;
    }

    /**
     * @return
     * @Description: 角色组的新增
     * @Param params
     * @author liuqs
     * @date 2019/11/22 14:47
     */

    @PostMapping("/add_role_group")
    @ApiOperation(value = "新增角色组", notes = "新增角色组")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "角色组名称", dataType = "String", paramType = "query")
    })
    public ResponseResult<RoleGroupVO> addRoleGroup(@RequestBody RoleGroupVO params) {
        String userId = getUserId();
        String corpId = params.getCorpId();
        if (StringUtils.isBlank(corpId)) {
            RelatedCorpSettingModel relatedCorpSettingModel = getSystemManagementFacade().getRelatedCorpSettingModel(params.getParentId());
            if (relatedCorpSettingModel == null) {
                return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "未查询到所属组织信息");
            }
            corpId = relatedCorpSettingModel.getCorpId();
        }
        if (!checkUserCorpPerm(userId, corpId)) {
            return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "用户没有新增角色组权限");
        }
        RoleGroupHelper roleGroupHelper = new RoleGroupHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleGroupHelper.create(params, userId);
    }

    /**
     * @return
     * @Description: 角色组的修改
     * @Param params
     * @author liuqs
     * @date 2019/11/22 14:47
     */
    @PutMapping("/modify_role_group")
    @ApiOperation(value = "更新角色组", notes = "更新角色组")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "角色组主键ID", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "name", value = "角色组名称", dataType = "String", paramType = "query")
    })
    public ResponseResult<RoleGroupVO> modifyRoleGroup(@RequestBody RoleGroupVO params) {
        String userId = getUserId();
        String corpId = params.getCorpId();
        if (StringUtils.isBlank(corpId)) {
            RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroup(params.getRoleGroupId());
            if (roleGroupModel == null) {
                return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "未查询到角色组信息");
            }
            corpId = roleGroupModel.getCorpId();
        }
        if (!checkUserCorpPerm(userId, corpId)) {
            return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "用户没有更新角色组权限");
        }
        RoleGroupHelper roleGroupHelper = new RoleGroupHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleGroupHelper.update(params, userId);
    }

    /**
     * @return
     * @Description: 角色组的删除
     * @Param params
     * @author liuqs
     * @date 2019/11/22 14:47
     */
    @GetMapping("/strike_out_role_group")
    @ApiOperation(value = "删除角色组", notes = "删除角色组")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "ids", value = "角色组id", dataType = "String", paramType = "query")
    })
    public ResponseResult<List<RoleGroupVO>> strikeOutRoleGroup(@RequestParam String ids) {
        String userId = getUserId();
        if (Arrays.stream(ids.split(",")).anyMatch(id -> {
            RoleGroupModel roleGroupModel = getOrganizationFacade().getRoleGroup(id);
            return roleGroupModel == null || !checkUserCorpPerm(userId, roleGroupModel.getCorpId());
        })) {
            return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "用户没有删除角色组权限");
        }
        RoleGroupHelper roleGroupHelper = new RoleGroupHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleGroupHelper.delete(ids, userId);
    }

    /**
     * @return
     * @Description: 角色的新增
     * @Param params
     * @author liuqs
     * @date 2019/11/22 14:47
     */
    @PostMapping("/add_role")
    @ApiOperation(value = "新增角色", notes = "新增角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleName", value = "角色名称", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "roleGroupId", value = "角色组主键", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "corpId", value = "组织corpId", dataType = "String", paramType = "query")
    })
    public ResponseResult<RoleVO> addRole(@RequestBody RoleVO params) {
        log.info("角色传参" + JSONObject.toJSONString(params));
        String userId = getUserId();
        String corpId = params.getCorpId();
        if (StringUtils.isBlank(corpId)) {
            RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroup(params.getRoleGroupId());
            if (roleGroup == null) {
                return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "未查询到所属角色组信息");
            }
            corpId = roleGroup.getCorpId();
        }
        if (!checkUserCorpPerm(userId, corpId)) {
            return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "用户没有新增角色权限");
        }
        if (StringUtils.isNotBlank(params.getCode())) {
            RoleModel roleModel = getOrganizationFacade().getRoleByCode(params.getCode());
            if (roleModel != null) {
                return getErrResponseResult(null, ErrCode.ORG_ROLE_CODE_EXIST.getErrCode(), "角色编码已经存在");
            }
        }
        RoleHelper roleHelper = new RoleHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleHelper.create(params, userId);
    }

    private boolean checkUserCorpPerm(String userId, String corpId) {
        List<AdminModel> adminModelList = getAdminFacade().getAdminByUserId(userId);
        // 非管理员，无权限
        if (CollectionUtils.isEmpty(adminModelList)) {
            return false;
        }
        // admin或系统管理员，有权限
        if (adminModelList.stream().anyMatch(item -> AdminType.ADMIN == item.getAdminType() || AdminType.SYS_MNG == item.getAdminType())) {
            return true;
        }
        // 子管理员判断组织管理范围以及组织全县开关
        List<AdminModel> appManagerList = adminModelList.stream().filter(item -> AdminType.APP_MNG == item.getAdminType()).collect(Collectors.toList());
        if (CollectionUtils.isEmpty(appManagerList)) {
            return false;
        }
        return appManagerList.stream().anyMatch(item -> {
            if (item.getRoleManage() == null || !item.getRoleManage()) {
                return false;
            }
            //自建角色组都可以新增
            if ("other".equals(corpId)) {
                return true;
            }
            List<DepartmentScopeModel> departmentScopList = item.getDepartments();
            if (CollectionUtils.isEmpty(departmentScopList)) {
                return false;
            }
            List<String> deptIdList = departmentScopList.stream().filter(deptScope -> UnitType.DEPARTMENT == deptScope.getUnitType()).map(DepartmentScopeModel::getUnitId).collect(Collectors.toList());
            List<DepartmentModel> deptList = getOrganizationFacade().getDepartmentsByDeptIds(deptIdList);
            return CollectionUtils.isNotEmpty(deptList) && deptList.stream().anyMatch(dept -> corpId.equals(dept.getCorpId()));
        });
    }

    /**
     * @return
     * @Description: 角色的修改
     * @Param params
     * @author liuqs
     * @date 2019/11/22 14:47
     */
    @PutMapping("/modify_role")
    @ApiOperation(value = "更新角色", notes = "更新角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "角色主键", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "name", value = "角色名称", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "roleGroupId", value = "角色名称", dataType = "String", paramType = "query")
    })
    public ResponseResult<RoleVO> modifyRole(@RequestBody RoleVO params) {
        String userId = getUserId();
        String corpId = params.getCorpId();
        if (StringUtils.isBlank(corpId)) {
            RoleGroupModel roleGroup = getOrganizationFacade().getRoleGroup(params.getRoleGroupId());
            if (roleGroup == null) {
                return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "未查询到所属角色组信息");
            }
            corpId = roleGroup.getCorpId();
        }
        if (!checkUserCorpPerm(userId, corpId)) {
            return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "用户没有更新角色权限");
        }
        RoleHelper roleHelper = new RoleHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleHelper.update(params, userId);
    }

    /**
     * @return
     * @Description: 角色的删除
     * @Param
     * @author liuqs
     * @date 2019/11/22 14:47
     */
    @GetMapping("/strike_out_role")
    @ApiOperation(value = "删除角色", notes = "删除角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "ids", value = "角色id集合，中间用逗号分隔", dataType = "String", paramType = "query")
    })
    public ResponseResult<List<RoleVO>> strikeOutRole(@RequestParam String ids) {
        String userId = getUserId();
        if (Arrays.stream(ids.split(",")).anyMatch(id -> {
            RoleModel roleModel = getOrganizationFacade().getRole(id);
            return roleModel == null || !checkUserCorpPerm(userId, roleModel.getCorpId());
        })) {
            return getErrResponseResult(null, ErrCode.PERMISSION_NO_DATA.getErrCode(), "用户没有删除角色权限");
        }
        RoleHelper roleHelper = new RoleHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleHelper.delete(ids, userId);
    }

    @ApiOperation(value = "查询角色组详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "角色组编码", dataType = "String", paramType = "query", required = true),
    })
    @GetMapping("/roleGroup/info")
    public ResponseResult<RoleGroupVO> roleGroupInfo(String code) {
        RoleGroupHelper roleGroupHelper = new RoleGroupHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleGroupHelper.info(code);
    }

    @ApiOperation(value = "查询角色详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "角色编码", dataType = "String", paramType = "query", required = true),
    })
    @GetMapping("/role/info")
    public ResponseResult<RoleVO> roleInfo(String code) {
        RoleHelper roleHelper = new RoleHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        return roleHelper.info(code);
    }

    /**
     * @return
     * @Description: 批量新增角色员工/部门（同一角色下）
     * @Param
     * @author liuqs
     * @date 2019/11/22 14:47
     */
    @PostMapping("/add_role_user")
    @ApiOperation(value = "新增角色员工、部门", notes = "新增角色关联")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "params", value = "角色员工集合", dataType = "String", paramType = "query")
    })
    public ResponseResult<List<RoleUserVO>> addRoleUsers(@RequestBody Map<String, Object> params) {
        RoleHelper roleHelper = new RoleHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        String userId = getUserId();
        String roleId;
        List<RoleUserVO> userIds = Lists.newArrayList();
        if (MapUtils.isNotEmpty(params)) {
            Object roleid = params.get("roleId");
            boolean aNull = Objects.isNull(roleid);
            roleId = aNull ? "" : roleid.toString();
            Object userids = params.get("userIds");
            boolean aNull1 = Objects.isNull(userids);
            ArrayList<LinkedHashMap<String, Object>> map = Lists.newArrayList();

            ArrayList<LinkedHashMap<String, Object>> userIdList = (ArrayList<LinkedHashMap<String, Object>>) userids;
            map = aNull1 ? map : userIdList;
            if (CollectionUtils.isNotEmpty(map)) {
                toRoleUser(map, userIds, params.get("type"), params.get("orgIds"));
            }

            if (CollectionUtils.isEmpty(userIds)) {
                return getErrResponseResult(null, -1L, "用户userIds不能为空");
            }

            Object ouScope = params.get("ouScope");
            boolean aNull2 = Objects.isNull(ouScope);
            List<SelectionValue> ouScopes = aNull2 ? Lists.newArrayList() : JSONArray.parseArray(JSON.toJSONString(params.get("ouScope")), SelectionValue.class);
            return roleHelper.addRoleUsers(roleId, userId, userIds, ouScopes);
        }
        return getErrResponseResult(null, -1L, "新增角色员工异常");

    }

    private void toRoleUser(ArrayList<LinkedHashMap<String, Object>> map, List<RoleUserVO> userIds, Object type, Object orgIds) {
        if (CollectionUtils.isNotEmpty(map)) {
            map.forEach(item -> {
                RoleUserVO roleUserVO = new RoleUserVO();
                Integer unitType = (Integer) item.get("unitType");
                roleUserVO.setId((String) item.get("id"));
                roleUserVO.setUnitType(UnitType.get(unitType));
                userIds.add(roleUserVO);
            });
        }
    }

    /**
     * @return
     * @Description: 批量删除角色员工（同一角色下）
     * @Param
     * @author liuqs
     * @date 2019/11/22 14:47
     */
    @PostMapping("/strike_out_role_user")
    @ApiOperation(value = "删除角色员工", notes = "删除角色员工")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "ids", value = "用户id集合", dataType = "List", paramType = "query"),
            @ApiImplicitParam(name = "deptIds", value = "部门id集合", dataType = "List", paramType = "query"),
            @ApiImplicitParam(name = "roleId", value = "角色id", dataType = "String", paramType = "query")
    })
    public ResponseResult<List<RoleUserVO>> strikeOutRoleUsers(@RequestBody Map<String, Object> params) {

        RoleHelper roleHelper = new RoleHelper(getOrganizationFacade(), redisCacheService, getSystemManagementFacade());
        String userId = getUserId();
        String roleId;
        List<String> userIds = Lists.newArrayList();
        List<String> deptIds = Lists.newArrayList();
        if (MapUtils.isNotEmpty(params)) {
            Object roleid = params.get("roleId");
            boolean aNull = Objects.isNull(roleid);
            roleId = aNull ? "" : roleid.toString();

            Object userids = params.get("userIds");
            boolean aNull1 = Objects.isNull(userids);
            ArrayList<String> list = Lists.newArrayList();
            List<String> userIdList = (List<String>) userids;
            userIds = aNull1 ? list : userIdList;

            Object deptids = params.get("deptIds");
            boolean aNull2 = Objects.isNull(deptids);
            ArrayList<String> deptList = Lists.newArrayList();
            List<String> deptIdList = (List<String>) deptids;
            deptIds = aNull2 ? deptList : deptIdList;
            return roleHelper.deleteRoleUsers(roleId, userId, userIds, deptIds);
        }
        return getErrResponseResult(null, -1L, "删除角色员工异常");
    }

}