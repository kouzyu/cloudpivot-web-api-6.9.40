alter table h_biz_property modify name varchar(200);


CREATE TABLE `biz_workflow_instance_bak` (
  `id` varchar(36) COLLATE utf8_bin NOT NULL,
  `finishTime` datetime DEFAULT NULL,
  `receiveTime` datetime DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `backupTime` datetime DEFAULT NULL COMMENT '备份时间',
  `appCode` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `bizObjectId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `departmentId` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `departmentName` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL,
  `instanceName` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL,
  `originator` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `originatorName` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL,
  `parentId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `remark` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `state` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `stateValue` int(11) DEFAULT NULL,
  `usedTime` bigint(20) DEFAULT NULL,
  `waitTime` bigint(20) DEFAULT NULL,
  `workflowCode` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `workflowTokenId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `workflowVersion` int(11) DEFAULT NULL,
  `sheetBizObjectId` varchar(36) COLLATE utf8_bin DEFAULT NULL COMMENT '主流程子表中的行数据关联id',
  `sheetSchemaCode` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '子表字段编码',
  `sequenceNo` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '单据号',
  `trustee` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人ID',
  `trusteeName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人名称',
  `trustType` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托类型，流程审批：APPROVAL；流程发起：START',
  `schemaCode` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '模型编码',
  `dataType` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL' COMMENT '数据类型，正常：NORMAL；模拟：SIMULATIVE',
  `runMode` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'MANUAL' COMMENT '运行模式，自动：AUTO；手动：MANUAL',
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_bwi_originator` (`originator`),
  KEY `idx_bwi_workflowCode` (`workflowCode`),
  KEY `idx_bwi_startTime` (`startTime`),
  KEY `idx_bwi_originator_state_starttime` (`originator`,`state`,`startTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `h_workflow_template_bak` (
  `id` varchar(120) COLLATE utf8_bin NOT NULL,
  `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `backupTime` datetime DEFAULT NULL COMMENT '备份时间',
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `activateEventHandler` longtext COLLATE utf8_bin,
  `cancelEventHandler` longtext COLLATE utf8_bin,
  `content` longtext COLLATE utf8_bin,
  `endEventHandler` longtext COLLATE utf8_bin,
  `startEventHandler` longtext COLLATE utf8_bin,
  `templateType` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `workflowCode` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `workflowVersion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_UNIQUE_CODE_VER_TYPE` (`workflowCode`,`workflowVersion`,`templateType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


alter table h_biz_perm_property modify name varchar(200);

alter table h_biz_query_column modify name varchar(200);

alter table h_biz_query_condition modify name varchar(200);

alter table h_biz_query_sorter modify name varchar(200);

alter table h_biz_property modify defaultValue varchar(1300);

ALTER TABLE `biz_workitem` ADD COLUMN `rootTaskId` varchar(42) DEFAULT NULL;
ALTER TABLE `biz_workitem` ADD COLUMN `sourceTaskId` varchar(42) DEFAULT NULL;

ALTER TABLE `biz_workitem_finished` ADD COLUMN `rootTaskId` varchar(42) DEFAULT NULL;
ALTER TABLE `biz_workitem_finished` ADD COLUMN `sourceTaskId` varchar(42) DEFAULT NULL;

ALTER TABLE `h_org_role_user`
ADD COLUMN `usScope`  longtext CHARACTER SET utf8 NULL COMMENT '管理范围（人员）';
