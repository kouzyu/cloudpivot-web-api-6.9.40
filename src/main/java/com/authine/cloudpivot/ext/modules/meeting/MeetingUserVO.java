package com.authine.cloudpivot.ext.modules.meeting;

import com.authine.cloudpivot.engine.api.model.organization.UserModel;
import com.authine.cloudpivot.engine.enums.type.UnitType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModelProperty;


public class MeetingUserVO {
    @JsonIgnore
    private UserModel model;

    private String id;

    private String name;

    @ApiModelProperty(value = "钉钉用户ID")
    private String userId;

    public MeetingUserVO(UserModel model) {
        this.model = model;
    }

    @ApiModelProperty(value = "用户ID")
    public String getId() {
        if (model != null) {
            return model.getId();
        }
        return id;
    }

    @ApiModelProperty(value = "用户头像")
    public String getImgUrl() {
        if (model != null) {
            return model.getImgUrl();
        }
        return null;
    }

    @ApiModelProperty(value = "用户姓名")
    public String getName() {
        if (model != null) {
            return model.getName();
        }
        return name;
    }

    @ApiModelProperty(value = "用户名")
    public String getUsername() {
        if (model != null) {
            return model.getUsername();
        }
        return null;
    }

    @ApiModelProperty(value = "钉钉用户Id")
    public String getUserId() {
        if (model != null) {
            return model.getUserId();
        }
        return null;
    }

    @ApiModelProperty(value = "组织对象类型", example = UnitType.DESCRIPTION)
    public UnitType getUnitType() {
        if (model != null) {
            return model.getUnitType();
        }
        return null;
    }
}
