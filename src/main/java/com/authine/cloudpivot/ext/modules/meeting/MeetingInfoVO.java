package com.authine.cloudpivot.ext.modules.meeting;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;


@Getter
@Setter
@ApiModel(value = "会议信息")
public class MeetingInfoVO {

    @ApiModelProperty("计划参会人数")
    private Integer planNum;

    @ApiModelProperty("未确认人数")
    private Integer unconfirmedNum;

    @ApiModelProperty("未确认人")
    List<MeetingUserVO> unconfirmedList;

}
