ALTER TABLE `h_org_department` MODIFY COLUMN `queryCode` VARCHAR(255);

ALTER TABLE `biz_workitem` ADD COLUMN `batchOperate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许批量处理，0：否；1：是';

ALTER TABLE `biz_workitem_finished` ADD COLUMN `batchOperate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许批量处理，0：否；1：是';

ALTER TABLE `h_workflow_header` ADD COLUMN `visibleType` varchar(40) NOT NULL DEFAULT 'PART_VISIABLE'
COMMENT '流程可见范围类型，ALL_VISIABLE: 全部人员可见， PART_VISIABLE：部分可见';

ALTER TABLE `h_biz_database_pool`
ADD COLUMN `driverClassName` varchar(50) NULL AFTER `databaseType`;