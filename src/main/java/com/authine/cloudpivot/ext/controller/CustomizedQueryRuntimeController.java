package com.authine.cloudpivot.ext.controller;

import com.authine.cloudpivot.engine.api.model.runtime.BizObjectModel;
import com.authine.cloudpivot.engine.component.query.api.Page;
import com.authine.cloudpivot.web.api.controller.runtime.QueryRuntimeController;
import com.authine.cloudpivot.web.api.handler.CustomizedOrigin;
import com.authine.cloudpivot.web.api.view.PageVO;
import com.authine.cloudpivot.web.api.view.ResponseResult;
import com.authine.cloudpivot.web.api.view.runtime.QueryDataVO;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;


/**
 * 定制列表查询功能Controller.
 */
@Api(tags = "运行时::列表::定制列表查询")
@RestController
@RequestMapping("/api/runtime/query")
@Slf4j
@CustomizedOrigin(level = 1)
public class CustomizedQueryRuntimeController extends QueryRuntimeController {

    /**
     * 列表查询方法
     * 如果需要定制查询方法，
     * 需要将QueryDataVO.customized设置为true
     * （即前端接口参数中将需要将QueryDataVO.customized设置为true）
     *
     * @param queryData 查询对象
     * @return page
     */
    @ApiOperation(value = "查询数据接口")
    @PostMapping("/list")
    @Override
    public ResponseResult<PageVO<BizObjectModel>> list(@RequestBody QueryDataVO queryData) {
        if (log.isDebugEnabled()) {
            log.debug("query list.customized = [{}]", queryData.isCustomized());
        }

        if (!queryData.isCustomized()) {         // 默认执行云枢产品列表查询方法
            return super.list(queryData);
        } else {                                 //二次开发定制列表查询
            return doCustomizedList(queryData);
        }
    }

    private ResponseResult<PageVO<BizObjectModel>> doCustomizedList(QueryDataVO queryData) {
        // TODO 二次开发定制列表查询
        // 如果需要定制列表查询方法，请在此处添加具体的实现
        // queryData.getSchemaCode() 数据模型编码
        // queryData.getQueryCode()  列表查询编码
        // 例： 自定义 模型编码schemaCode=test01, 列表查询编码queryCode=qu01 的查询方法
        // 则可以:
        if (log.isDebugEnabled()) {
            log.debug("二次开发代码.");
        }

        String schemaCode = "test01";
        String queryCode = "qu01";
        if (schemaCode.equals(queryData.getSchemaCode()) && queryCode.equals(queryData.getQueryCode())) {
            // TODO 自定义查询代码
            return null;
        } else {
            // TODO 其他自定义代码
            Page<BizObjectModel> data = new Page<BizObjectModel>() {
                @Override
                public long getTotal() {
                    return 0;
                }

                @Override
                public List<? extends BizObjectModel> getContent() {
                    return Lists.newArrayList();
                }

                @Override
                public Integer getSumLine() {
                    return 0;
                }

                @Override
                public void setSumLine(Integer sumLine) {
                }

                @Override
                public Map<String, Object> getSumMap() {
                    return Maps.newHashMap();
                }

                @Override
                public void setSumMap(Map<String, Object> sumMap) {
                }
            };
            return this.getOkResponseResult(new PageVO<>(data), "获取数据成功");
        }
    }
}
