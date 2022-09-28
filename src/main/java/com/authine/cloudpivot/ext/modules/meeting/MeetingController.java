package com.authine.cloudpivot.ext.modules.meeting;


import com.alibaba.fastjson.JSON;
import com.authine.cloudpivot.engine.api.model.organization.DepartmentModel;
import com.authine.cloudpivot.engine.api.model.organization.UserModel;
import com.authine.cloudpivot.engine.api.model.runtime.*;
import com.authine.cloudpivot.engine.api.model.workflow.WorkflowTokenModel;
import com.authine.cloudpivot.engine.component.query.api.FilterExpression;
import com.authine.cloudpivot.engine.component.query.api.Page;
import com.authine.cloudpivot.engine.component.query.api.helper.PageableImpl;
import com.authine.cloudpivot.engine.component.query.api.helper.Q;
import com.authine.cloudpivot.engine.enums.status.WorkflowInstanceStatus;
import com.authine.cloudpivot.engine.enums.type.DefaultPropertyType;
import com.authine.cloudpivot.engine.workflow.enums.ActivityType;
import com.authine.cloudpivot.web.api.controller.base.BaseController;
import com.authine.cloudpivot.web.api.exception.PortalException;
import com.authine.cloudpivot.web.api.exception.ResultEnum;
import com.authine.cloudpivot.web.api.view.ResponseResult;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;


@Api(tags = "示例模块::会议系统")
@RestController
@Validated
@Slf4j
@RequestMapping("/api/meeting")
public class MeetingController extends BaseController {

    private static final String DATE_FORMAT_YYYYMMDD_HHMMSS = "yyyy-MM-dd HH:mm:ss";
    private static final String DATE_FORMAT_YYYYMMDD_HHMM = "yyyy-MM-dd HH:mm";
    private static final String DATE_FORMAT_YYYYMMDD = "yyyy-MM-dd";

    @GetMapping(value = "/query")
    @ResponseBody
    @ApiOperation(value = "按照会议ID和创建人查询")
    public ResponseResult<List<Map<String, Object>>> query(String meetingId, String creater) {
        BizObjectQueryModel bizObjectQueryObject = new BizObjectQueryModel();
        PageableImpl pageable = new PageableImpl(0, Integer.MAX_VALUE);
        Map<String, Object> condition = Maps.newHashMap();
        if (StringUtils.isNotEmpty(meetingId)) {
            condition.put("meeting", meetingId);
        }
        if (StringUtils.isNotEmpty(creater)) {
            condition.put("creater", creater);
        }
        FilterExpression finalExpression = resolveFilters(condition);
        bizObjectQueryObject.setFilterExpr(finalExpression);
        bizObjectQueryObject.setPageable(pageable);
        bizObjectQueryObject.setSchemaCode("meeting_signin");
        bizObjectQueryObject.setQueryCode("meeting_signin");
        List<Map<String, Object>> mapList = Lists.newArrayList();
        Page<BizObjectModel> data = getBizObjectFacade().queryBizObjects(bizObjectQueryObject);
        if (data != null && CollectionUtils.isNotEmpty(data.getContent())) {
            mapList = resolveData(data.getContent());
        }
        BizObjectCreatedModel meeting_notice = getBizObjectFacade().getBizObject(getUserId(), "meeting_notice", meetingId);
        resolveSignPersons(mapList, meeting_notice);

        return getOkResponseResult(mapList, "查询成功");
    }

    @GetMapping(value = "/validate")
    @ResponseBody
    @ApiOperation(value = "用户是否可以签到")
    public ResponseResult<Map<String, Object>> validate(String meetingId) {
        String userId = getUserId();
        Map<String, Object> map = Maps.newHashMap();
        map.put("result", true);
        BizObjectCreatedModel meeting_notice = getBizObjectFacade().getBizObject(getUserId(), "meeting_notice", meetingId);
        List<String> userIds = resolveNoticePersonsTemplate(meeting_notice);
        if (CollectionUtils.isEmpty(userIds)) {
            map.put("result", false);
            map.put("info", "不在此次签到范围内");
            return getOkResponseResult(map, "查询成功");
        }
        if (!userIds.contains(userId)) {
            map.put("result", false);
            map.put("info", "不在此次签到范围内");
            return getOkResponseResult(map, "查询成功");
        }
        //判断是否已经签到
        BizObjectQueryModel bizObjectQueryObjectTemplate = new BizObjectQueryModel();
        Map<String, Object> condition = Maps.newHashMap();
        if (StringUtils.isNotEmpty(meetingId)) {
            condition.put("meeting", meetingId);
        }
        condition.put(DefaultPropertyType.CREATER.getCode(), userId);
        FilterExpression finalExpression = resolveFilters(condition);
        bizObjectQueryObjectTemplate.setFilterExpr(finalExpression);
        bizObjectQueryObjectTemplate.setPageable(new PageableImpl(0, Integer.MAX_VALUE));
        bizObjectQueryObjectTemplate.setSchemaCode("meeting_signin");
        bizObjectQueryObjectTemplate.setQueryCode("meeting_signin");
        Page<BizObjectModel> dataTempalte = getBizObjectFacade().queryBizObjects(bizObjectQueryObjectTemplate);
        if (dataTempalte != null && CollectionUtils.isNotEmpty(dataTempalte.getContent())) {
            map.put("result", false);
            map.put("info", "你已经签到过");
            return getOkResponseResult(map, "查询成功");
        }
        //获取系统配置时间
        BizObjectQueryModel bizObjectQueryObject = new BizObjectQueryModel();
        bizObjectQueryObject.setFilterExpr(FilterExpression.empty);
        bizObjectQueryObject.setPageable(new PageableImpl(0, Integer.MAX_VALUE));
        bizObjectQueryObject.setSchemaCode("setting");
        bizObjectQueryObject.setQueryCode("setting");
        Page<BizObjectModel> data = getBizObjectFacade().queryBizObjects(bizObjectQueryObject);
        if (!validateSiteAble(data, meeting_notice, map)) {
            return getOkResponseResult(map, "查询成功");
        }

        return getOkResponseResult(map, "查询成功");
    }

    /**
     * 获取可以签到人员信息
     */
    @SuppressWarnings("unchecked")
    private List<String> resolveNoticePersonsTemplate(BizObjectCreatedModel meeting_notice) {
        List<String> selectionValues = Lists.newArrayList();
        if (meeting_notice.getData().get("meetingDepartmentRef") != null) {
            //部门信息
            List<SelectionValue> selectionValueDepartments = (List<SelectionValue>) meeting_notice.getData().get("meetingDepartmentRef");
            for (SelectionValue selectionValueDepartment : selectionValueDepartments) {
                List<UserModel> users = Lists.newArrayList();
                getAllUsersByDepartId(selectionValueDepartment.getId(), users);
                if (CollectionUtils.isNotEmpty(users)) {
                    selectionValues.addAll(users.stream().map(UserModel::getId).collect(Collectors.toList()));
                }
            }
        }
        if (meeting_notice.getData().get("meetingParticipantDetail") != null) {
            //人员信息
            List<SelectionValue> selectionValueList = (List<SelectionValue>) meeting_notice.getData().get("meetingParticipantDetail");
            if (CollectionUtils.isNotEmpty(selectionValueList)) {
                selectionValues.addAll(selectionValueList.stream().map(SelectionValue::getId).collect(Collectors.toList()));
            }
        }
        //获取子流程参会者
        if (StringUtils.isNotEmpty(meeting_notice.getWorkflowInstanceId())) {
            //获取子流程信息
            List<WorkflowInstanceModel> subWorkflowInstances = getWorkflowInstanceFacade().getWorkflowInstanceByParentId(meeting_notice.getWorkflowInstanceId());
            if (CollectionUtils.isNotEmpty(subWorkflowInstances)) {
                WorkflowInstanceModel workflowInstanceModel = subWorkflowInstances.get(0);
                //获取子流程信息
                BizObjectCreatedModel bizObjectCreatedModel = getBizObjectFacade().getBizObject(getUserId(), "meeting_notice", workflowInstanceModel.getBizObjectId());
                if (bizObjectCreatedModel != null && bizObjectCreatedModel.getData() != null) {
                    List<SelectionValue> selectionValueList = (List<SelectionValue>) bizObjectCreatedModel.getData().get("MeetingParticipants");
                    selectionValues.addAll(selectionValueList.stream().map(SelectionValue::getId).collect(Collectors.toList()));
                }
            }
        }
        return selectionValues;
    }

    /**
     * 校验是否可以签到
     */
    private boolean validateSiteAble(Page<BizObjectModel> data, BizObjectCreatedModel meeting_notice, Map<String, Object> map) {
        long kaishiqian = 0;
        long kaishihou = 0;
        if (data != null && CollectionUtils.isNotEmpty(data.getContent())) {
            kaishiqian = data.getContent().get(0).getData().get("meetingBefore") != null ? ((BigDecimal) data.getContent().get(0).getData().get("meetingBefore")).longValue() : 0;
            kaishihou = data.getContent().get(0).getData().get("meetingAfter").toString() != null ? ((BigDecimal) data.getContent().get(0).getData().get("meetingAfter")).longValue() : 0;
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //String meetingEndtime = meeting_notice.getData().get("meetingEndtime").toString();
        String mettingTime = meeting_notice.getData().get("mettingTime").toString();
        try {
            Date mettingDate = simpleDateFormat.parse(mettingTime);
            //Date meetingEndDate = simpleDateFormat.parse(meetingEndtime);
            if (((new Date()).getTime() - mettingDate.getTime()) / (1000 * 60) > kaishihou) {
                map.put("result", false);
                map.put("info", "已经过了签到时间");
                return false;
            }
            if ((mettingDate.getTime() - (new Date()).getTime()) / (1000 * 60) > kaishiqian) {
                map.put("result", false);
                map.put("info", "还未到签到时间");
                return false;
            }
        } catch (ParseException e) {
            log.warn(e.getMessage(), e);
        }
        return true;
    }


    /**
     * 处理未签到人员信息
     */
    private void resolveSignPersons(List<Map<String, Object>> mapList, BizObjectCreatedModel bizObjectCreatedModel) {
        List<SelectionValueVO> selectionValues = resolveNoticePersons(bizObjectCreatedModel);
        if (CollectionUtils.isEmpty(selectionValues)) {
            return;
        }
        List<String> ids = selectionValues.stream().map(SelectionValueVO::getId).collect(Collectors.toList());
        Map<String, List<SelectionValueVO>> stringListMap = selectionValues.stream().collect(Collectors.groupingBy(SelectionValueVO::getId));
        if (CollectionUtils.isNotEmpty(mapList)) {
            for (Map<String, Object> map : mapList) {
                if (CollectionUtils.isNotEmpty(ids) && ids.contains(map.get("userId").toString())) {
                    selectionValues.removeAll(stringListMap.get(map.get("userId").toString()));
                }
            }
        }
        for (SelectionValueVO selectionValue : selectionValues) {
            Map<String, Object> map = Maps.newHashMap();
            map.put("createdTime", null);
            map.put("name", selectionValue.getName());
            map.put("userId", selectionValue.getId());
            map.put("depart", selectionValue.getDepartName());
            map.put("isSign", false);
            mapList.add(map);
        }
    }


    /**
     * 通过会议id获取需要通知的人
     */
    @SuppressWarnings("unchecked")
    private List<SelectionValueVO> resolveNoticePersons(BizObjectCreatedModel meeting_notice) {
        List<SelectionValueVO> selectionValues = Lists.newArrayList();
        if (meeting_notice != null && meeting_notice.getData() != null) {
            if (meeting_notice.getData().get("meetingDepartmentRef") != null) {
                //部门信息
                List<SelectionValue> selectionValueDepartments = (List<SelectionValue>) meeting_notice.getData().get("meetingDepartmentRef");
                for (SelectionValue selectionValueDepartment : selectionValueDepartments) {
                    List<UserModel> users = Lists.newArrayList();
                    getAllUsersByDepartId(selectionValueDepartment.getId(), users);
                    //List<UserModel> users = getOrganizationFacade().getUsersByDeptId(selectionValueDepartment.getId());
                    for (UserModel userModel : users) {
                        SelectionValue selectionValue = new SelectionValue();
                        selectionValue.setId(userModel.getId());
                        selectionValue.setName(userModel.getName());
                        selectionValue.setType(userModel.getUnitType());
                        selectionValue.setImgUrl(userModel.getImgUrl());
                        SelectionValueVO selectionValueVO = new SelectionValueVO(selectionValue);
                        selectionValueVO.setDepartName(selectionValueDepartment.getName());
                        selectionValues.add(selectionValueVO);
                    }
                }
            }
            if (meeting_notice.getData().get("meetingParticipantDetail") != null) {
                //人员信息
                List<SelectionValueVO> selectionValueUsers = Lists.newArrayList();
                List<SelectionValue> selectionValueList = (List<SelectionValue>) meeting_notice.getData().get("meetingParticipantDetail");
                if (CollectionUtils.isNotEmpty(selectionValueList)) {
                    for (SelectionValue selectionValue : selectionValueList) {
                        selectionValueUsers.add(new SelectionValueVO(selectionValue));
                    }
                }
                if (CollectionUtils.isNotEmpty(selectionValueUsers)) {
                    selectionValueUsers.removeAll(Collections.singleton(null));
                }
                List<String> userIds = selectionValueUsers.stream().map(SelectionValueVO::getId).collect(Collectors.toList());
                Map<String, List<String>> departmentsByUserIds = getOrganizationFacade().getDepartmentsByUserIds(userIds);
                for (SelectionValueVO selectionValueUser : selectionValueUsers) {
                    selectionValueUser.setDepartName(departmentsByUserIds.get(selectionValueUser.getId()).get(0));
                }
                selectionValues.addAll(selectionValueUsers);
            }
            //获取子流程参会者
            if (StringUtils.isNotEmpty(meeting_notice.getWorkflowInstanceId())) {
                //获取子流程信息
                List<WorkflowInstanceModel> subWorkflowInstances = getWorkflowInstanceFacade().getWorkflowInstanceByParentId(meeting_notice.getWorkflowInstanceId());
                if (CollectionUtils.isNotEmpty(subWorkflowInstances)) {
                    WorkflowInstanceModel workflowInstanceModel = subWorkflowInstances.get(0);
                    if (!workflowInstanceModel.getState().equals(WorkflowInstanceStatus.COMPLETED) && !workflowInstanceModel.getState().equals(WorkflowInstanceStatus.CANCELED) && !workflowInstanceModel.getState().equals(WorkflowInstanceStatus.EXCEPTION)) {
                        return selectionValues;
                    }
                    //获取子流程信息
                    BizObjectCreatedModel bizObjectCreatedModel = getBizObjectFacade().getBizObject(getUserId(), "meeting_notice", workflowInstanceModel.getBizObjectId());
                    if (bizObjectCreatedModel != null && bizObjectCreatedModel.getData() != null) {
                        List<SelectionValue> selectionValueList = (List<SelectionValue>) bizObjectCreatedModel.getData().get("MeetingParticipants");
                        List<String> ids = selectionValueList.stream().map(SelectionValue::getId).collect(Collectors.toList());
                        Map<String, List<String>> departmentsByUserIds = getOrganizationFacade().getDepartmentsByUserIds(ids);
                        for (SelectionValue selectionValue : selectionValueList) {
                            SelectionValueVO selectionValueVO = new SelectionValueVO(selectionValue);
                            selectionValueVO.setDepartName(departmentsByUserIds.get(selectionValue.getId()).get(0));
                            selectionValues.add(selectionValueVO);
                        }
                    }
                }
            }
        }

        //去重
        selectionValues = selectionValues.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(
                () -> new TreeSet<>(Comparator.comparing(SelectionValueVO::getId))), ArrayList::new));
        return selectionValues;
    }

    /**
     * 获取部门下的所有人,递归方式
     */
    private void getAllUsersByDepartId(String id, List<UserModel> userModels) {
        List<UserModel> users = getOrganizationFacade().getUsersByDeptId(id);
        if (CollectionUtils.isNotEmpty(users)) {
            userModels.addAll(users);
        }
        List<DepartmentModel> departmentModels = getOrganizationFacade().getDepartmentsByParentId(id);
        if (CollectionUtils.isNotEmpty(departmentModels)) {
            for (DepartmentModel departmentModel : departmentModels) {
                getAllUsersByDepartId(departmentModel.getId(), userModels);
            }
        }
    }

    /**
     * 处理返回数据
     */
    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> resolveData(List<? extends BizObjectModel> rawData) {
        if (CollectionUtils.isNotEmpty(rawData)) {
            return rawData.stream().map(bizModel -> {
                        Map<String, Object> item = new HashMap<>();
                        item.put("createdTime", bizModel.get("createdTime"));
                        item.put("meetingId", bizModel.get("meetingId"));
                        item.put("name", ((List<SelectionValue>) bizModel.get(DefaultPropertyType.CREATER.getCode())).get(0).getName());
                        item.put("userId", ((List<SelectionValue>) bizModel.get(DefaultPropertyType.CREATER.getCode())).get(0).getId());
                        item.put("depart", ((List<SelectionValue>) bizModel.get(DefaultPropertyType.OWNER_DEPT_ID.getCode())).get(0).getName());
                        item.put("isSign", true);
                        return item;
                    }
            ).collect(Collectors.toList());
        } else {
            return Lists.newArrayList();
        }

    }

    /**
     * 生成普通查询条件
     */
    private FilterExpression resolveFilters(Map<String, Object> condition) {
        if (condition == null) {
            return FilterExpression.empty;
        }
        FilterExpression finalExpression = FilterExpression.empty;
        List<FilterExpression> filterExpressions = Lists.newArrayList();
        for (String key : condition.keySet()) {
            filterExpressions.add(Q.it(key, FilterExpression.Op.Eq, condition.get(key)));
        }
        if (filterExpressions.size() > 1) {
            finalExpression = Q.and(filterExpressions);
        }
        if (filterExpressions.size() == 1) {
            finalExpression = filterExpressions.get(0);
        }
        return finalExpression;
    }

    /**
     * 1.根据会议室id,会议室状态 MettingState 查询该时间段的会议室通知，
     * 2.当前会议室预约时间段，是否与存在预约的时间段存在交集
     */
    @ApiOperation(value = "会议室占用校验", notes = "检测该时间段会议室是否被占用")
    @ApiImplicitParam(name = "params", value = "{\"schemaCode\":\"业务模型编码\",\"meetingId\":\"会议室id\",\"mettingTime\":\"会议开始时间\",\"meetingEndtime\":\"会议结束时间\"}", required = true, dataType = "Map")
    @PostMapping(value = "/check")
    public ResponseResult check(@RequestBody Map<String, String> params) {
        String schemaCode = params.get("schemaCode");
        String meetingId = params.get("meetingId");
        String mettingTime = params.get("mettingTime");
        String meetingEndtime = params.get("meetingEndtime");
        validateNotEmpty(schemaCode, CODE_INVALID_MSG_26);
        validateNotEmpty(meetingId, "会议室id不能为空");
        validateNotEmpty(mettingTime, "会议开始时间不能为空");
        validateNotEmpty(meetingEndtime, "会议结束时间不能为空");
        Date meetingStartDate = null;
        Date meetingEndDate = null;
        String startTime = null;
        String endTime = null;
        try {
            meetingStartDate = DateUtils.parseDate(mettingTime, DATE_FORMAT_YYYYMMDD_HHMM);
            meetingEndDate = DateUtils.parseDate(meetingEndtime, DATE_FORMAT_YYYYMMDD_HHMM);
            startTime = (DateFormatUtils.format(meetingStartDate, DATE_FORMAT_YYYYMMDD)) + " 00:00:00";
            endTime = (DateFormatUtils.format(meetingEndDate, DATE_FORMAT_YYYYMMDD)) + " 23:59:59";
            if (meetingStartDate.getTime() - meetingEndDate.getTime() > 0) {
                throw new PortalException(ResultEnum.MEETING_START_TIME_FAIL.getErrCode(), ResultEnum.MEETING_START_TIME_FAIL.getErrMsg());
            }
            if ((new Date()).getTime() - meetingStartDate.getTime() > 0) {
                throw new PortalException(ResultEnum.MEETING_TIME_FAIL.getErrCode(), ResultEnum.MEETING_TIME_FAIL.getErrMsg());
            }
        } catch (ParseException e) {
            log.warn(e.getMessage(), e);
        }
        BizObjectQueryModel bizObjectQueryObject = new BizObjectQueryModel();
        PageableImpl pageable = new PageableImpl(0, 10);
        List<FilterExpression> filterExpressions = new ArrayList<>();
        FilterExpression filterExpr = FilterExpression.empty;
        if (!StringUtils.isEmpty(meetingId)) {
            FilterExpression filter = Q.it("meetingAddress", FilterExpression.Op.Eq, meetingId);
            filterExpressions.add(filter);
            FilterExpression filter1 = Q.it("MeetingState", FilterExpression.Op.Eq, 1);
            filterExpressions.add(filter1);
            FilterExpression filter2 = Q.it("mettingTime", FilterExpression.Op.Gte, startTime);
            filterExpressions.add(filter2);
            FilterExpression filter3 = Q.it("meetingEndtime", FilterExpression.Op.Lte, endTime);
            filterExpressions.add(filter3);
            if (filterExpressions.size() > 1) {
                filterExpr = Q.and(filterExpressions);
            }
            if (filterExpressions.size() == 0) {
                filterExpr = filterExpressions.get(0);
            }
            bizObjectQueryObject.setFilterExpr(filterExpr);
        }
        bizObjectQueryObject.setSchemaCode(schemaCode);
        bizObjectQueryObject.setQueryCode(schemaCode);
        bizObjectQueryObject.setPageable(pageable);
        Page<BizObjectModel> page = getBizObjectFacade().queryBizObjects(bizObjectQueryObject);
        List<? extends BizObjectModel> list = page.getContent();

        Map<String, String> resultMap = new HashMap<>();
        if (CollectionUtils.isNotEmpty(list)) {
            for (BizObjectModel bizObjectModel : list) {
                Map<String, Object> map = bizObjectModel.getData();
                try {
                    String startTime1 = map.get("mettingTime").toString().substring(0, 19);
                    String endTime1 = map.get("meetingEndtime").toString().substring(0, 19);
                    Date date1 = DateUtils.parseDate(startTime1, DATE_FORMAT_YYYYMMDD_HHMMSS);
                    Date date2 = DateUtils.parseDate(endTime1, DATE_FORMAT_YYYYMMDD_HHMMSS);
                    if (meetingEndDate.getTime() <= date1.getTime() || meetingStartDate.getTime() >= date2.getTime()) {
                        continue;
                    } else {//有交集
                        resultMap.put("mettingTime", startTime1);
                        resultMap.put("meetingEndtime", endTime1);
                        throw new PortalException(ResultEnum.MEETING_USE_OCCUPIED.getErrCode(), ResultEnum.MEETING_USE_OCCUPIED.getErrMsg(),
                                JSON.toJSONString(resultMap));
                    }
                } catch (ParseException e) {
                    log.warn(e.getMessage(), e);
                }
            }
        }

        return getOkResponseResult("会议室申请校验成功");
    }

    @ApiOperation(value = "获取会议人员确认情况", notes = "获取会议人员确认情况")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "workflowInstanceId", value = "流程实例id", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "activityCode", value = "活动节点编码", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "hasUserList", value = "是否指定参会名单", required = true, dataType = "Boolean", paramType = "query")
    })
    @GetMapping("/get_meeting_users_info")
    public ResponseResult<MeetingInfoVO> getMeetingUsersInfo(@RequestParam String workflowInstanceId,
                                                             @RequestParam String activityCode,
                                                             @RequestParam Boolean hasUserList) {
        String instanceId = null;
        String realActivityCode;
        if (hasUserList) {
            instanceId = workflowInstanceId;
            realActivityCode = activityCode;
        } else {
            //查询子流程
            List<WorkflowInstanceModel> instances = getWorkflowInstanceFacade().getWorkflowInstanceByParentId(workflowInstanceId);
            if (CollectionUtils.isNotEmpty(instances)) {
                instanceId = instances.get(0).getId();
            }
            List<WorkflowTokenModel> tokenModels = getWorkflowInstanceFacade().getWorkflowTokens(instanceId);
            List<WorkflowTokenModel> list = tokenModels.stream().filter(WorkflowTokenModel -> ActivityType.CIRCULATE.equals(WorkflowTokenModel.getActivityType())).collect(Collectors.toList());
            realActivityCode = list.get(0).getActivityCode();
        }
        //待阅任务
        List<CirculateItemModel> circulateWorkItems = getWorkflowInstanceFacade().getCirculateItems(instanceId, Boolean.FALSE);
        //已阅
        List<CirculateItemModel> finishedCirculateItems = getWorkflowInstanceFacade().getCirculateItems(instanceId, Boolean.TRUE);
        MeetingInfoVO meetingInfoVO = new MeetingInfoVO();
        Set<String> unconfirmedUsers = new HashSet<>();
        Set<String> confirmedUsers = new HashSet<>();
        List<MeetingUserVO> userVOList = new ArrayList<>();
        String finalRealActivityCode = realActivityCode;
        if (CollectionUtils.isNotEmpty(circulateWorkItems)) {
            unconfirmedUsers = circulateWorkItems.stream().filter(CirculateItemModel -> finalRealActivityCode.equals(CirculateItemModel.getActivityCode()))
                    .map(CirculateItemModel::getParticipant).collect(Collectors.toSet());
        }
        if (CollectionUtils.isNotEmpty(finishedCirculateItems)) {
            confirmedUsers = finishedCirculateItems.stream().filter(CirculateItemModel -> finalRealActivityCode.equals(CirculateItemModel.getActivityCode()))
                    .map(CirculateItemModel::getParticipant).collect(Collectors.toSet());
        }
        confirmedUsers.addAll(unconfirmedUsers);
        meetingInfoVO.setUnconfirmedNum(unconfirmedUsers.size());
        meetingInfoVO.setPlanNum(confirmedUsers.size());
        if (CollectionUtils.isNotEmpty(unconfirmedUsers)) {
            for (String userId : unconfirmedUsers) {
                UserModel user = getOrganizationFacade().getUser(userId);
                MeetingUserVO meetingUserVO = new MeetingUserVO(user);
                if (StringUtils.isNotBlank(meetingUserVO.getId())) {
                    userVOList.add(meetingUserVO);
                }
            }
        }
        meetingInfoVO.setUnconfirmedList(userVOList);

        return getOkResponseResult(meetingInfoVO, "获取会议人员确认情况成功");
    }
}
