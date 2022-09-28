ALTER TABLE biz_workflow_instance ADD (schemaCode varchar2(40) DEFAULT null);
comment on column biz_workflow_instance.schemaCode is '模型编码';

-- 冗余schemaCode
update biz_workflow_instance w set w.schemaCode = (select t.schemaCode from h_workflow_header t where w.workflowCode = t.workflowCode);

UPDATE h_biz_schema SET businessRuleEnable=1;

ALTER TABLE h_log_business_rule_header ADD (sourceFlowInstanceId varchar2(360) null);

ALTER TABLE h_log_business_rule_header ADD (repair number(1, 0) null);

ALTER TABLE h_log_business_rule_header ADD (extend varchar2(765) null);