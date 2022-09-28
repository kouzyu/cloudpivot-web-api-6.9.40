package com.authine.cloudpivot.ext.modules.meeting;

import com.authine.cloudpivot.engine.api.model.runtime.SelectionValue;
import com.authine.cloudpivot.engine.enums.type.UnitType;

public class SelectionValueVO {
    private SelectionValue selectionValue;
    private String departName;

    public String getName() {
        return selectionValue.getName();
    }

    public String getId() {
        return selectionValue.getId();
    }

    public String getImgUrl() {
        return selectionValue.getImgUrl();
    }

    public UnitType getType() {
        return selectionValue.getType();
    }

    public String getDepartName() {
        return departName;
    }


    public SelectionValueVO(SelectionValue selectionValue) {
        this.selectionValue = selectionValue;
    }


    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public SelectionValue getSelectionValue() {
        return selectionValue;
    }

    public void setSelectionValue(SelectionValue selectionValue) {
        this.selectionValue = selectionValue;
    }
}
