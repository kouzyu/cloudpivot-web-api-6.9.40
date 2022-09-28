ALTER TABLE biz_workflow_instance ADD (dataType varchar2(20) DEFAULT 'NORMAL' NOT NULL);
comment on column biz_workflow_instance.dataType is '数据类型，正常：NORMAL；模拟：SIMULATIVE';
ALTER TABLE biz_workflow_instance ADD (runMode varchar2(20) DEFAULT 'MANUAL' NOT NULL);
comment on column biz_workflow_instance.runMode is '运行模式，自动：AUTO；手动：MANUAL';

ALTER TABLE biz_workflow_token ADD (isSkipped number(1, 0) DEFAULT NULL);
comment on column biz_workflow_token.isSkipped is '是否直接跳过';
