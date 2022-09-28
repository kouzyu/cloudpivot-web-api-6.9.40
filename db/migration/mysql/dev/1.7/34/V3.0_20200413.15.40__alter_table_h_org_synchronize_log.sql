ALTER TABLE `h_org_synchronize_log` ADD COLUMN `corpId` varchar(120) DEFAULT NULL COMMENT '组织corpId';

ALTER TABLE `h_org_synchronize_log` ADD COLUMN `status` varchar(40) DEFAULT NULL COMMENT '状态';
