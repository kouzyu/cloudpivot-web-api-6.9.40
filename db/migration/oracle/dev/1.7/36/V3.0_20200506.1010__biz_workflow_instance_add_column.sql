ALTER TABLE biz_workflow_instance ADD (schemaCode varchar2(40) DEFAULT null);
comment on column biz_workflow_instance.schemaCode is '模型编码';

-- 冗余schemaCode
update biz_workflow_instance w set w.schemaCode = (select t.schemaCode from h_workflow_header t where w.workflowCode = t.workflowCode);