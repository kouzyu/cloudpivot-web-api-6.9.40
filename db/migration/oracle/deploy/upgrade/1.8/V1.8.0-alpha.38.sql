ALTER TABLE h_biz_service ADD (shared number(1, 0) DEFAULT null);
ALTER TABLE h_biz_service ADD (userIds clob DEFAULT null);
comment on column h_biz_service.shared is '是否共享，0-私有，1共享';
comment on column h_biz_service.userIds is '用戶id，多個用戶用逗號隔開';

ALTER TABLE biz_workflow_instance ADD (dataType varchar2(20) DEFAULT 'NORMAL' NOT NULL);
comment on column biz_workflow_instance.dataType is '数据类型，正常：NORMAL；模拟：SIMULATIVE';
ALTER TABLE biz_workflow_instance ADD (runMode varchar2(20) DEFAULT 'MANUAL' NOT NULL);
comment on column biz_workflow_instance.runMode is '运行模式，自动：AUTO；手动：MANUAL';

ALTER TABLE biz_workflow_token ADD (isSkipped number(1, 0) DEFAULT NULL);
comment on column biz_workflow_token.isSkipped is '是否直接跳过';

ALTER TABLE h_biz_property ADD (relativeQuoteCode clob DEFAULT NULL);
comment on column h_biz_property.relativeQuoteCode is '关联表单引用属性';
