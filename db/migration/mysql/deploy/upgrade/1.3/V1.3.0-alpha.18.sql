ALTER TABLE `h_perm_biz_function` ADD COLUMN `printAble` BIT(1) DEFAULT NULL COMMENT '是否打印';

update h_biz_property t set t.propertyType = 'SHORT_TEXT' where t.code = 'id' and t.propertyType = 'WORK_SHEET';

ALTER TABLE `h_timer_job` ADD COLUMN `taskId` VARCHAR(120) DEFAULT NULL COMMENT '任务id';
ALTER TABLE `h_job_result` ADD COLUMN `taskId` VARCHAR(120) DEFAULT NULL COMMENT '任务id';


CREATE TABLE `h_org_department_history` (
  `id` varchar(120) COLLATE utf8_bin NOT NULL,
  `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `extend1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `extend2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `extend3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `calendarId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `employees` int(11) DEFAULT NULL,
  `leaf` bit(1) DEFAULT NULL,
  `managerId` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `queryCode` varchar(512) COLLATE utf8_bin DEFAULT NULL,
  `sortKey` bigint(20) DEFAULT NULL,
  `sourceId` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `targetParentId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `targetQueryCode` varchar(512) COLLATE utf8_bin DEFAULT NULL,
  `changeTime` datetime DEFAULT NULL,
  `version` int(10) DEFAULT NULL,
  `changeAction` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_hist_source_id` (`sourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
