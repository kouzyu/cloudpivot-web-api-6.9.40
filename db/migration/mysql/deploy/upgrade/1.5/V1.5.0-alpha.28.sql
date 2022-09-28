ALTER TABLE `h_biz_perm_group` ADD COLUMN `departments` longtext COMMENT '部门范围';
ALTER TABLE `h_biz_perm_group` ADD COLUMN `authorType` varchar(40) DEFAULT null COMMENT '授权类型';

ALTER TABLE `h_biz_rule` ADD COLUMN `triggerSchemaCodeIsGroup` bit(1) DEFAULT 0 COMMENT '主表加子表数据项';

ALTER TABLE `h_biz_sheet`
    MODIFY COLUMN `shortCode`  varchar(50) BINARY CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '表单外链短码';

ALTER TABLE `biz_workflow_instance` ADD COLUMN `sequenceNo` varchar(200) DEFAULT null COMMENT '单据号';