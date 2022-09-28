ALTER TABLE `biz_workflow_instance` ADD `sheetBizObjectId` varchar(36) DEFAULT NULL COMMENT '主流程子表中的行数据关联id';
ALTER TABLE `biz_workflow_instance` ADD `sheetSchemaCode` varchar(64) DEFAULT NULL COMMENT '子表字段编码';

ALTER TABLE `h_biz_sheet` ADD COLUMN `shortCode` varchar(50) DEFAULT NULL COMMENT '表单外链短码';

INSERT IGNORE INTO `h_org_department` (`id`, `createdTime`, `creater`, `deleted`, `extend1`, `extend2`, `extend3`, `extend4`, `extend5`, `modifiedTime`, `modifier`, `remarks`, `calendarId`, `employees`, `leaf`, `managerId`, `name`, `parentId`, `sortKey`, `sourceId`, `queryCode`)
VALUES ('1803c80ed28a3e25871d58808019816e', '2019-03-22 11:25:05', NULL, b'0', '', '', NULL, NULL, NULL, '2019-05-14 13:44:21', NULL, NULL, NULL, NULL, b'0', '', '管理部门', 'fc57a56529ef4e089b5b23162f063ca9', '0', NULL, '');
UPDATE `h_org_user` SET `departmentId`='1803c80ed28a3e25871d58808019816e' WHERE `id`='2c9280a26706a73a016706a93ccf002b';
INSERT IGNORE INTO `h_org_dept_user` (`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `remarks`, `deptId`, `main`, `userId`)
VALUES ('a92a7856f16132c6a1884b08c3233236', '2019-03-22 11:25:07', NULL, b'0','2019-03-22 11:25:07', NULL, NULL, '1803c80ed28a3e25871d58808019816e', NULL, '2c9280a26706a73a016706a93ccf002b');

ALTER TABLE `h_biz_sheet` ADD COLUMN `printTemplateJson` varchar(1000) DEFAULT NULL COMMENT '关联的打印模板';
ALTER TABLE `h_biz_sheet` ADD COLUMN `qrCodeAble` VARCHAR(40) DEFAULT NULL COMMENT '是否开启二维码';

ALTER TABLE `h_im_work_record_history` MODIFY `taskId` varchar(42) DEFAULT NULL;

CREATE TABLE `h_biz_remind` (
  `id` varchar(120) COLLATE utf8_bin NOT NULL,
  `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `conditionType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `dateOption` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `dateType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `depIds` longtext COLLATE utf8_bin,
  `enabled` bit(1) DEFAULT NULL,
  `filterType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `intervalTime` int(11) DEFAULT NULL,
  `msgTemplate` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `remindType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `roleCondition` longtext COLLATE utf8_bin,
  `roleIds` longtext COLLATE utf8_bin,
  `schemaCode` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `sheetCode` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `userDataOptions` longtext COLLATE utf8_bin,
  `userIds` longtext COLLATE utf8_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表单消息提醒表';

ALTER TABLE h_biz_remind MODIFY  `msgTemplate` longtext DEFAULT NULL;