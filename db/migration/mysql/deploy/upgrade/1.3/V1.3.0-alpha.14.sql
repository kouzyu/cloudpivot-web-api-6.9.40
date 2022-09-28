 -- ----------------------------
-- Table structure for biz_work_record
 -- ----------------------------
CREATE TABLE IF NOT EXISTS `h_im_work_record`(
`id` varchar(42) NOT NULL  ,
  `workitemId` varchar(64) DEFAULT NULL ,
  `recordId` varchar(80) DEFAULT NULL,
  `requestId` varchar(80) DEFAULT NULL,
  `receivers` longtext ,
  `title` varchar(100) DEFAULT NULL  ,
  `content` varchar(200) DEFAULT NULL  ,
  `url` varchar(500) DEFAULT NULL  ,
  `receiveTime` datetime DEFAULT NULL  ,
  `tryTimes` int(36) DEFAULT NULL ,
  `failRetry` varchar(200) DEFAULT NULL ,
  `messageType` varchar(200) DEFAULT NULL  ,
  `failUserRetry` bit(1) DEFAULT NULL,
  `WorkRecordStatus` varchar(40) NOT NULL ,
  `channel` varchar(40) DEFAULT NULL ,
  `bizParams` longtext ,
  `createdTime` datetime DEFAULT NULL  ,
  `modifiedTime` datetime DEFAULT NULL ,
  PRIMARY KEY (`id`),
  KEY `I_RecordId` (`recordId`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待办事项表';

-- ----------------------------
-- Table structure for biz_work_record_history
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_im_work_record_history`(
  `id` varchar(42) NOT NULL  ,
  `workitemId` varchar(64) DEFAULT NULL ,
  `recordId` varchar(80) DEFAULT NULL,
  `requestId` varchar(80) DEFAULT NULL,
  `receivers` longtext ,
  `title` varchar(100) DEFAULT NULL  ,
  `content` varchar(200) DEFAULT NULL  ,
  `url` varchar(500) DEFAULT NULL  ,
  `receiveTime` datetime DEFAULT NULL  ,
  `tryTimes` int(36) DEFAULT NULL ,
  `failRetry` varchar(200) DEFAULT NULL ,
  `messageType` varchar(200) DEFAULT NULL  ,
  `failUserRetry` bit(1) DEFAULT NULL,
  `WorkRecordStatus` varchar(40) NOT NULL,
  `status` varchar(40) DEFAULT NULL,
  `channel` varchar(40) DEFAULT NULL  ,
  `bizParams` longtext,
  `createdTime` datetime DEFAULT NULL  ,
  `modifiedTime` datetime DEFAULT NULL ,
  `taskId` varchar(42)  NULL COMMENT '待办事项历史任务id',
  PRIMARY KEY (`id`),
  KEY `I_RecordId` (`recordId`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待办事项历史纪录表';


CREATE TABLE `h_im_urge_task` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL,
  `instanceId` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '流程实例id',
  `text` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '催办内容',
  `userId` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '催办用户id',
  `opTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '催办时间',
  `urgeType` int(255) NOT NULL DEFAULT '0' COMMENT '催办类型，0：客户端ding消息；1：web端钉钉通知',
  `messageId` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '钉钉消息id',
  PRIMARY KEY (`id`),
  KEY `IDX_HASTEN_INST_USERID` (`instanceId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催办表';

CREATE TABLE `h_im_urge_workitem` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL,
  `workitemId` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '代办id',
  `userId` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '催办用户id',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '催办时间',
  `modifyTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `urgeCount` int(255) NOT NULL DEFAULT '1' COMMENT '催办次数',
  PRIMARY KEY (`id`),
  KEY `IDX_URGE_ITEMID_USERID` (`workitemId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催办代办表';

ALTER TABLE `base_security_client` MODIFY `registeredRedirectUris` varchar(2000) DEFAULT NULL;

ALTER TABLE `h_biz_sheet` ADD COLUMN `externalLinkAble` bit(1) DEFAULT 0 COMMENT '是否开启外链';

ALTER TABLE `h_app_function` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_app_package` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_sheet` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_property` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_query` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_query_action` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_query_column` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_query_condition` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_query_sorter` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_biz_schema` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_custom_page` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';
ALTER TABLE `h_workflow_header` ADD COLUMN `name_i18n` VARCHAR(1000) DEFAULT NULL COMMENT '双语言';

DROP TABLE IF EXISTS `h_biz_perm_group`;
CREATE TABLE `h_biz_perm_group` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `enabled` bit(1) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `name_i18n` varchar(1000) DEFAULT NULL,
  `roles` longtext,
  `schemaCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `h_biz_perm_property`;
CREATE TABLE `h_biz_perm_property` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `bizPermType` varchar(40) DEFAULT NULL,
  `groupId` varchar(40) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `name_i18n` varchar(1000) DEFAULT NULL,
  `propertyCode` varchar(40) DEFAULT NULL,
  `propertyType` varchar(40) DEFAULT NULL,
  `required` bit(1) DEFAULT NULL,
  `visible` bit(1) DEFAULT NULL,
  `writeAble` bit(1) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of h_biz_perm_property
-- ----------------------------



INSERT IGNORE INTO `h_org_user` (`id`, `createdTime`, `creater`, `deleted`, `extend1`, `extend2`, `extend3`, `extend4`, `extend5`, `modifiedTime`, `modifier`, `remarks`, `active`, `admin`, `appellation`, `birthday`, `boss`, `departmentId`, `departureDate`, `dingtalkId`, `email`, `employeeNo`, `employeeRank`, `entryDate`, `gender`, `identityNo`, `imgUrl`, `leader`, `managerId`, `mobile`, `name`, `officePhone`, `password`, `username`, `privacyLevel`, `secretaryId`, `sortKey`, `sourceId`, `status`, `userId`)
VALUES ('2ccf3b346706a6d3016706dc51c0022b', '2019-06-05 19:30:30', NULL, b'0', NULL, NULL, NULL, NULL, NULL, '2019-06-05 19:30:30', NULL, NULL, b'1', b'1', NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', NULL, NULL, 'xuser', NULL, '{bcrypt}$2a$10$NvgvcocBqMn050z4nC0I6OeAhO5ERjM74pvMtSGLghPhWI5ed5myG', 'xuser', NULL, NULL, NULL, NULL, NULL, NULL);

ALTER TABLE `h_biz_sheet` ADD COLUMN `draftHtmlJson` longtext DEFAULT NULL COMMENT '草稿在线设计与编辑json';
ALTER TABLE `h_biz_sheet` ADD COLUMN `publishedHtmlJson` longtext DEFAULT NULL COMMENT '发布在线设计与编辑json';
ALTER TABLE `h_biz_sheet` ADD COLUMN `draftActionsJson` longtext DEFAULT NULL COMMENT '草稿在线设计与编辑按钮json';
ALTER TABLE `h_biz_sheet` ADD COLUMN `publishedActionsJson` longtext DEFAULT NULL COMMENT '发布在线设计与编辑j按钮json';

INSERT IGNORE INTO `h_org_department` (`id`, `createdTime`, `creater`, `deleted`, `extend1`, `extend2`, `extend3`, `extend4`, `extend5`, `modifiedTime`, `modifier`, `remarks`, `calendarId`, `employees`, `leaf`, `managerId`, `name`, `parentId`, `sortKey`, `sourceId`, `queryCode`)
VALUES ('06ef8c9a3f3b6669a34036a3001e6340', '2019-03-22 11:25:05', NULL, b'0', '', '', NULL, NULL, NULL, '2019-05-14 13:44:21', NULL, NULL, NULL, NULL, b'0', '', '外部', NULL, '0', NULL, '');

UPDATE `h_org_user` SET `departmentId`='06ef8c9a3f3b6669a34036a3001e6340' WHERE `id`='2ccf3b346706a6d3016706dc51c0022b';

INSERT IGNORE INTO `h_org_dept_user` (`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `remarks`, `deptId`, `main`, `userId`)
VALUES ('07df8b34e4469a00169a36a336450cf3', '2019-03-22 11:25:07', NULL, b'0','2019-03-22 11:25:07', NULL, NULL, '06ef8c9a3f3b6669a34036a3001e6340', NULL, '2ccf3b346706a6d3016706dc51c0022b');

ALTER TABLE `h_biz_perm_property` ADD COLUMN `schemaCode` VARCHAR(40) DEFAULT NULL COMMENT '模型编码';

UPDATE `h_org_department` SET `parentId`='06ef8c9a3f3b6669a34036a3001e63401' WHERE `id`='06ef8c9a3f3b6669a34036a3001e6340';

INSERT IGNORE INTO `base_security_client` (`id`,  `deleted`, `accessTokenValiditySeconds`, `additionInformation`, `authorities`, `authorizedGrantTypes`, `autoApproveScopes`, `clientId`, `clientSecret`, `refreshTokenValiditySeconds`, `registeredRedirectUris`, `resourceIds`, `scopes`, `type`)
VALUES ('52ed17238a5da59e71a8aa26447d0c05', b'0', '3600', 'API', 'openapi', 'client_credentials', 'read,write', 'xclient', '{noop}0a417ecce58c31b32364ce19ca8fcd15', '3600', '', 'api', 'read,write', 'APP');


UPDATE `h_org_user` SET `name`='外部用户' WHERE `id`='2ccf3b346706a6d3016706dc51c0022b';

