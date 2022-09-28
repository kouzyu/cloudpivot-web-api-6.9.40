package com.authine.cloudpivot.ext.modules.airack;

import com.alibaba.fastjson.JSON;
import com.authine.cloudpivot.engine.api.facade.FileStoreFacade;
import com.authine.cloudpivot.engine.api.model.organization.UserModel;
import com.authine.cloudpivot.engine.api.model.runtime.*;
import com.authine.cloudpivot.engine.component.query.api.FilterExpression;
import com.authine.cloudpivot.engine.component.query.api.Page;
import com.authine.cloudpivot.engine.component.query.api.helper.PageableImpl;
import com.authine.cloudpivot.engine.component.query.api.helper.Q;
import com.authine.cloudpivot.engine.enums.ErrCode;
import com.authine.cloudpivot.engine.enums.status.SequenceStatus;
import com.authine.cloudpivot.engine.enums.type.BizObjectStatusType;
import com.authine.cloudpivot.web.api.controller.base.BaseController;
import com.authine.cloudpivot.web.api.exception.PortalException;
import com.authine.cloudpivot.web.api.exception.ResultEnum;
import com.authine.cloudpivot.web.api.view.PageVO;
import com.authine.cloudpivot.web.api.view.ResponseResult;
import com.google.common.base.Strings;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.visual.VisualOpenClient;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;


@Api(tags = "示例模块::AI智能货架")
@RestController
@RequestMapping("/api/airack")
@Slf4j
public class AIRackController extends BaseController {

    private static final String APP_ID = "100579";//开发者在开放平台上面注册应用生成的appid
    private static final String AK = "Zc29vs9gXEfGseL-QxTQsgNeIkBMbJEXN99kHh9oKoY";//创建应用成功后生成的AK
    private static final String SK = "Q5hJnpoLi7440FQjVnMZ9kKriy2HUuYi-jnxTVxq3-A";//创建应用成功后生成的SK
    private static final String APIURL = "http://open-ai.alibaba.com/api/image/v2/shelvesrecognize-mutiunified";

//    @Autowired
//    private OSSClient ossClient;
    @Autowired
    private FileStoreFacade fileStoreFacade;

    @Autowired
    private RedisTemplate<String, AttachmentModel> redisTemplate;


    @PostMapping(value = "/upload")
    @ResponseBody
    @ApiOperation(value = "OSS文件上传接口")
    public ResponseResult<String> upload(@RequestParam MultipartFile file) throws NoSuchAlgorithmException, InvalidKeyException, KeyManagementException {
        String fileName = file.getOriginalFilename();
        try {
            if (!Strings.isNullOrEmpty(fileName)) {
                log.debug(fileName);
                File newFile = new File(fileName);
                FileOutputStream os = FileUtils.openOutputStream(newFile);
                os.write(file.getBytes());
                os.close();
                file.transferTo(newFile);
                // 上传到OSS
                String refId = UUID.randomUUID().toString().replace("-", "");
                fileStoreFacade.fileUpload(refId, new FileInputStream(newFile));
                String url = fileStoreFacade.buildDownloadUrl(refId, System.currentTimeMillis() + 12 * 60 * 60 * 1000);
                JSONObject alibabaResult = parsingPicByAlibaba(Lists.newArrayList(url));
                JSONArray aiArray = getAIJson(alibabaResult);
                alibabaResult.put("aiArray", aiArray);
                String returnStr = alibabaResult.toString();

                return getOkResponseResult(returnStr, "阿里巴巴解析图片成功");
            }
        } catch (IOException e) {
            log.warn(e.getMessage(), e);
            throw new PortalException(ResultEnum.OSS_UPLOAD_ERR.getErrCode(), ResultEnum.OSS_UPLOAD_ERR.getErrMsg());
        }catch (Exception e){
            log.warn(e.getMessage(), e);
        }
        throw new PortalException(ResultEnum.OSS_UPLOAD_ERR.getErrCode(), ResultEnum.OSS_UPLOAD_ERR.getErrMsg());
    }

    @PostMapping(value = "/write_alibaba_data")
    @ResponseBody
    public ResponseResult<String> writeAlibabaData() {
        try {
            log.debug("invoke after upload photo");
            BizObjectQueryModel bizObjectQueryObject = new BizObjectQueryModel();
            PageableImpl pageable = new PageableImpl(0, 9999);
            bizObjectQueryObject.setPageable(pageable);
            bizObjectQueryObject.setSchemaCode("Ai_Shelf_");
            bizObjectQueryObject.setQueryCode("Ai_Shelf_");
            Page<BizObjectModel> data = getBizObjectFacade().queryBizObjects(bizObjectQueryObject);
            if (log.isDebugEnabled()) {
                log.debug("queryBizObjects = {}", JSON.toJSONString(data));
            }

            List<? extends BizObjectModel> models = data.getContent();
            BizObjectModel bo = models.get(0);
            if (log.isDebugEnabled()) {
                log.debug("bizObject id = {}", bo.getId());
                log.debug("bo = {}", JSON.toJSONString(bo));
            }
            String userId = getUserId();
            if (StringUtils.isEmpty(userId)) {
                userId = "2c9280b9692e2ff5016933cf5bbb0086";
            }
            String schemaCode = bo.getSchemaCode();
            if (StringUtils.isEmpty(schemaCode)) {
                schemaCode = "Ai_Shelf_";
            }
            BizObjectCreatedModel bcm = getBizObjectFacade().getBizObject(userId, schemaCode, bo.getId());
            if (log.isDebugEnabled()) {
                log.debug("bo ..bcm = {}", JSON.toJSONString(bcm));
            }
            Object attachObj = bcm.get("Attachment1552554243476");
            if (log.isDebugEnabled()) {
                log.debug("bo ..attachObj = {}", JSON.toJSONString(attachObj));
            }
            if (attachObj == null || CollectionUtils.isEmpty(((List) attachObj))) {
                log.debug("attachment id null..");
                return getErrResponseResult(bo.getId(), ErrCode.UNKNOW_ERROR.getErrCode(), "没有附件信息");
            } else {
                if (log.isDebugEnabled()) {
                    log.debug("attachment = {}", JSON.toJSONString(bcm.get("Attachment1552554243476")));
                }
                List<Map<String, Object>> childDataList = Lists.newArrayList();
                List<Map<String, String>> attachList = (List) attachObj;
                for (Map<String, String> map : attachList) {
                    if (log.isDebugEnabled()) {
                        log.debug("attach map = {}", JSON.toJSONString(map));
                    }
                    if (map == null) {
                        return getErrResponseResult(bo.getId(), ErrCode.UNKNOW_ERROR.getErrCode(), "没有附件信息");
                    }
                    String refId = map.get("refId");
                    String id = map.get("id");
                    log.debug("attacht id = {}, attacht refId = {}", id, refId);
                    String url = fileStoreFacade.buildDownloadUrl(refId, System.currentTimeMillis() + 12 * 60 * 60 * 1000);
                    log.debug("oss url = {}", url);

                    JSONObject alibabaResult = parsingPicByAlibaba(Lists.newArrayList(url));
                    log.debug("from a li data = {}", alibabaResult);
                    childDataList.addAll(getChildData(alibabaResult, bo.getId()));
                }
                long totalCountNumber = 0;//计算产品总数量
                for (Map<String, Object> map : childDataList) {
                    Object object = map.get("Number1552554328796");
                    if (object != null) {
                        totalCountNumber += Long.parseLong(map.get("Number1552554328796").toString());
                    }
                }
                Map<Object, List<Map<String, Object>>> childMap = childDataList.stream().collect(Collectors.toMap(
                        t -> t.get("RelevanceForm1552555176955"),
                        it -> {
                            List<Map<String, Object>> productNames = Lists.newArrayList();
                            productNames.add(it);
                            return productNames;
                        },
                        (List<Map<String, Object>> value1, List<Map<String, Object>> value2) -> {
                            value1.addAll(value2);
                            return value1;
                        }));

                childDataList.clear();

                DecimalFormat df = new DecimalFormat("0.00");
                for (Map.Entry<Object, List<Map<String, Object>>> entry : childMap.entrySet()) {
                    List<Map<String, Object>> valueList = entry.getValue();
                    Map<String, Object> firstData = valueList.get(0);
                    long number = 0;
                    float price = 0;
                    Map<String, Object> dataMap = Maps.newHashMap();
                    for (Map<String, Object> valueMap : valueList) {
                        number += valueMap.get("Number1552554328796") == null ? 0 : Long.parseLong(valueMap.get("Number1552554328796").toString());
                        price += valueMap.get("Number1552554318972") == null ? 0 : Float.parseFloat(valueMap.get("Number1552554318972").toString());
                    }
                    dataMap.put("Number1552554328796", number);
                    dataMap.put("Number1552554321909", df.format((float) number / totalCountNumber * 100));//计算占比
                    dataMap.put("Number1552554318972", price);
                    dataMap.put("RelevanceForm1552554312492", firstData.get("RelevanceForm1552554312492"));
                    dataMap.put("RelevanceForm1552555176955", firstData.get("RelevanceForm1552555176955"));
                    dataMap.put("ShortText1552554315453", firstData.get("ShortText1552554315453"));
                    dataMap.put("parentId", firstData.get("parentId"));
                    childDataList.add(dataMap);
                }
                bo.getData().put("Sheet1552554246532", childDataList);
                getBizObjectFacade().saveBizObject(getUserId(), bo, Boolean.TRUE);
            }
            log.debug("write success...");

            return getOkResponseResult(bo.getId(), "阿里巴巴解析图片完毕");
        } catch (Exception e) {
            log.error("write data error.", e);
            throw new PortalException(ResultEnum.OSS_UPLOAD_ERR.getErrCode(), ResultEnum.OSS_UPLOAD_ERR.getErrMsg());
        }
    }

    public static JSONObject parsingPicByAlibaba(List<String> list) throws KeyManagementException, NoSuchAlgorithmException, InvalidKeyException, IOException {
        JSONObject parsingPic = new JSONObject();
        parsingPic.put("image_urls", list);
        JSONObject result = VisualOpenClient.SendHttpRequest(APIURL, parsingPic);
        log.debug("url. send http = {}", result);

        return result;
    }

    private List<Map<String, Object>> getChildData(JSONObject alibabaResult, String objectId) {
        log.debug("get child data.");
        JSONArray alibabaData = alibabaResult.getJSONArray("data");
        log.debug("alibaba data = {}", alibabaData);
        List<String> jsonList = Lists.newArrayList();
        long countNum = alibabaData.length();
        for (int i = 0; i < countNum; i++) {
            JSONObject alibaba = (JSONObject) alibabaData.get(i);
            jsonList.add(alibaba.getString("barCode"));
        }
        Map<String, Long> map = jsonList.stream().collect(Collectors.groupingBy(String::toString, Collectors.counting()));
        List<Map<String, Object>> childList = Lists.newArrayList();
        map.keySet().forEach(barCode -> {
            long barCodeNum = map.get(barCode);
            log.debug("barCodeNum = {}", barCodeNum);
            Map<String, Object> data = Maps.newHashMap();
            List<? extends BizObjectModel> bizObjectModels = getContextByBarCode(barCode);
            if (!CollectionUtils.isEmpty(bizObjectModels)) {
                Map<String, Object> dm = bizObjectModels.get(0).getData();
                data.put("RelevanceForm1552554312492", dm.get("id"));
                data.put("RelevanceForm1552555176955", dm.get("id"));
                data.put("ShortText1552554315453", dm.get("ShortText1551667049885"));
                data.put("Number1552554318972", dm.get("Number1551669517343"));
            } else {
                data.put("RelevanceForm1552554312492", null);
                data.put("RelevanceForm1552555176955", null);
                data.put("ShortText1552554315453", null);
                data.put("Number1552554318972", null);
            }
            data.put("Number1552554328796", barCodeNum);
            data.put("parentId", objectId);
            childList.add(data);
        });

        return childList;
    }

    private JSONArray getAIJson(JSONObject alibabaResult) {
        JSONArray alibabaData = alibabaResult.getJSONArray("data");
        List<String> jsonList = Lists.newArrayList();
        long countNum = alibabaData.length();
        for (int i = 0; i < countNum; i++) {
            JSONObject alibaba = (JSONObject) alibabaData.get(i);
            jsonList.add(alibaba.getString("barCode"));
        }
        Map<String, Long> map = jsonList.stream().
                collect(Collectors.groupingBy(String::toString, Collectors.counting()));
        JSONArray returnArray = new JSONArray();
        String id = UUID.randomUUID().toString().replaceAll("-", "");
        map.keySet().forEach(barCode -> {
            long barCodeNum = map.get(barCode);
            DecimalFormat df = new DecimalFormat("0.00");//格式化小数
            String proportion = df.format((float) barCodeNum / countNum * 100);//返回的是String类型
            JSONObject returnJson = new JSONObject();
            returnJson.put("barCode", barCode);
            returnJson.put("barCodeNum", barCodeNum);
            returnJson.put("barCodeProportion", proportion);
            Map<String, Object> data = Maps.newHashMap();
            List<? extends BizObjectModel> bizObjectModels = getContextByBarCode(barCode);
            if (!CollectionUtils.isEmpty(bizObjectModels)) {
                returnJson.put("productName", bizObjectModels.get(0).getData().get("ShortText1551665947321"));
                returnJson.put("productType", bizObjectModels.get(0).getData().get("ShortText1551667049885"));
                returnJson.put("objectId", bizObjectModels.get(0).getData().get("id"));

                data.put("RelevanceForm1552554312492", returnJson.get("objectId"));
                data.put("ShortText1552554315453", returnJson.get("productType"));
                data.put("Number1552554318972", bizObjectModels.get(0).getData().get("Number1551669517343"));
            }
            data.put("Number1552554328796", returnJson.get("barCodeNum"));
            data.put("Number1552554321909", returnJson.get("barCodeProportion"));
            data.put("parentId", id);

            List<Map<String, Object>> childList = Lists.newArrayList();
            childList.add(data);
            Map<String, Object> mainData = Maps.newHashMap();
            mainData.put("Sheet1552554246532", childList);
            mainData.put("id", id);
            BizObjectModel bo = new BizObjectModel("Ai_Shelf_", mainData, false);
            bo.setStatus(BizObjectStatusType.NEW);
            bo.setFormCode("Ai_Shelf_");
            getBizObjectFacade().saveBizObject(getUserId(), bo, Boolean.TRUE);
        });

        return returnArray;
    }

    List<? extends BizObjectModel> getContextByBarCode(String barCode) {
        BizObjectQueryModel bizObjectQueryObject = new BizObjectQueryModel();
        PageableImpl pageable = new PageableImpl(0, 99999);
        FilterExpression filterExpression = Q.it("ShortText1551669493124", FilterExpression.Op.Eq, barCode);
        bizObjectQueryObject.setPageable(pageable);
        bizObjectQueryObject.setSchemaCode("D000004");
        bizObjectQueryObject.setQueryCode("D000004");
        bizObjectQueryObject.setFilterExpr(filterExpression);

        Page<BizObjectModel> data = getBizObjectFacade().queryBizObjects(bizObjectQueryObject);

        return data.getContent();
    }

    @ApiOperation(value = "查询终端位置信息", notes = "查询终端位置信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "area1", value = "省份名称", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "area2", value = "市名称", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "area3", value = "区(县)名称", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "pointName", value = "终端名称", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "bisnessOwner", value = "业务负责人", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "pointType", value = "终端类型", dataType = "String", paramType = "query")
    })
    @GetMapping("/search_point_infos")
    @SuppressWarnings({"unchecked", "raw"})
    public ResponseResult<List<Map<String, Object>>> searchPointInfos(@NotBlank(message = "省份名称不能为空") @RequestParam String area1,
                                                                      @NotBlank(message = "市名称不能为空") @RequestParam String area2,
                                                                      @NotBlank(message = "区(县)名称不能为空") @RequestParam String area3,
                                                                      @RequestParam(required = false) String pointName,
                                                                      @RequestParam(required = false) String bisnessOwner,
                                                                      @RequestParam(required = false) String pointType) {
        BizObjectQueryModel bizObjectQuery = new BizObjectQueryModel();
        PageableImpl pageable = new PageableImpl(0, Integer.MAX_VALUE);
        bizObjectQuery.setPageable(pageable);
        bizObjectQuery.setSchemaCode("Point");
        bizObjectQuery.setQueryCode("Point");
        List<FilterExpression> filterExpressions = Lists.newArrayList();
        if (StringUtils.isNotEmpty(area1) && StringUtils.isNotEmpty(area2) && StringUtils.isNotEmpty(area3)) { // 必须选到区（县）才能查询

            // 查询对应的位置id
            BizObjectQueryModel addressBizObjectQuery = new BizObjectQueryModel();
            PageableImpl addressPageable = new PageableImpl(0, 10);
            addressBizObjectQuery.setPageable(addressPageable);
            addressBizObjectQuery.setSchemaCode("address");
            addressBizObjectQuery.setQueryCode("address");
            List<String> addressTexts = Lists.newArrayList(area1, area2, area3);
            FilterExpression addressFilterExpr = Q.it("name", FilterExpression.Op.In, addressTexts);
            addressBizObjectQuery.setFilterExpr(addressFilterExpr);
            Page<BizObjectModel> addressPages = getBizObjectFacade().queryBizObjects(addressBizObjectQuery);
            List<? extends BizObjectModel> addressContents = addressPages.getContent();
            if (CollectionUtils.isEmpty(addressContents)) {
                if (log.isDebugEnabled()) {
                    log.debug("位置信息不全...");
                }
                return getOkResponseResult(null, "查询终端位置信息成功");
            } else if (addressContents.size() < 3) { // 期望查询出三条位置信息数据,对应省市区
                if (log.isDebugEnabled()) {
                    log.debug("位置信息不足3条...");
                }
                return getOkResponseResult(null, "查询终端位置信息成功");
            }
            for (BizObjectModel addressContent : addressContents) {
                if (!addressTexts.contains(addressContent.getString("name"))) {
                    if (log.isDebugEnabled()) {
                        log.debug("位置信息名称不在查询范围内...");
                    }
                    return getOkResponseResult(null, "查询终端位置信息成功");
                }
                if (Objects.equals(area1, addressContent.getString("name"))) {
                    filterExpressions.add(Q.it("area1", FilterExpression.Op.Eq, addressContent.getId()));
                } else if (Objects.equals(area2, addressContent.getString("name"))) {
                    filterExpressions.add(Q.it("area2", FilterExpression.Op.Eq, addressContent.getId()));
                } else if (Objects.equals(area3, addressContent.getString("name"))) {
                    filterExpressions.add(Q.it("area3", FilterExpression.Op.Eq, addressContent.getId()));
                }
            }
        }
        if (StringUtils.isNotEmpty(pointName)) {
            FilterExpression pointNameFilter = Q.it("PointName", FilterExpression.Op.Like, pointName);
            filterExpressions.add(pointNameFilter);
        }

        if (StringUtils.isNotEmpty(pointType)) {
            FilterExpression pointTypeFilter = Q.it("PointType", FilterExpression.Op.Eq, pointType);
            filterExpressions.add(pointTypeFilter);
        }
        FilterExpression filterExpr = Q.and(filterExpressions);
        bizObjectQuery.setFilterExpr(filterExpr);
        Page<BizObjectModel> pages = getBizObjectFacade().queryBizObjects(bizObjectQuery);
        List<? extends BizObjectModel> contents = pages.getContent();
        if (CollectionUtils.isEmpty(contents)) {
            return getOkResponseResult(null, "查询终端位置信息成功");
        }
        List<String> userNames = Lists.newArrayList();
        if (StringUtils.isNotEmpty(bisnessOwner)) {
            org.springframework.data.domain.Page<UserModel> userPage = getOrganizationFacade().searchUsersByName(bisnessOwner, PageRequest.of(0, Integer.MAX_VALUE));
            List<UserModel> userList = userPage.getContent();
            if (CollectionUtils.isEmpty(userList)) {
                if (log.isDebugEnabled()) {
                    log.debug("查询不到业务负责人数据...");
                }
                return getOkResponseResult(null, "查询终端位置信息成功");
            }
            userNames = userList.stream().map(UserModel::getName).filter(name -> name.contains(bisnessOwner)).collect(Collectors.toList());
        }
        List<Map<String, Object>> pointInfos = Lists.newArrayList();
        for (BizObjectModel bizObject : contents) {
            if (log.isDebugEnabled()) {
                log.debug("bizObject = {}", JSON.toJSONString(bizObject));
            }
            if (StringUtils.isEmpty(bisnessOwner)) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("PointName", bizObject.getString("PointName"));
                map.put("PointOwner", bizObject.getString("PointOwner"));
                map.put("PointAddress", bizObject.getString("PointAddress"));
                map.put("BisnessOwner", bizObject.get("BisnessOwner"));
                map.put("ShortText1552545297255", bizObject.getString("ShortText1552545297255"));
                pointInfos.add(map);
            } else if (StringUtils.isNotEmpty(bisnessOwner)) {
                List<SelectionValue> bisnessOwners = (List<SelectionValue>) bizObject.get("BisnessOwner");
                if (CollectionUtils.isEmpty(bisnessOwners)) {
                    continue;
                }
                for (SelectionValue s : bisnessOwners) {
                    if (userNames.contains(s.getName())) {
                        Map<String, Object> map = Maps.newHashMap();
                        map.put("PointName", bizObject.getString("PointName"));
                        map.put("PointOwner", bizObject.getString("PointOwner"));
                        map.put("PointAddress", bizObject.getString("PointAddress"));
                        map.put("BisnessOwner", bizObject.get("BisnessOwner"));
                        map.put("ShortText1552545297255", bizObject.getString("ShortText1552545297255"));
                        pointInfos.add(map);
                    }
                }
            }
        }

        return getOkResponseResult(pointInfos, "查询终端位置信息成功");
    }

    @ApiOperation(value = "最新一次巡店数据", notes = "最新一次巡店数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "产品名称", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "attribute", value = "产品属性", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "pointType", value = "终端类型", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "pointName", value = "终端名称", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "page", value = "当前页码", dataType = "Integer", paramType = "query"),
            @ApiImplicitParam(name = "size", value = "每页显示数量", dataType = "Integer", paramType = "query")
    })
    @GetMapping("/search_product_infos")
    @SuppressWarnings({"unchecked", "raw"})
    public ResponseResult<PageVO<Map<String, Object>>> searchProductInfos(String name, String attribute, String pointType, String pointName, Integer page, Integer size) {
        final String userId = getUserId();
        // 数字货架
        BizObjectQueryModel aiShelfQuery = new BizObjectQueryModel();
        aiShelfQuery.setPageable(new PageableImpl(0, Integer.MAX_VALUE));
        aiShelfQuery.setSchemaCode("Ai_Shelf_");
        aiShelfQuery.setQueryCode("Ai_Shelf_");
        FilterExpression sequenceStatusFilter = Q.it("sequenceStatus", FilterExpression.Op.Eq, SequenceStatus.COMPLETED.toString());
        aiShelfQuery.setFilterExpr(sequenceStatusFilter);
        Page<BizObjectModel> aiShelfPages = getBizObjectFacade().queryBizObjects(aiShelfQuery);
        List<? extends BizObjectModel> aiShelfContents = aiShelfPages.getContent();
        if (CollectionUtils.isEmpty(aiShelfContents)) {
            log.debug("Ai_Shelf 数据为空...");
            return getOkResponseResult(new PageVO<>(org.springframework.data.domain.Page.empty()), "查询最后一次拜访记录明细成功");
        }
        aiShelfContents = aiShelfContents.stream().sorted(Comparator.comparing(BizObjectModel::getModifiedTime).reversed()).collect(Collectors.toList());
        // 产品信息
        BizObjectQueryModel productQuery = new BizObjectQueryModel();
        productQuery.setPageable(new PageableImpl(0, Integer.MAX_VALUE));
        productQuery.setSchemaCode("D000004");
        productQuery.setQueryCode("D000004");
        List<FilterExpression> proudctFilterExpressions = Lists.newArrayList();
        FilterExpression productFilterExpr = FilterExpression.empty;
        if (StringUtils.isNotEmpty(name)) { // 产品名称
            FilterExpression nameFilter = Q.it("name", FilterExpression.Op.Like, name);
            proudctFilterExpressions.add(nameFilter);
        }
        if (StringUtils.isNotEmpty(attribute)) { // 产品属性
            FilterExpression attributeFilter = Q.it("ShortText1551671098235", FilterExpression.Op.Eq, attribute);
            proudctFilterExpressions.add(attributeFilter);
        }
        if (CollectionUtils.isNotEmpty(proudctFilterExpressions)) {
            if (proudctFilterExpressions.size() > 1) {
                productFilterExpr = Q.and(proudctFilterExpressions);
            } else if (proudctFilterExpressions.size() == 1) {
                productFilterExpr = proudctFilterExpressions.get(0);
            }
            productQuery.setFilterExpr(productFilterExpr);
        }

        Page<BizObjectModel> productPages = getBizObjectFacade().queryBizObjects(productQuery);
        List<? extends BizObjectModel> productContents = productPages.getContent();
        if (CollectionUtils.isEmpty(productContents)) {
            log.debug("product数据为空...");
            return getOkResponseResult(new PageVO<>(org.springframework.data.domain.Page.empty()), "查询最后一次拜访记录明细成功");
        }
        Map<String, BizObjectModel> productContentsMap = ((List<BizObjectModel>) productContents).stream().collect(Collectors.toMap(BizObjectModel::getId, Function.identity()));
        // 终端信息
        BizObjectQueryModel pointQuery = new BizObjectQueryModel();
        pointQuery.setPageable(new PageableImpl(0, Integer.MAX_VALUE));
        pointQuery.setSchemaCode("Point");
        pointQuery.setQueryCode("Point");
        List<FilterExpression> pointiFlterExpressions = Lists.newArrayList();
        FilterExpression pointFilterExpr = FilterExpression.empty;
        if (StringUtils.isNotEmpty(pointType)) { // 终端类型
            FilterExpression pointTypeFilter = Q.it("PointType", FilterExpression.Op.Eq, pointType);
            pointiFlterExpressions.add(pointTypeFilter);
        }
        if (StringUtils.isNotEmpty(pointName)) { // 终端名称
            FilterExpression pointNameFilter = Q.it("name", FilterExpression.Op.Like, pointName);
            pointiFlterExpressions.add(pointNameFilter);
        }
        if (CollectionUtils.isNotEmpty(pointiFlterExpressions)) {
            if (pointiFlterExpressions.size() > 1) {
                pointFilterExpr = Q.and(pointiFlterExpressions);
            } else if (pointiFlterExpressions.size() == 1) {
                pointFilterExpr = pointiFlterExpressions.get(0);

            }
            pointQuery.setFilterExpr(pointFilterExpr);
        }
        Page<BizObjectModel> pointData = getBizObjectFacade().queryBizObjects(pointQuery);
        List<? extends BizObjectModel> pointContents = pointData.getContent();
        Map<String, BizObjectModel> pointContentsMap = CollectionUtils.isEmpty(pointContents) ? null : ((List<BizObjectModel>) pointContents).stream().collect(Collectors.toMap(BizObjectModel::getId, Function.identity()));
        // 子表数据
        log.debug("开始进行子表数据处理....");
        List<Map<String, Object>> result = Lists.newArrayList();
        for (BizObjectModel aiShelf : aiShelfContents) {
            Object relPoint = aiShelf.get("RelevanceForm1552554228116"); // 关联的终端
            BizObjectModel point = null;
            if (relPoint instanceof Map) {
                Map<String, String> relPointMap = (Map<String, String>) relPoint;
                String relPointId = relPointMap.get("id");
                if (CollectionUtils.isNotEmpty(pointContents) && StringUtils.isNotEmpty(relPointId)) {
                    point = pointContentsMap.get(relPointId);
                }
            }
            BizObjectCreatedModel productBizObjectCreated = getBizObjectFacade().getBizObject(userId, "Ai_Shelf_", aiShelf.getId());
            Object subData = productBizObjectCreated.get("Sheet1552554246532"); // 子表编码

            if (subData instanceof ArrayList) {
                List<Map> subDataLists = (List<Map>) subData;
                if (CollectionUtils.isEmpty(subDataLists)) {
                    continue;
                }
                for (Map subDataMap : subDataLists) {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("bizObjectId", subDataMap.get("id"));
                    map.put("parentId", aiShelf.getId());
                    Object relevanceForm = subDataMap.get("RelevanceForm1552555176955");
                    BizObjectModel product = null;
                    if (relevanceForm instanceof Map) {
                        Map<String, String> relevanceFormMap = (Map<String, String>) relevanceForm;
                        final String relevanceFormId = relevanceFormMap.get("id");
                        product = StringUtils.isEmpty(relevanceFormId) ? null : productContentsMap.get(relevanceFormId);
                    }
                    if (product == null && (StringUtils.isNotEmpty(name) || StringUtils.isNotEmpty(attribute))) {
                        // 如果在产品相关的条件查询下，查询不到产品信息，则过滤掉该条子表数据
                        continue;
                    }
                    if (point == null && (StringUtils.isNotEmpty(pointName) || StringUtils.isNotEmpty(pointType))) {
                        // 如果在终端相关的条件查询下，查询不到终端信息，则过滤掉该条子表数据
                        continue;
                    }
                    map.put("name", product != null ? product.getString("name") : null); // 产品名称
                    map.put("attribute", product != null ? product.getString("ShortText1551671098235") : null);// 产品属性
                    map.put("pointName", point == null ? null : point.getString("name"));
                    map.put("pointType", point == null ? null : point.getString("PointType"));
                    map.put("amount", subDataMap.get("Number1552554328796")); // 陈列数量
                    result.add(map);
                }
            }
            // 只处理对应最新的修改时间的货架数据
            break;
        }
        // 对过滤后的列表数据进行分页返回
        log.debug("分页处理....");
        page = (page == null) ? 0 : page;
        size = (size == null) ? Integer.MAX_VALUE : size;
        Pageable pageable = PageRequest.of(page, size);
        if (CollectionUtils.isNotEmpty(result)) {
            int count = result.size();
            int fromIndex = page * size;
            int toIndex = (page + 1) * size;
            if (toIndex > count) {
                toIndex = count;
            }
            List<Map<String, Object>> pageList = result.subList(fromIndex, toIndex);
            org.springframework.data.domain.Page<Map<String, Object>> r = new PageImpl<>(pageList, pageable, count);
            return getOkResponseResult(new PageVO<>(r), "查询最后一次拜访记录明细成功");
        }

        return getOkResponseResult(new PageVO<>(org.springframework.data.domain.Page.empty()), "查询最后一次拜访记录明细成功");
    }
}
