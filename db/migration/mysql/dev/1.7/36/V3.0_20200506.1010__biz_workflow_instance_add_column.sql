ALTER TABLE `biz_workflow_instance` ADD COLUMN `schemaCode` varchar(40) DEFAULT NULL COMMENT '模型编码';

-- 冗余schemaCode
update biz_workflow_instance w SET w.schemaCode = (
SELECT t.schemaCode FROM h_workflow_header t WHERE w.workflowCode=t.workflowCode
);