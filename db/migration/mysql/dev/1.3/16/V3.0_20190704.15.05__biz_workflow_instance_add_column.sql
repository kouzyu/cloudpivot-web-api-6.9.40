ALTER TABLE `biz_workflow_instance` ADD `sheetBizObjectId` varchar(36) DEFAULT NULL COMMENT '主流程子表中的行数据关联id';
ALTER TABLE `biz_workflow_instance` ADD `sheetSchemaCode` varchar(64) DEFAULT NULL COMMENT '子表字段编码';
