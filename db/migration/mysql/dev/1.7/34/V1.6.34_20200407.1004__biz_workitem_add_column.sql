ALTER TABLE `biz_workitem` ADD COLUMN `isTrust` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托，0：否；1：是';
ALTER TABLE `biz_workitem` ADD COLUMN `trustor` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人ID';
ALTER TABLE `biz_workitem` ADD COLUMN `trustorName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人名称';

ALTER TABLE `biz_workitem_finished` ADD COLUMN `isTrust` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托，0：否；1：是';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `trustor` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人ID';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `trustorName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人名称';

ALTER TABLE `biz_workflow_instance` ADD COLUMN `isTrustStart` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托发起，0：否；1：是';
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trustee` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人ID';
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trusteeName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人名称';