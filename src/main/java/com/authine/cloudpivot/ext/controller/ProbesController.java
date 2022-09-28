package com.authine.cloudpivot.ext.controller;

import com.authine.cloudpivot.engine.api.model.event.EventModel;
import com.authine.cloudpivot.engine.api.model.organization.UserModel;
import com.authine.cloudpivot.web.api.dubbo.DubboConfigService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/probes")
@Api(tags = "基础::运行状态探测API")
//TODO: 作为产品标准功能, 迁移到web-api-service//cloudpivot@pc-wz98w16445f58iyq6.mysql.polardb.rds.aliyuncs.com:3306【云枢6.0-测试】
public class ProbesController {

    @Autowired
    private DubboConfigService dubboConfigService; // 注入Engine服务

    @GetMapping("/voidTest")
    public void voidTest(String param1, String param2, String param3, String param4) {
    }

    @GetMapping("/webapiTest")
    public UserModel webapiTest(String param1, String param2, String param3, String param4) {
        return new UserModel();
    }

    @GetMapping("/webapi-engine-rpc-test-void")
    public void rpcTestVoid() {
        dubboConfigService.getEventFacade().test("null", new HashMap<>());
    }

    @GetMapping("/webapi-engine-rpc-test")
    public UserModel rpcTest() {
        dubboConfigService.getEventFacade().test("null", new HashMap<>());
        return new UserModel();
    }

    @GetMapping("/engine-find")
    public List<EventModel> engineFind(String clientId) {
        return dubboConfigService.getEventFacade().findAllEvent(clientId);
    }

    @PostMapping("/engine-insert")
    public void engineInsert(@RequestBody EventModel eventModel) {
        eventModel.setClientId(UUID.randomUUID().toString());
        dubboConfigService.getEventFacade().insertEvent(eventModel);
    }

    @PostMapping("/engine-update")
    public void engineUpdate(@RequestBody EventModel eventModel) {
        dubboConfigService.getEventFacade().updateEvent(eventModel);
    }
}
