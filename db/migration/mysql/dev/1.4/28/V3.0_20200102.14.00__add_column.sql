ALTER TABLE `h_biz_rule` ADD COLUMN `triggerSchemaCodeIsGroup` bit(1) DEFAULT 0 COMMENT '主表加子表数据项';

ALTER TABLE `h_biz_sheet`
MODIFY COLUMN `shortCode`  varchar(50) BINARY CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '表单外链短码';
