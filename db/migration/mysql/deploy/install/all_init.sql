-- 初始化1.3版本
CREATE TABLE IF NOT EXISTS `base_security_client` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `extend1` varchar(255) DEFAULT NULL,
  `extend2` varchar(255) DEFAULT NULL,
  `extend3` varchar(255) DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `accessTokenValiditySeconds` int(11) NOT NULL,
  `additionInformation` varchar(255) DEFAULT NULL,
  `authorities` varchar(255) DEFAULT NULL,
  `authorizedGrantTypes` varchar(255) DEFAULT NULL,
  `autoApproveScopes` varchar(255) DEFAULT NULL,
  `clientId` varchar(100) DEFAULT NULL,
  `clientSecret` varchar(100) DEFAULT NULL,
  `refreshTokenValiditySeconds` int(11) NOT NULL,
  `registeredRedirectUris` varchar(255) DEFAULT NULL,
  `resourceIds` varchar(255) DEFAULT NULL,
  `scopes` varchar(255) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for biz_circulateitem
-- ----------------------------
CREATE TABLE IF NOT EXISTS `biz_circulateitem` (
  `id` varchar(36) NOT NULL,
  `finishTime` datetime DEFAULT NULL,
  `receiveTime` datetime DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `activityCode` varchar(200) DEFAULT NULL,
  `activityCodeName` varchar(200) DEFAULT NULL,
  `instanceId` varchar(36) DEFAULT NULL,
  `instanceName` varchar(200) DEFAULT NULL,
  `originator` varchar(200) DEFAULT NULL,
  `originatorName` varchar(200) DEFAULT NULL,
  `participant` varchar(200) DEFAULT NULL,
  `participantName` varchar(200) DEFAULT NULL,
  `sheetCode` varchar(200) DEFAULT NULL,
  `sourceId` varchar(200) DEFAULT NULL,
  `sourceName` varchar(200) DEFAULT NULL,
  `workflowCode` varchar(36) DEFAULT NULL,
  `workflowVersion` int(11) DEFAULT NULL,
  `activityName` varchar(200) DEFAULT NULL,
  `departmentId` varchar(200) DEFAULT NULL,
  `departmentName` varchar(200) DEFAULT NULL,
  `workItemType` varchar(20) DEFAULT NULL,
  `workflowTokenId` varchar(200) DEFAULT NULL,
  `stateValue` int(11) DEFAULT NULL,
  `workItemTypeValue` int(11) DEFAULT NULL,
  `expireTime1` datetime DEFAULT NULL,
  `expireTime2` datetime DEFAULT NULL,
  `appCode` varchar(200) DEFAULT NULL,
  `allowedTime` datetime DEFAULT NULL,
  `timeoutWarn1` datetime DEFAULT NULL,
  `timeoutWarn2` datetime DEFAULT NULL,
  `timeoutStrategy` varchar(20) DEFAULT NULL,
  `usedtime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_multi` (`instanceId`,`activityCode`,`workflowTokenId`,`participant`),
  KEY `idx_workflowTokenId` (`workflowTokenId`),
  KEY `idx_sourceIdAndType` (`sourceId`,`workItemType`),
  KEY `idx_participant` (`participant`),
  KEY `idx_startTime` (`startTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for biz_circulateitem_finished
-- ----------------------------
CREATE TABLE IF NOT EXISTS `biz_circulateitem_finished` (
  `finishTime` datetime DEFAULT NULL,
  `receiveTime` datetime DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `activityCode` varchar(200) DEFAULT NULL,
  `delegant` varchar(200) DEFAULT NULL,
  `instanceId` varchar(36) DEFAULT NULL,
  `originator` varchar(200) DEFAULT NULL,
  `participant` varchar(200) DEFAULT NULL,
  `sheetCode` varchar(200) DEFAULT NULL,
  `sourceWorkItemId` varchar(200) DEFAULT NULL,
  `workflowCode` varchar(36) DEFAULT NULL,
  `workflowVersion` int(11) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `activityName` varchar(200) DEFAULT NULL,
  `departmentId` varchar(200) DEFAULT NULL,
  `departmentName` varchar(200) DEFAULT NULL,
  `instanceName` varchar(200) DEFAULT NULL,
  `originatorName` varchar(200) DEFAULT NULL,
  `participantName` varchar(200) DEFAULT NULL,
  `sourceId` varchar(200) DEFAULT NULL,
  `sourceName` varchar(200) DEFAULT NULL,
  `workItemType` varchar(20) DEFAULT NULL,
  `workflowTokenId` varchar(200) DEFAULT NULL,
  `stateValue` int(11) DEFAULT NULL,
  `workItemTypeValue` int(11) DEFAULT NULL,
  `expireTime1` datetime DEFAULT NULL,
  `expireTime2` datetime DEFAULT NULL,
  `appCode` varchar(200) DEFAULT NULL,
  `allowedTime` datetime DEFAULT NULL,
  `timeoutWarn1` datetime DEFAULT NULL,
  `timeoutWarn2` datetime DEFAULT NULL,
  `timeoutStrategy` varchar(20) DEFAULT NULL,
  `usedtime` bigint(20) DEFAULT NULL,
  KEY `idx_multi` (`instanceId`,`activityCode`,`workflowTokenId`,`participant`),
  KEY `idx_workflowTokenId` (`workflowTokenId`),
  KEY `idx_sourceIdAndType` (`sourceId`,`workItemType`),
  KEY `idx_participant` (`participant`),
  KEY `idx_finishTime` (`finishTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for biz_workflow_instance
-- ----------------------------
CREATE TABLE IF NOT EXISTS `biz_workflow_instance` (
  `id` varchar(36) NOT NULL COMMENT '流程实例表ID',
  `bizObjectId` varchar(36) DEFAULT NULL COMMENT '业务类ID',
  `instanceName` varchar(200) DEFAULT NULL COMMENT '流程实例名称',
  `workflowCode` varchar(200) DEFAULT NULL COMMENT '流程模板编码',
  `workflowVersion` int(11) DEFAULT NULL COMMENT '流程模板版本号',
  `originator` varchar(200) DEFAULT NULL COMMENT '发起人',
  `departmentId` varchar(200) DEFAULT NULL COMMENT '发起人所在的部门',
  `participant` varchar(200) DEFAULT NULL COMMENT '任务参与人',
  `state` varchar(200) DEFAULT NULL COMMENT '流程实例状态',
  `receiveTime` datetime DEFAULT NULL COMMENT '工作任务接收时间',
  `startTime` datetime DEFAULT NULL COMMENT '工作任务开始时间',
  `finishTime` datetime DEFAULT NULL COMMENT '工作任务完成时间',
  `usedTime` bigint(20) DEFAULT NULL COMMENT '工作任务耗时(自然时间)',
  `waitTime` bigint(20) DEFAULT NULL COMMENT '等待时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `departmentName` varchar(200) DEFAULT NULL,
  `originatorName` varchar(200) DEFAULT NULL,
  `parentId` varchar(36) DEFAULT NULL,
  `stateValue` int(11) DEFAULT NULL,
  `workflowTokenId` varchar(36) DEFAULT NULL,
  `appCode` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_bwi_originator` (`originator`),
  KEY `idx_bwi_workflowCode` (`workflowCode`),
  KEY `idx_bwi_startTime` (`startTime`),
  KEY `idx_bwi_originator_state_starttime` (`originator`,`state`,`startTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程实例表';

-- ----------------------------
-- Table structure for biz_workflow_token
-- ----------------------------
CREATE TABLE IF NOT EXISTS `biz_workflow_token` (
  `id` varchar(36) NOT NULL,
  `finishTime` datetime DEFAULT NULL,
  `receiveTime` datetime DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `activityCode` varchar(200) DEFAULT NULL,
  `approvalCount` int(11) DEFAULT NULL,
  `disapprovalCount` int(11) DEFAULT NULL,
  `exceptional` varchar(20) DEFAULT NULL,
  `instanceId` varchar(36) DEFAULT NULL,
  `itemCount` int(11) DEFAULT NULL,
  `tokenId` int(11) DEFAULT NULL,
  `usedtime` bigint(20) DEFAULT NULL,
  `sourceActivityCode` varchar(200) DEFAULT NULL,
  `isRetrievable` int(11) DEFAULT NULL,
  `stateValue` int(11) DEFAULT NULL,
  `parentId` varchar(36) DEFAULT NULL,
  `isRejectBack` varchar(10) DEFAULT NULL,
  `activityType` varchar(20) DEFAULT NULL,
  `instanceState` varchar(20) DEFAULT NULL,
  `approvalExit` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_instanceId` (`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for biz_workitem
-- ----------------------------
CREATE TABLE IF NOT EXISTS `biz_workitem` (
  `id` varchar(36) NOT NULL COMMENT '待办表id',
  `workflowCode` varchar(200) DEFAULT NULL COMMENT '流程模板编码',
  `workflowVersion` int(11) DEFAULT NULL COMMENT '流程模板版本',
  `originator` varchar(200) DEFAULT NULL COMMENT '流程实例发起人',
  `participant` varchar(200) DEFAULT NULL COMMENT '参与者',
  `approval` varchar(200) DEFAULT NULL COMMENT '当前工作任务审批结果',
  `sheetCode` varchar(200) DEFAULT NULL COMMENT '表单编码',
  `instanceId` varchar(36) DEFAULT NULL COMMENT '流程实例ID',
  `startTime` datetime DEFAULT NULL COMMENT '流程开始时间',
  `finishTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '流程结束时间',
  `state` varchar(36) DEFAULT NULL COMMENT '工作任务状态',
  `receiveTime` datetime DEFAULT NULL COMMENT '处理时间',
  `activityCode` varchar(200) DEFAULT NULL COMMENT '活动节点编码',
  `usedTime` bigint(20) DEFAULT NULL COMMENT '工作任务耗时(自然时间)',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `ownerId` varchar(200) DEFAULT '' COMMENT '接收人',
  `activityName` varchar(200) DEFAULT NULL,
  `departmentId` varchar(200) DEFAULT NULL,
  `departmentName` varchar(200) DEFAULT NULL,
  `instanceName` varchar(200) DEFAULT NULL,
  `originatorName` varchar(200) DEFAULT NULL,
  `participantName` varchar(200) DEFAULT NULL,
  `sourceId` varchar(200) DEFAULT NULL,
  `sourceName` varchar(200) DEFAULT NULL,
  `workItemType` varchar(20) DEFAULT NULL,
  `workflowTokenId` varchar(200) DEFAULT NULL,
  `stateValue` int(11) DEFAULT NULL,
  `workItemTypeValue` int(11) DEFAULT NULL,
  `approvalValue` int(11) DEFAULT NULL,
  `expireTime1` datetime DEFAULT NULL,
  `expireTime2` datetime DEFAULT NULL,
  `appCode` varchar(200) DEFAULT NULL,
  `allowedTime` datetime DEFAULT NULL,
  `timeoutWarn1` datetime DEFAULT NULL,
  `timeoutWarn2` datetime DEFAULT NULL,
  `timeoutStrategy` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_ReceiveTime` (`receiveTime`),
  KEY `idx_multi` (`instanceId`,`activityCode`,`workflowTokenId`,`participant`),
  KEY `idx_workflowTokenId` (`workflowTokenId`),
  KEY `idx_sourceIdAndType` (`sourceId`,`workItemType`),
  KEY `idx_participant` (`participant`),
  KEY `idx_startTime` (`startTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待办任务表';

-- ----------------------------
-- Table structure for biz_workitem_finished
-- ----------------------------
CREATE TABLE IF NOT EXISTS `biz_workitem_finished` (
  `id` varchar(36) NOT NULL COMMENT '已办表id',
  `workflowCode` varchar(200) DEFAULT NULL COMMENT '流程模板编码',
  `workflowVersion` int(11) DEFAULT NULL COMMENT '流程模板版本',
  `originator` varchar(200) DEFAULT NULL COMMENT '流程实例发起人',
  `participant` varchar(200) DEFAULT NULL COMMENT '参与者',
  `approval` varchar(200) DEFAULT NULL COMMENT '当前工作任务审批结果',
  `sheetCode` varchar(200) DEFAULT NULL COMMENT '表单编码',
  `instanceId` varchar(36) DEFAULT NULL COMMENT '流程实例ID',
  `startTime` datetime DEFAULT NULL COMMENT '流程开始时间',
  `finishTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '流程结束时间',
  `state` varchar(36) DEFAULT NULL COMMENT '工作任务状态',
  `receiveTime` datetime DEFAULT NULL COMMENT '处理时间',
  `activityCode` varchar(200) DEFAULT NULL COMMENT '活动节点编码',
  `usedTime` bigint(20) DEFAULT NULL COMMENT '工作任务耗时(自然时间)',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `ownerId` varchar(200) DEFAULT '' COMMENT '接收人',
  `activityName` varchar(200) DEFAULT NULL,
  `departmentId` varchar(200) DEFAULT NULL,
  `departmentName` varchar(200) DEFAULT NULL,
  `instanceName` varchar(200) DEFAULT NULL,
  `originatorName` varchar(200) DEFAULT NULL,
  `participantName` varchar(200) DEFAULT NULL,
  `sourceId` varchar(200) DEFAULT NULL,
  `sourceName` varchar(200) DEFAULT NULL,
  `workItemType` varchar(20) DEFAULT NULL,
  `workflowTokenId` varchar(200) DEFAULT NULL,
  `stateValue` int(11) DEFAULT NULL,
  `workItemTypeValue` int(11) DEFAULT NULL,
  `approvalValue` int(11) DEFAULT NULL,
  `expireTime1` datetime DEFAULT NULL,
  `expireTime2` datetime DEFAULT NULL,
  `appCode` varchar(200) DEFAULT NULL,
  `allowedTime` datetime DEFAULT NULL,
  `timeoutWarn1` datetime DEFAULT NULL,
  `timeoutWarn2` datetime DEFAULT NULL,
  `timeoutStrategy` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_ReceiveTime` (`receiveTime`),
  KEY `idx_multi` (`instanceId`,`activityCode`,`workflowTokenId`,`participant`),
  KEY `idx_workflowTokenId` (`workflowTokenId`),
  KEY `idx_sourceIdAndType` (`sourceId`,`workItemType`),
  KEY `idx_participant` (`participant`),
  KEY `idx_finishTime` (`finishTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已办任务表';

-- ----------------------------
-- Table structure for h_app_function
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_app_function` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `appCode` varchar(40) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `parentId` varchar(36) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_hs5vdc0sdojwxfkv685ch9bqb` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_app_package
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_app_package` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `disabled` bit(1) DEFAULT NULL,
  `logoUrlId` varchar(36) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `published` bit(1) DEFAULT NULL,
  `agentId` varchar(40) DEFAULT NULL,
  `logoUrl` varchar(200) DEFAULT NULL,
  `appKey` varchar(200) DEFAULT NULL,
  `appSecret` varchar(200) DEFAULT NULL,
  `enabled` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_attachment
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_attachment` (
  `id` varchar(120) NOT NULL,
  `bizObjectId` varchar(36) NOT NULL,
  `bizPropertyCode` varchar(40) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(36) DEFAULT NULL,
  `fileExtension` varchar(30) DEFAULT NULL,
  `fileSize` int(11) DEFAULT NULL,
  `mimeType` varchar(50) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `parentBizObjectId` varchar(36) DEFAULT NULL,
  `parentSchemaCode` varchar(36) DEFAULT NULL,
  `refId` varchar(500) NOT NULL,
  `schemaCode` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_biz_attachment_schema_object_property` (`schemaCode`,`bizObjectId`,`bizPropertyCode`,`createdTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_comment
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_comment` (
  `id` varchar(120) NOT NULL,
  `actionType` varchar(40) NOT NULL,
  `activityCode` varchar(40) DEFAULT NULL,
  `activityName` varchar(40) DEFAULT NULL,
  `bizObjectId` varchar(36) NOT NULL,
  `bizPropertyCode` varchar(40) DEFAULT NULL,
  `content` varchar(4000) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(36) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `relUsers` varchar(2000) DEFAULT NULL,
  `result` varchar(40) DEFAULT NULL,
  `schemaCode` varchar(40) NOT NULL,
  `workItemId` varchar(36) NOT NULL,
  `workflowInstanceId` varchar(36) NOT NULL,
  `workflowTokenId` varchar(36) NOT NULL,
  `tokenId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_biz_comment_workflowInstanceId` (`workflowInstanceId`),
  KEY `idx_biz_comment_workItemId_actionType` (`workItemId`,`actionType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_method
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_method` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `defaultMethod` bit(1) DEFAULT NULL,
  `description` longtext,
  `methodType` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_method_mapping
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_method_mapping` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `bizMethodId` varchar(40) DEFAULT NULL,
  `inputMappingsJson` longtext,
  `methodCode` varchar(40) DEFAULT NULL,
  `outputMappingsJson` longtext,
  `schemaCode` varchar(40) DEFAULT NULL,
  `serviceCode` varchar(40) DEFAULT NULL,
  `serviceMethodCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table h_biz_method_mapping
	add businessRuleId varchar(40) null comment '关联的业务规则id';
alter table h_biz_method_mapping
	add nodeCode varchar(40) null comment '关联的业务规则节点';

-- ----------------------------
-- Table structure for h_biz_property
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_property` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `defaultProperty` bit(1) DEFAULT NULL,
  `defaultValue` varchar(200) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `propertyEmpty` bit(1) DEFAULT NULL,
  `propertyIndex` bit(1) DEFAULT NULL,
  `propertyLength` int(11) DEFAULT NULL,
  `propertyType` varchar(40) DEFAULT NULL,
  `published` bit(1) DEFAULT NULL,
  `relativeCode` varchar(40) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_query
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_query` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_query_action
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_query_action` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `actionCode` varchar(40) DEFAULT NULL,
  `associationCode` varchar(40) DEFAULT NULL,
  `associationType` varchar(40) DEFAULT NULL,
  `customService` bit(1) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `queryActionType` varchar(50) DEFAULT NULL,
  `queryId` varchar(36) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `serviceCode` varchar(40) DEFAULT NULL,
  `serviceMethod` varchar(40) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `systemAction` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_query_column
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_query_column` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `isSystem` bit(1) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `propertyCode` varchar(40) DEFAULT NULL,
  `propertyType` varchar(40) DEFAULT NULL,
  `queryId` varchar(36) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `sumType` varchar(40) DEFAULT NULL,
  `unit` int(11) DEFAULT NULL,
  `width` varchar(50) DEFAULT NULL,
  `displayFormat` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_query_condition
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_query_condition` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `choiceType` varchar(10) DEFAULT NULL,
  `dataStatus` varchar(40) DEFAULT NULL,
  `defaultState` int(11) DEFAULT NULL,
  `defaultValue` varchar(50) DEFAULT NULL,
  `displayType` varchar(10) DEFAULT NULL,
  `endValue` varchar(50) DEFAULT NULL,
  `isSystem`          bit(1)        DEFAULT NULL,
  `name`              varchar(50)   DEFAULT NULL,
  `options`           longtext,
  `propertyCode`      varchar(40)   DEFAULT NULL,
  `propertyType`      varchar(40)   DEFAULT NULL,
  `queryId`           varchar(36)   DEFAULT NULL,
  `schemaCode`        varchar(40)   DEFAULT NULL,
  `sortKey`           int(11)       DEFAULT NULL,
  `startValue`        varchar(50)   DEFAULT NULL,
  `userOptionType`    varchar(10)   DEFAULT NULL,
  `visible`           bit(1)        DEFAULT NULL,
  `relativeQueryCode` varchar(40)   DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_query_sorter
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_query_sorter` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `direction` varchar(40) DEFAULT NULL,
  `isSystem` bit(1) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `propertyCode` varchar(40) DEFAULT NULL,
  `propertyType` varchar(40) DEFAULT NULL,
  `queryId` varchar(36) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_schema
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_schema` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `published` bit(1) DEFAULT NULL,
  `summary` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_service
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_service` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `configJSON` longtext,
  `description` varchar(2000) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `serviceCategoryId` varchar(40) DEFAULT NULL,
  `adapterCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_service_category
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_service_category` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_service_method
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_service_method` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `configJSON` longtext,
  `description` varchar(2000) DEFAULT NULL,
  `inputParametersJson` longtext,
  `name` varchar(50) DEFAULT NULL,
  `outputParametersJson` longtext,
  `protocolAdapterType` varchar(40) DEFAULT NULL,
  `serviceCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_biz_sheet
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_biz_sheet` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `draftAttributesJson` longtext,
  `draftViewJson` longtext,
  `icon` varchar(50) DEFAULT NULL,
  `mobileIsPc` bit(1) DEFAULT NULL,
  `mobileUrl` varchar(500) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pcUrl` varchar(500) DEFAULT NULL,
  `printIsPc` bit(1) DEFAULT NULL,
  `printUrl` varchar(500) DEFAULT NULL,
  `published` bit(1) DEFAULT NULL,
  `publishedAttributesJson` longtext,
  `publishedViewJson` longtext,
  `schemaCode` varchar(40) DEFAULT NULL,
  `sheetType` varchar(50) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `serialCode` varchar(255) DEFAULT NULL,
  `serialResetType` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_custom_page
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_custom_page` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `mobileUrl` varchar(500) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `openMode` varchar(40) DEFAULT NULL,
  `pcUrl` varchar(500) DEFAULT NULL,
  `appCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_im_message
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_im_message` (
  `id` varchar(36) NOT NULL,
  `bizParams` longtext,
  `channel` varchar(40) DEFAULT NULL,
  `content` longtext,
  `createdTime` datetime DEFAULT NULL,
  `failRetry` bit(1) DEFAULT NULL,
  `failUserRetry` bit(1) DEFAULT NULL,
  `messageType` varchar(40) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `receivers` longtext,
  `title` varchar(100) DEFAULT NULL,
  `tryTimes` int(11) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_message_id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_im_message_history
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_im_message_history` (
  `id` varchar(36) NOT NULL,
  `bizParams` longtext,
  `channel` varchar(40) DEFAULT NULL,
  `content` longtext,
  `createdTime` datetime DEFAULT NULL,
  `failRetry` bit(1) DEFAULT NULL,
  `failUserRetry` bit(1) DEFAULT NULL,
  `messageType` varchar(40) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `receivers` longtext,
  `title` varchar(100) DEFAULT NULL,
  `tryTimes` int(11) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `sendFailUserIds` longtext,
  `status` varchar(40) DEFAULT NULL,
  `taskId` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_message_history_id` (`id`) USING BTREE,
  KEY `idx_message_history_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_log_biz_object
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_log_biz_object` (
  `id` varchar(120) NOT NULL,
  `client` longtext,
  `detail` longtext,
  `ip` varchar(500) DEFAULT NULL,
  `operateNode` varchar(100) DEFAULT NULL,
  `operationType` varchar(50) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `workflowInstanceId` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_log_biz_service
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_log_biz_service` (
  `id` varchar(120) NOT NULL,
  `bizServiceStatus` varchar(20) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `exception` longtext,
  `methodName` varchar(120) DEFAULT NULL,
  `options` longtext,
  `params` varchar(2000) DEFAULT NULL,
  `result` longtext,
  `server` varchar(200) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `usedTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_log_login
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_log_login` (
  `id` varchar(120) NOT NULL,
  `browser` varchar(50) DEFAULT NULL,
  `clientAgent` varchar(500) DEFAULT NULL,
  `ipAddress` varchar(20) DEFAULT NULL,
  `loginSourceType` varchar(40) DEFAULT NULL,
  `loginTime` datetime DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `userId` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_log_metadata
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_log_metadata` (
  `id` varchar(120) NOT NULL,
  `bizKey` varchar(120) DEFAULT NULL,
  `metaData` longtext,
  `moduleName` varchar(60) DEFAULT NULL,
  `objId` varchar(120) DEFAULT NULL,
  `operateTime` datetime DEFAULT NULL,
  `operateType` int(11) DEFAULT NULL,
  `operator` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_log_workflow_exception
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_log_workflow_exception` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) NOT NULL,
  `createrName` varchar(200) DEFAULT NULL,
  `detail` text,
  `extData` varchar(1000) DEFAULT NULL,
  `fixNotes` varchar(1000) DEFAULT NULL,
  `fixedTime` datetime DEFAULT NULL,
  `fixer` varchar(120) DEFAULT NULL,
  `fixerName` varchar(200) DEFAULT NULL,
  `status` varchar(40) NOT NULL,
  `summary` varchar(500) NOT NULL,
  `workflowCode` varchar(40) NOT NULL,
  `workflowInstanceId` varchar(120) NOT NULL,
  `workflowInstanceName` varchar(200) DEFAULT NULL,
  `workflowName` varchar(200) DEFAULT NULL,
  `workflowVersion` int(11) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_org_department
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_org_department` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `extend1` varchar(255) DEFAULT NULL,
  `extend2` varchar(255) DEFAULT NULL,
  `extend3` varchar(255) DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `calendarId` varchar(36) DEFAULT NULL,
  `employees` int(11) DEFAULT NULL,
  `leaf` bit(1) DEFAULT NULL,
  `managerId` varchar(36) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `parentId` varchar(36) DEFAULT NULL,
  `sortKey` bigint(20) DEFAULT NULL,
  `sourceId` varchar(40) DEFAULT NULL,
  `queryCode` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_m8jlxslrsucu3y6dv1lb1s5jf` (`sourceId`),
  KEY `idx_org_name` (`name`),
  KEY `idx_parent_id` (`parentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_org_dept_user
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_org_dept_user` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `extend1` varchar(255) DEFAULT NULL,
  `extend2` varchar(255) DEFAULT NULL,
  `extend3` varchar(255) DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `deptId` varchar(36) DEFAULT NULL,
  `main` bit(1) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_du_user_id` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_org_role
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_org_role` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `extend1` varchar(255) DEFAULT NULL,
  `extend2` varchar(255) DEFAULT NULL,
  `extend3` varchar(255) DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(180) DEFAULT NULL,
  `groupId` varchar(36) DEFAULT NULL,
  `name` varchar(180) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `sourceId` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_itk9w9ftn6a2vn5o8c7n83ymc` (`sourceId`),
  KEY `idx_role_id` (`id`),
  KEY `idx_rolde_code` (`code`),
  KEY `idx_rolde_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_org_role_group
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_org_role_group` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `extend1` varchar(255) DEFAULT NULL,
  `extend2` varchar(255) DEFAULT NULL,
  `extend3` varchar(255) DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(180) DEFAULT NULL,
  `defaultGroup` bit(1) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `roleId` varchar(36) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `sourceId` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_role_group_id` (`id`),
  KEY `idx_role_group_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_org_role_user
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_org_role_user` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `extend1` varchar(255) DEFAULT NULL,
  `extend2` varchar(255) DEFAULT NULL,
  `extend3` varchar(255) DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `ouScope` varchar(4000) DEFAULT NULL,
  `roleId` varchar(36) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_role_user_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_org_user
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_org_user` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `extend1` varchar(255) DEFAULT NULL,
  `extend2` varchar(255) DEFAULT NULL,
  `extend3` varchar(255) DEFAULT NULL,
  `extend4` int(11) DEFAULT NULL,
  `extend5` int(11) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `admin` bit(1) DEFAULT NULL,
  `appellation` varchar(40) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `boss` bit(1) DEFAULT NULL,
  `departmentId` varchar(255) DEFAULT NULL,
  `departureDate` datetime DEFAULT NULL,
  `dingtalkId` varchar(100) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `employeeNo` varchar(40) DEFAULT NULL,
  `employeeRank` int(11) DEFAULT NULL,
  `entryDate` datetime DEFAULT NULL,
  `gender` varchar(8) DEFAULT NULL,
  `identityNo` varchar(18) DEFAULT NULL,
  `imgUrl` varchar(200) DEFAULT NULL,
  `leader` bit(1) DEFAULT NULL,
  `managerId` varchar(40) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `officePhone` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `privacyLevel` varchar(40) DEFAULT NULL,
  `secretaryId` varchar(36) DEFAULT NULL,
  `sortKey` bigint(20) DEFAULT NULL,
  `sourceId` varchar(50) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_rj7duahtop7qmf2ka0kxs57i0` (`dingtalkId`),
  UNIQUE KEY `UK_phr7by4273l3804n3xc2gq15o` (`sourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_perm_admin
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_perm_admin` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `adminType` varchar(40) DEFAULT NULL,
  `dataManage` bit(1) DEFAULT NULL,
  `dataQuery` bit(1) DEFAULT NULL,
  `userId` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_perm_app_package
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_perm_app_package` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `appCode` varchar(40) DEFAULT NULL,
  `departments` longtext,
  `roles` longtext,
  `visibleType` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_perm_apppackage_scope
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_perm_apppackage_scope` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `adminId` varchar(40) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_perm_biz_function
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_perm_biz_function` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `creatable` bit(1) DEFAULT NULL,
  `dataPermissionType` varchar(40) DEFAULT NULL,
  `deletable` bit(1) DEFAULT NULL,
  `editable` bit(1) DEFAULT NULL,
  `exportable` bit(1) DEFAULT NULL,
  `filterType` varchar(40) DEFAULT NULL,
  `functionCode` varchar(40) DEFAULT NULL,
  `importable` bit(1) DEFAULT NULL,
  `permissionGroupId` varchar(40) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `visible` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_perm_department_scope
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_perm_department_scope` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `adminId` varchar(40) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `queryCode` varchar(128) DEFAULT NULL,
  `unitId` varchar(40) DEFAULT NULL,
  `unitType` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_perm_function_condition
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_perm_function_condition` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `operatorType` varchar(40) DEFAULT NULL,
  `propertyCode` varchar(40) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `value` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_perm_group
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_perm_group` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `appCode` varchar(40) DEFAULT NULL,
  `departments` longtext,
  `name` varchar(50) DEFAULT NULL,
  `roles` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_system_sequence_no
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_system_sequence_no` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `maxLength` int(11) DEFAULT NULL,
  `resetDate` datetime DEFAULT NULL,
  `resetType` int(11) DEFAULT NULL,
  `serialNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_system_setting
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_system_setting` (
  `id` varchar(120) COLLATE utf8_bin NOT NULL,
  `paramCode` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `paramValue` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `settingType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `checked` bit(1) DEFAULT NULL,
  `fileUploadType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_1acm46hyhe6xq971mhf1xi5h0` (`paramCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for h_system_setting_copy
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_system_setting_copy` (
  `id` varchar(120) COLLATE utf8_bin NOT NULL,
  `paramCode` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `paramValue` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `settingType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_1acm46hyhe6xq971mhf1xi5h0` (`paramCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for h_user_comment
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_user_comment` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `content` varchar(600) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_user_favorites
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_user_favorites` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `bizObjectKey` varchar(40) DEFAULT NULL,
  `bizObjectType` varchar(20) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  `appCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_user_guide
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_user_guide` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `display` bit(1) DEFAULT NULL,
  `pageType` varchar(20) NOT NULL,
  `userId` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_workflow_header
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_workflow_header` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `mobileOriginate` bit(1) DEFAULT NULL,
  `pcOriginate` bit(1) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `workflowCode` varchar(40) DEFAULT NULL,
  `workflowName` varchar(200) DEFAULT NULL,
  `published` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_2t1h4foumcylj4hvrvhssf673` (`workflowCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_workflow_permission
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_workflow_permission` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `unitId` varchar(36) DEFAULT NULL,
  `unitType` varchar(10) DEFAULT NULL,
  `workflowCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_workflow_relative_object
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_workflow_relative_object` (
  `id` varchar(120) NOT NULL,
  `relativeCode` varchar(40) DEFAULT NULL,
  `relativeType` varchar(40) DEFAULT NULL,
  `workflowCode` varchar(40) DEFAULT NULL,
  `workflowVersion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for h_workflow_template
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_workflow_template` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `content` longtext,
  `templateType` varchar(10) DEFAULT NULL,
  `workflowCode` varchar(40) DEFAULT NULL,
  `workflowVersion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT IGNORE INTO `base_security_client` (`id`, `createdTime`, `creater`, `deleted`, `extend1`, `extend2`, `extend3`, `extend4`, `extend5`, `modifiedTime`, `modifier`, `remarks`, `accessTokenValiditySeconds`, `additionInformation`, `authorities`, `authorizedGrantTypes`, `autoApproveScopes`, `clientId`, `clientSecret`, `refreshTokenValiditySeconds`, `registeredRedirectUris`, `resourceIds`, `scopes`, `type`)
VALUES ('8a5da52ed126447d359e70c05721a8aa', NULL, NULL, b'0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, '28800', 'API', 'api', 'authorization_code,implicit,password,refresh_token', 'read,write', 'api', '{noop}c31b32364ce19ca8fcd150a417ecce58', '28800', 'http://127.0.0.1/admin,http://127.0.0.1/admin#/oauth,http://127.0.0.1/oauth', 'api', 'read,write', 'APP');

INSERT IGNORE INTO `h_org_user` (`id`, `createdTime`, `creater`, `deleted`, `extend1`, `extend2`, `extend3`, `extend4`, `extend5`, `modifiedTime`, `modifier`, `remarks`, `active`, `admin`, `appellation`, `birthday`, `boss`, `departmentId`, `departureDate`, `dingtalkId`, `email`, `employeeNo`, `employeeRank`, `entryDate`, `gender`, `identityNo`, `imgUrl`, `leader`, `managerId`, `mobile`, `name`, `officePhone`, `password`, `username`, `privacyLevel`, `secretaryId`, `sortKey`, `sourceId`, `status`, `userId`)
VALUES ('2c9280a26706a73a016706a93ccf002b', NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL, '2019-02-22 13:54:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', NULL, '{bcrypt}$2a$10$NvgvcocBqMn050z4nC0I6OeAhO5ERjM74pvMtSGLghPhWI5ed5myG', 'admin', NULL, NULL, NULL, NULL, NULL, NULL);

-- 修改用户名称字段的字符编码
ALTER TABLE `h_org_user` CHANGE `name` `name` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;



CREATE TABLE IF NOT EXISTS `h_biz_rule` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `conditionJoinType` varchar(40) DEFAULT NULL COMMENT '条件连接类型',
  `enabled` bit(1) DEFAULT NULL COMMENT '是否启用',
  `name` varchar(100) DEFAULT NULL COMMENT '数据规则名称',
  `ruleActionJson` longtext COMMENT '执行动作',
  `ruleScopeJson` longtext COMMENT '查找范围',
  `sourceSchemaCode` varchar(40) DEFAULT NULL COMMENT '规则所属模型编码',
  `targetSchemaCode` varchar(40) DEFAULT NULL COMMENT '目标模型编码',
  `triggerActionType` varchar(40) DEFAULT NULL COMMENT '触发动作类型',
  `triggerConditionType` varchar(40) DEFAULT NULL COMMENT '触发条件类型',
  `triggerSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '数据规则';


ALTER TABLE `h_biz_rule` ADD COLUMN `chooseAction` varchar(100) DEFAULT NULL COMMENT '目标模型导航编码';


ALTER TABLE `h_biz_query_condition` ADD COLUMN `accurateSearch` bit(1) DEFAULT NULL COMMENT '精确查找';
ALTER TABLE `h_biz_query_condition` ADD COLUMN `displayFormat` varchar(40) DEFAULT NULL COMMENT '显示格式';


CREATE TABLE IF NOT EXISTS `h_biz_rule_trigger` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `conditionJoinType` varchar(40) DEFAULT NULL COMMENT '条件连接类型',
  `ruleId` varchar(100) DEFAULT NULL COMMENT '数据规则id',
  `ruleName` varchar(100) DEFAULT NULL COMMENT '数据规则名称',
  `targetSchemaCode` varchar(40) DEFAULT NULL COMMENT '目标模型编码',
  `triggerActionType` varchar(40) DEFAULT NULL COMMENT '触发动作类型',
  `triggerConditionType` varchar(40) DEFAULT NULL COMMENT '触发条件类型',
  `triggerObjectId` varchar(100) DEFAULT NULL COMMENT '触发对象Id',
  `triggerSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发对象模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '数据规则触发记录';

CREATE TABLE IF NOT EXISTS `h_biz_rule_effect` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `actionType` varchar(40) DEFAULT NULL COMMENT '动作类型',
  `actionValue` varchar(255) DEFAULT NULL COMMENT '动作值',
  `lastValue` longtext COMMENT '规则执行前数据',
  `setValue` longtext COMMENT '规则执行后数据',
  `targetObjectId` varchar(100) DEFAULT NULL COMMENT '目标对象id',
  `targetPropertyCode` varchar(40) DEFAULT NULL COMMENT '目标属性',
  `targetSchemaCode` varchar(40) DEFAULT NULL COMMENT '目标模型编码',
  `triggerActionType` varchar(40) DEFAULT NULL COMMENT '触发动作类型',
  `triggerId` varchar(100) DEFAULT NULL COMMENT '规则触发id',
  `triggerObjectId` varchar(100) DEFAULT NULL COMMENT '触发对象id',
  `triggerSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发对象模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '数据规则执行影响数据记录';


ALTER TABLE `h_biz_query_condition` MODIFY `defaultValue` VARCHAR(500) DEFAULT NULL COMMENT '默认值';


ALTER TABLE `h_perm_biz_function` ADD COLUMN `nodeType` VARCHAR(40) DEFAULT NULL COMMENT '节点类型';


CREATE TABLE IF NOT EXISTS `h_workflow_relative_event`
(
  `id`            varchar(120) NOT NULL,
  `creater`       varchar(120) DEFAULT NULL,
  `createdTime`   datetime     DEFAULT NULL,
  `deleted`       bit(1)       DEFAULT NULL,
  `modifier`      varchar(120) DEFAULT NULL,
  `modifiedTime`  datetime     DEFAULT NULL,
  `remarks`       varchar(200) DEFAULT NULL,
  `schemaCode`    varchar(40)  DEFAULT NULL COMMENT '模型编码',
  `workflowCode`  varchar(40)  DEFAULT NULL COMMENT '流程编码',
  `bizMethodCode` varchar(40)  DEFAULT NULL COMMENT '业务方法编码',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '流程关联业务方法';

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

ALTER TABLE `h_perm_function_condition` ADD `functionId` varchar(40) DEFAULT NULL;

ALTER TABLE `h_org_dept_user` ADD `sortKey` varchar(200) DEFAULT NULL;
ALTER TABLE `h_org_dept_user` ADD `leader` bit(1) DEFAULT NULL;

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

ALTER TABLE `h_biz_property` ADD COLUMN `sortKey` int(11) DEFAULT NULL COMMENT '排序字段';

ALTER TABLE `h_log_biz_service` ADD COLUMN `schemaCode` VARCHAR (40) NULL DEFAULT NULL COMMENT '业务模型编码' COLLATE 'utf8_bin';
ALTER TABLE `h_log_biz_service` ADD COLUMN `bizObjectId` VARCHAR (200) NULL DEFAULT NULL COMMENT '业务对象ID' COLLATE 'utf8_bin';


CREATE TABLE IF NOT EXISTS `h_system_pair` (
  `id` varchar(120) NOT NULL,
  `paramCode` varchar(200) DEFAULT NULL,
  `pairValue` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_9tviae6s7glway1kpyiybg4yp` (`paramCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `h_job_result` (
  `id` varchar(120) COLLATE utf8_bin NOT NULL,
  `jobName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `beanName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `methodName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `methodParams` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `year` int(10) DEFAULT NULL,
  `cronExpression` varchar(80) COLLATE utf8_bin DEFAULT NULL,
  `jobRunType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `executeStatus` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='定时任务执行结果表';


CREATE TABLE `h_timer_job` (
  `id` varchar(120) COLLATE utf8_bin NOT NULL,
  `jobName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `beanName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `methodName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `methodParams` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `year` int(10) DEFAULT NULL,
  `cronExpression` varchar(80) COLLATE utf8_bin DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '状态（1正常 0暂停）',
  `jobRunType` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `remark` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='定时任务表';


ALTER TABLE `h_biz_sheet` ADD COLUMN `pdfAble` VARCHAR (40) DEFAULT NULL COMMENT '开启pdf';

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

-- 1.4版本

ALTER TABLE `h_biz_rule` ADD COLUMN `dataConditionJoinType` varchar(40) DEFAULT NULL COMMENT '触发数据条件连接类型';

ALTER TABLE `h_biz_rule` ADD COLUMN `dataConditionJson` longtext COMMENT '数据条件json';

ALTER TABLE `h_perm_group` ADD COLUMN `authorType` varchar(40) DEFAULT NULL COMMENT ' 授权类型';


ALTER TABLE `h_org_user` ADD COLUMN `pinYin` VARCHAR(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名拼音';
ALTER TABLE `h_org_user` ADD COLUMN `shortPinYin` VARCHAR(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名简拼';

ALTER TABLE `h_app_package` ADD COLUMN `appNameSpace` varchar(40) DEFAULT NULL COMMENT '应用命名空间';

ALTER TABLE h_perm_function_condition MODIFY COLUMN `value` LONGTEXT;

create table h_open_api_event
(
	id varchar(120) not null
		primary key,
	callback varchar(400) null comment '回调地址',
	clientId varchar(30) null comment '客户端编号',
	eventTarget varchar(300) null comment '事件对象',
	eventTargetType varchar(255) null comment '事件对象类型',
	eventType varchar(255) null comment '事件触发类型'
);

update h_biz_query_column set `name` = '拥有者' where propertyCode = 'owner';
update h_biz_query_column set `name` = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_query_condition set `name` = '拥有者' where propertyCode = 'owner';
update h_biz_query_condition set `name` = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_property set `name` = '拥有者' where code = 'owner';
update h_biz_property set `name` = '拥有者部门' where code = 'ownerDeptId';

CREATE TABLE `h_access_token` (
  `id` varchar(40) COLLATE utf8_bin NOT NULL,
  `userId` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `leastUse` tinyint(1) DEFAULT NULL,
  `accessToken` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access_token_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `h_biz_rule` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标对象编码';

ALTER TABLE `h_biz_rule` ADD COLUMN `ruleScopeChildJson` longtext COMMENT '子表查找范围json';

ALTER TABLE `h_biz_rule` ADD COLUMN `ruleActionMainScopeJson` longtext COMMENT '执行动作中主表筛选条件json';

ALTER TABLE `h_biz_rule` ADD COLUMN `insertConditionJoinType` varchar(40) DEFAULT NULL COMMENT '条件连接类型';


-- 放错到版本19
DELETE FROM h_perm_admin WHERE id='2c928a4c6c043e48016c04c108300a90';

INSERT INTO `h_perm_admin` (`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `adminType`, `dataManage`, `dataQuery`, `userId`)
VALUES ('2c928a4c6c043e48016c04c108300a90', '2c928e4c6a4d1d87016a4d1f2f760048', '2019-9-6 10:23:15', '\0', NULL, '2019-9-6 10:23:15', NULL, 'ADMIN', true, true, '2c9280a26706a73a016706a93ccf002b');

-- 刪除审批意见类型数据项
DELETE FROM h_biz_property WHERE propertyType='COMMENT';


CREATE TABLE IF NOT EXISTS `h_report_page` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `pcAble` bit(1) DEFAULT NULL COMMENT 'PC是否可见',
  `name` varchar(50) DEFAULT NULL,
  `mobileAble` bit(1) DEFAULT NULL COMMENT '移动端是否可见',
  `appCode` varchar(40) DEFAULT NULL,
  `name_i18n` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '双语言',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 数据规则触发记录表
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerMainObjectId` varchar(100) DEFAULT NULL COMMENT '触发主表对象Id';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerMainObjectName` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '触发主表对象数据标题';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerTableType` varchar(40) DEFAULT NULL COMMENT '触发表类型：主表，子表';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceAppCode` varchar(40) DEFAULT NULL COMMENT '触发应用编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceAppName` varchar(50) DEFAULT NULL COMMENT '触发应用名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发对象所属模型编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceSchemaName` varchar(50) DEFAULT NULL COMMENT '触发对象所属模型名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `targetSchemaName` varchar(50) DEFAULT NULL COMMENT '目标所属模型名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标表编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `success` bit(1) DEFAULT NULL COMMENT '是否执行成功';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `failLog` longtext COMMENT '执行失败日志';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `effect` bit(1) DEFAULT NULL COMMENT '执行是否有影响数据';

-- 数据规则影响数据表
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetTableType` varchar(40) DEFAULT NULL COMMENT '目标表类型：主表，子表';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标表编码';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetMainObjectId` varchar(100) DEFAULT NULL COMMENT '目标主表对象Id';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetMainObjectName` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '目标主表对象数据标题';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyLastValue` longtext COMMENT '字段修改前数据';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertySetValue` longtext COMMENT '字段修改后数据';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyName` varchar(50) DEFAULT NULL COMMENT '目标字段名称';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyType` varchar(40) DEFAULT NULL COMMENT '目标字段类型';

ALTER TABLE `h_report_page` ADD COLUMN `reportObjectId` varchar(40) DEFAULT NULL COMMENT '报表编码';


CREATE TABLE `h_biz_query_present` (
   `id` varchar(120) COLLATE utf8_bin NOT NULL,
   `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL,
   `createdTime` datetime DEFAULT NULL,
   `deleted` bit(1) DEFAULT NULL,
   `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL,
   `modifiedTime` datetime DEFAULT NULL,
   `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL,
   `queryId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
   `schemaCode` varchar(40) COLLATE utf8_bin DEFAULT NULL,
   `clientType` varchar(40) DEFAULT NULL COMMENT 'PC或者MOBILE端',
   `htmlJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表htmlJson数据',
   `actionsJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表action操作JSON数据',
   `columnsJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表展示字段columnJSON数据',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


ALTER TABLE `h_biz_query` ADD COLUMN `queryPresentationType` varchar(40) DEFAULT 'LIST' COMMENT '列表视图类型';

ALTER TABLE `h_biz_query` ADD COLUMN `showOnPc` bit(1) DEFAULT NULL COMMENT 'PC是否可见';

ALTER TABLE `h_biz_query` ADD COLUMN `showOnMobile` bit(1) DEFAULT NULL COMMENT '移动端是否可见';

ALTER TABLE `h_biz_query` ADD COLUMN `publish` bit(1) DEFAULT NULL COMMENT '发布状态';

ALTER TABLE `h_biz_query_column` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_condition` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_sorter` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_action` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';


ALTER TABLE `h_org_department` ADD COLUMN `dingDeptManagerId` varchar(255) DEFAULT NULL COMMENT '钉钉部门主管id集合';

ALTER TABLE `h_org_role_user` ADD COLUMN `userSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉用户id非unionId';
ALTER TABLE `h_org_role_user` ADD COLUMN `roleSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉角色id';

-- 更新数据
update h_org_role_user,h_org_role set h_org_role_user.roleSourceId = h_org_role.sourceId WHERE h_org_role_user.roleId = h_org_role.id;

update h_org_role_user,h_org_user set h_org_role_user.userSourceId = h_org_user.userId WHERE h_org_role_user.userId = h_org_user.id;


ALTER TABLE `h_org_dept_user` ADD COLUMN `userSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉用户id非unionId';
ALTER TABLE `h_org_dept_user` ADD COLUMN `deptSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉部门id';

-- 更新数据
update h_org_dept_user,h_org_department set h_org_dept_user.deptSourceId = h_org_department.sourceId WHERE h_org_dept_user.deptId = h_org_department.id;

update h_org_dept_user,h_org_user set h_org_dept_user.userSourceId = h_org_user.userId WHERE h_org_dept_user.userId = h_org_user.id;


-- 角色用户关联表联合索引
ALTER TABLE `h_org_role_user` ADD INDEX `idx_role_user_sourceid` (`userSourceId`,`roleSourceId`);

-- 部门用户关联表联合索引
ALTER TABLE `h_org_dept_user` ADD INDEX `idx_dept_user_composeid` (`userId`,`deptId`);

-- 修改部门名称字段的字符编码
ALTER TABLE `h_org_department` CHANGE `name` `name` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

-- 修改角色名称字段的字符编码
ALTER TABLE `h_org_role` CHANGE `name` `name` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

-- 修改日志表内容字段的字符编码
ALTER TABLE `h_log_metadata` CHANGE `metaData` `metaData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

ALTER TABLE `h_app_function` ADD COLUMN `pcAble` bit(1) DEFAULT 1 COMMENT 'PC是否可见';

ALTER TABLE `h_app_function` ADD COLUMN `mobileAble` bit(1) DEFAULT 1 COMMENT '移动端是否可见';

UPDATE `h_app_function` SET `pcAble`=0 WHERE `type`='Report' AND `code` IN (SELECT `code` FROM `h_report_page` WHERE `pcAble`=0);

UPDATE `h_app_function` SET `mobileAble`=0 WHERE `type`='Report' AND `code` IN (SELECT `code` FROM `h_report_page` WHERE `mobileAble`=0);

CREATE TABLE `d_process_instance` (
  `id` varchar(42) NOT NULL,
  `processCode` varchar(120) NOT NULL COMMENT '钉钉模板code',
  `originator` varchar(64) NOT NULL COMMENT '实例发起人的userid',
  `title` varchar(64) DEFAULT NULL COMMENT '实例的标题',
  `url` varchar(255) NOT NULL COMMENT '实例在审批应用里的跳转url，需要同时适配移动端和pc端',
  `processInstanceId` varchar(64) NOT NULL COMMENT '钉钉实例id',
  `wfInstanceId` varchar(64) NOT NULL COMMENT '云枢流程实例id',
  `formComponents` longtext COMMENT '表单参数',
  `status` varchar(42) DEFAULT NULL COMMENT '钉钉实例状态，分为COMPLETED, TERMINATED',
  `result` varchar(42) DEFAULT NULL COMMENT '任务结果，分为agree和refuse',
  `createTime` datetime DEFAULT NULL,
  `requestId` varchar(42) DEFAULT NULL COMMENT '钉钉每次请求的id',
  `wfWorkItemId` varchar(64) DEFAULT NULL,
  `bizProcessStatus` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
  -- UNIQUE KEY `IDX_UNIQUE_WFIID` (`wfInstanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `d_process_task` (
  `id` varchar(42) NOT NULL,
  `processInstanceId` varchar(64) NOT NULL,
  `taskId` bigint(20) NOT NULL,
  `userId` varchar(64) NOT NULL COMMENT '钉钉用户id',
  `url` varchar(255) DEFAULT NULL COMMENT '待办任务跳转url',
  `wfWorkItemId` varchar(42) NOT NULL COMMENT '云枢业务任务id',
  `wfInstanceId` varchar(42) NOT NULL,
  `status` varchar(64) DEFAULT NULL COMMENT '任务状态，分为CANCELED和COMPLETED',
  `result` varchar(64) DEFAULT NULL COMMENT '任务结果，氛围agree和refuse',
  `createTime` datetime DEFAULT NULL,
  `requestId` varchar(42) DEFAULT NULL COMMENT '钉钉每次请求的id',
  `bizProcessStatus` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `d_process_template` (
  `id` varchar(42) NOT NULL,
  `tempCode` varchar(64) NOT NULL COMMENT '云枢业务定义的模板code',
  `processCode` varchar(120) NOT NULL COMMENT '钉钉模板code',
  `processName` varchar(64) NOT NULL COMMENT '模板名称',
  `agentId` decimal(10,0) NOT NULL COMMENT '企业微应用标识',
  `formField` longtext COMMENT '表单字段',
  `createTime` datetime DEFAULT NULL,
  `requestId` varchar(42) DEFAULT NULL COMMENT '钉钉每次请求的id',
  `bizProcessStatus` varchar(64) DEFAULT NULL,
  `wfWorkItemId` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_UNIQUE_TEMP_CODE` (`tempCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='钉钉流程模板';

-- 1.5版本
ALTER TABLE `h_biz_sheet` ADD COLUMN `tempAuthSchemaCodes` varchar (350) DEFAULT null COMMENT '临时授权的SchemaCode 以,分割';
ALTER TABLE `h_biz_sheet` ADD COLUMN `borderMode` varchar (10) DEFAULT null COMMENT '表单是否支持边框模式,close或open';
ALTER TABLE `h_biz_sheet` ADD COLUMN `layout` varchar (20) DEFAULT null COMMENT '表单边框布局,horizontal-左右布局,vertical-上下布局';

ALTER TABLE `h_biz_sheet` change `layout` `layoutType` varchar(20);

CREATE TABLE `h_perm_license` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `bizId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '授权的业务id',
  `bizType` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '业务类型，USER：用户；DEPART：部门；ROLE：角色',
  `createdTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `h_biz_schema` MODIFY `remarks` varchar(2000) DEFAULT NULL;

ALTER TABLE `h_org_department` ADD COLUMN `isShow` bit(1) DEFAULT 1 COMMENT '部门是否可见';

ALTER TABLE `h_org_department` ADD COLUMN `deptType` varchar(40) DEFAULT 'DEPT' COMMENT '部门类型';

ALTER TABLE `h_org_role_group` ADD COLUMN `roleType` varchar(40) DEFAULT 'SYS' COMMENT '角色类型';

ALTER TABLE `h_org_role` ADD COLUMN `roleType` varchar(40) DEFAULT 'SYS' COMMENT '角色类型';

ALTER TABLE `h_org_role_user` ADD COLUMN `unitType` varchar(40) DEFAULT 'USER' COMMENT '角色关联类型';

ALTER TABLE `h_org_role_user` ADD COLUMN `deptId` varchar(40)  COMMENT '角色关联部门ID';

update `h_org_role_group` set roleType = 'DINGTALK' where sourceId is not null;

update `h_org_role` set roleType = 'DINGTALK' where sourceId is not null;

ALTER TABLE d_process_template CHANGE wfWorkItemId queryId VARCHAR(42) DEFAULT NULL COMMENT '列表ID';

INSERT INTO `h_system_setting`(`id`, `paramCode`, `paramValue`, `settingType`, `checked`, `fileUploadType`) VALUES ('2c928e636f3fe9b5016f3feb81c70000', 'dingtalk.isSynEdu', 'false', 'DINGTALK_BASE', b'0', NULL);

ALTER TABLE `h_system_pair`
MODIFY COLUMN `paramCode`  varchar(200) BINARY CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `id`;

DROP index UK_9tviae6s7glway1kpyiybg4yp on `h_system_pair`;

ALTER TABLE `h_biz_perm_group` ADD COLUMN `departments` longtext COMMENT '部门范围';
ALTER TABLE `h_biz_perm_group` ADD COLUMN `authorType` varchar(40) DEFAULT null COMMENT '授权类型';

ALTER TABLE `h_biz_rule` ADD COLUMN `triggerSchemaCodeIsGroup` bit(1) DEFAULT 0 COMMENT '主表加子表数据项';

ALTER TABLE `h_biz_sheet`
    MODIFY COLUMN `shortCode`  varchar(50) BINARY CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '表单外链短码';

ALTER TABLE `biz_workflow_instance` ADD COLUMN `sequenceNo` varchar(200) DEFAULT null COMMENT '单据号';

ALTER TABLE `h_org_user` ADD COLUMN `imgUrlId` varchar(40) DEFAULT NULL COMMENT '头像id';
ALTER TABLE `h_biz_query_condition` ADD COLUMN `dateType` varchar(40) DEFAULT null COMMENT '日期快捷方式';
-- 1.6版本
CREATE TABLE IF NOT EXISTS QRTZ_JOB_DETAILS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE IF NOT EXISTS QRTZ_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE IF NOT EXISTS QRTZ_SIMPLE_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(10) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE IF NOT EXISTS QRTZ_CRON_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE IF NOT EXISTS QRTZ_SIMPROP_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE IF NOT EXISTS QRTZ_BLOB_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE IF NOT EXISTS QRTZ_CALENDARS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);

CREATE TABLE IF NOT EXISTS QRTZ_PAUSED_TRIGGER_GRPS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);

CREATE TABLE IF NOT EXISTS QRTZ_FIRED_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    SCHED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_NONCONCURRENT VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);

CREATE TABLE IF NOT EXISTS QRTZ_SCHEDULER_STATE
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);

CREATE TABLE IF NOT EXISTS QRTZ_LOCKS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40) NOT NULL,
    PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);

COMMIT;

CREATE TABLE `h_form_comment` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `content` varchar(3000) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '评论内容',
    `commentator` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '评论人id',
    `commentatorName` varchar(80) CHARACTER SET utf8mb4 NOT NULL COMMENT '评论人名称',
    `departmentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '评论人部门id',
    `schemaCode` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '模型编码',
    `bizObjectId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '表单id',
    `replyCommentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '被回复的评论id',
    `replyUserId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '被回复的用户id',
    `replyUserName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被回复的用户名称',
    `originCommentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '最原始的评论id',
    `floor` int(11) NOT NULL DEFAULT '0' COMMENT '评论层级，最原始评论从0开始',
    `state` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'ENABLED' COMMENT '评论状态，可用：ENABLED；禁用：DISABLED；',
    `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被删除，0：否；1：是',
    `attachmentNum` int(11) NOT NULL DEFAULT '0' COMMENT '附件数量',
    `modifier` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '删除/更新用户id',
    `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
    `modifiedTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '删除/更新时间',
    PRIMARY KEY (`id`),
    KEY `IDX_FORM_OBJ_ID` (`bizObjectId`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表单评论表';

CREATE TABLE `h_from_comment_attachment` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `bizObjectId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '表单id',
    `schemaCode` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '模型编码',
    `commentId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '评论id',
    `fileExtension` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '文件后缀名',
    `fileSize` int(11) NOT NULL DEFAULT '0' COMMENT '文件大小',
    `mimeType` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '文件媒体类型',
    `name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '文件名称，带后缀',
    `refId` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '上传到文件系统的文件id',
    `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上传时间',
    `creater` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '上传用户id',
    PRIMARY KEY (`id`),
    KEY `IDX_F_C_A_COMM_ID` (`commentId`),
    KEY `IDX_F_C_A_REF_ID` (`refId`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表单评论附件表';



ALTER TABLE `h_form_comment` ADD COLUMN `text` varchar(5000) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '评论内容html格式';


ALTER TABLE `h_biz_property` ADD COLUMN `relativePropertyCode` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '关联表单显示字段';


alter table `h_biz_attachment` add index idx_h_biz_attachment_bizObjectId(`bizObjectId`);
alter table `h_biz_attachment` modify column parentBizObjectId varchar(36) default '';
alter table `h_biz_attachment` add index idx_h_biz_attachment_parentBizObjectId(`parentBizObjectId`);


ALTER TABLE h_im_work_record MODIFY COLUMN `content` varchar(3000) default '';
ALTER TABLE h_im_work_record_history MODIFY COLUMN `content` varchar(3000) default '';

ALTER TABLE `h_org_user` ADD COLUMN `dingUserJson` longtext COMMENT '钉钉同步过来的json数据记录';
ALTER TABLE `h_org_user` MODIFY `dingUserJson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

CREATE TABLE `h_related_corp_setting` (
    `id` varchar(120)  NOT NULL,
    `creater` varchar(120)  DEFAULT NULL,
    `createdTime` datetime DEFAULT NULL,
    `deleted` bit(1) DEFAULT NULL,
    `modifier` varchar(120)  DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    `remarks` varchar(200)  DEFAULT NULL,
    `agentId` varchar(120)  DEFAULT NULL,
    `appSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL,
    `appkey` varchar(120)  DEFAULT NULL,
    `corpId` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织的corpId',
    `corpSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织的corpSecret',
    `exportHost` varchar(32) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '多机器转发的地址',
    `extend1` varchar(120)  DEFAULT NULL,
    `extend2` varchar(120)  DEFAULT NULL,
    `extend3` varchar(120)  DEFAULT NULL,
    `extend4` varchar(120)  DEFAULT NULL,
    `extend5` varchar(120)  DEFAULT NULL,
    `headerNum` int(11) NOT NULL COMMENT ' 企业标记，用于部门sourceid',
    `name` varchar(64) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '公司名称',
    `orgType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '第三方类型',
    `relatedType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织类型',
    `scanAppId` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '扫码登录appid',
    `scanAppSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '扫码登录Secret',
    `redirectUri` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '登录回调地址',
    `synRedirectUri` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '增量回调地址',
    `pcServerUrl` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT 'pc端地址',
    `mobileServerUrl` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '手机端地址',
    `syncType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '同步方式',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_ci;


-- 用户新增组织外键关联
ALTER TABLE `h_org_user`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 角色组新增组织外键关联
ALTER TABLE `h_org_role_group`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 角色新增组织外键关联
ALTER TABLE `h_org_role`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 部门新增组织外键关联
ALTER TABLE `h_org_department`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 部门历史新增组织外键关联
ALTER TABLE `h_org_department_history`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;

CREATE TABLE IF NOT EXISTS `h_org_synchronize_log`(
  `id` varchar(120) NOT NULL,
  `targetType` varchar(30) DEFAULT NULL COMMENT '同步类型 部门|用户|角色|某个部门|某个角色用户',
  `trackId` varchar(60) DEFAULT NULL COMMENT '同步批次',
  `targetId` varchar(120) DEFAULT NULL COMMENT '目标源数据',
  `errorType` varchar(1000) DEFAULT NULL COMMENT '错误原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `h_biz_sheet` ADD COLUMN `formComment` bit(1) DEFAULT 0 COMMENT '是否开启表单评论';

-- 部门
ALTER TABLE `h_org_department` DROP INDEX `UK_m8jlxslrsucu3y6dv1lb1s5jf`;

-- 用户
ALTER TABLE `h_org_user` DROP INDEX `UK_phr7by4273l3804n3xc2gq15o`;

-- 角色
ALTER TABLE `h_org_role` DROP INDEX `UK_itk9w9ftn6a2vn5o8c7n83ymc`;

CREATE TABLE `h_biz_export_task` (
    `id` varchar(36) COLLATE utf8_bin NOT NULL COMMENT 'primary key',
    `startTime` datetime DEFAULT NULL COMMENT '开始时间',
    `endTime` datetime DEFAULT NULL COMMENT '结束时间',
    `message` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '失败信息',
    `taskStatus` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '任务状态',
    `syncResult` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '同步结果',
    `userId` varchar(36) COLLATE utf8_bin DEFAULT NULL COMMENT '谁同步的',
    `createdTime` datetime DEFAULT NULL COMMENT '生成时间',
    `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
    `deleted` bit(1) DEFAULT NULL COMMENT '是否删除',
    `modifiedTime` datetime DEFAULT NULL COMMENT '修改时间' ,
    `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '修改者',
    `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `h_biz_export_task` CHANGE `syncResult` `exportResultStatus` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '同步结果';

ALTER TABLE `h_biz_export_task` ADD COLUMN `path` varchar(120) DEFAULT NULL COMMENT '文件路径';

-- 删除部门用户关联重复项 保留最旧的记录
delete from h_org_dept_user where id in(
    select a.id from (
                         select hodu.id from h_org_dept_user hodu where hodu.id in(
                             select a.id from h_org_dept_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) num,a.deptId,a.userId,MIN(a.createdTime) from h_org_dept_user a GROUP BY a.deptId,a.userId having num > 1
                                              ) b on a.deptId = b.deptId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_dept_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.deptId,a.userId,MIN(a.createdTime) minTime from h_org_dept_user a GROUP BY a.deptId,a.userId having num > 1
                                               ) b on a.deptId = b.deptId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);
-- 建立部门用户联合唯一索引
ALTER TABLE `h_org_dept_user`
DROP INDEX `idx_dept_user_composeid`,
    ADD UNIQUE INDEX `idx_dept_user_composeid`(`userId`, `deptId`) USING BTREE;

-- 删除角色用户关联重复项 保留最旧的记录
delete from h_org_role_user where id in(
    select a.id from (
                         select hodu.id from h_org_role_user hodu where hodu.id in(
                             select a.id from h_org_role_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) from h_org_role_user a GROUP BY a.roleId,a.userId having num > 1
                                              ) b on a.roleId = b.roleId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_role_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) minTime from h_org_role_user a GROUP BY a.roleId,a.userId having num > 1
                                               ) b on a.roleId = b.roleId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);

-- 建立角色用户联合唯一索引
ALTER TABLE `h_org_role_user` ADD UNIQUE INDEX `idx_role_user_composeid`(`userId`, `roleId`) USING BTREE;


-- 字段调整为用户主键
update d_process_task,h_org_user set d_process_task.userId = h_org_user.id where h_org_user.userId = d_process_task.userId;

update d_process_instance,h_org_user set d_process_instance.originator = h_org_user.id where h_org_user.userId = d_process_instance.originator;


DROP PROCEDURE IF EXISTS updateCorpIdIsNull;

DELIMITER &&

CREATE PROCEDURE updateCorpIdIsNull()
BEGIN

    DECLARE MY_CORPID VARCHAR(50);
    DECLARE IS_CLOUD_PIVOT VARCHAR(50);

    SET MY_CORPID = (select hss.paramValue from h_system_setting hss where hss.paramCode = 'dingtalk.client.corpId');
    if MY_CORPID is not null then
    update h_org_user set corpId = MY_CORPID where corpId is null;
    update h_org_department set corpId = MY_CORPID where corpId is null;
    update h_org_role set corpId = MY_CORPID where corpId is null;
    update h_org_role_group set corpId = MY_CORPID where corpId is null;
    else
    SET IS_CLOUD_PIVOT = (select hss.paramValue from h_system_setting hss where hss.paramCode = 'cloudpivot.load.is_cloud_pivot');
    if IS_CLOUD_PIVOT = '1' then
        update h_org_user set corpId = 'main' where corpId is null;
        update h_org_department set corpId = 'main' where corpId is null;
        update h_org_role set corpId = 'main' where corpId is null;
        update h_org_role_group set corpId = 'main' where corpId is null;
    end if;
end if;

END &&

DELIMITER ;

CALL updateCorpIdIsNull();


ALTER TABLE `h_biz_sheet` MODIFY COLUMN `tempAuthSchemaCodes` varchar(3500) DEFAULT NULL COMMENT '临时授权的SchemaCode 以,分割';

-- 1.7版本
ALTER TABLE `biz_workitem` ADD COLUMN `isTrust` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托，0：否；1：是';
ALTER TABLE `biz_workitem` ADD COLUMN `trustor` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人ID';
ALTER TABLE `biz_workitem` ADD COLUMN `trustorName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人名称';

ALTER TABLE `biz_workitem_finished` ADD COLUMN `isTrust` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托，0：否；1：是';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `trustor` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人ID';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `trustorName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人名称';

ALTER TABLE `biz_workflow_instance` ADD COLUMN `isTrustStart` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托发起，0：否；1：是';
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trustee` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人ID';
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trusteeName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人名称';


CREATE TABLE `h_workflow_trust` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `workflowTrustRuleId` varchar(42) COLLATE utf8_bin NOT NULL,
    `workflowCode` varchar(40) COLLATE utf8_bin NOT NULL,
    `creater` varchar(42) COLLATE utf8_bin DEFAULT NULL,
    `createTime` datetime DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `IDX_PROXY_RULE_WFCODE` (`workflowTrustRuleId`,`workflowCode`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='流程委托表';

CREATE TABLE `h_workflow_trust_rule` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `trustor` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '委托人id',
    `trustorName` varchar(80) CHARACTER SET utf8mb4 NOT NULL COMMENT '委托人名称',
    `trustee` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '受托人id',
    `trusteeName` varchar(80) CHARACTER SET utf8mb4 NOT NULL COMMENT '受托人名称',
    `trustType` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '委托类型，流程审批：APPROVAL；流程发起：START',
    `startTime` datetime DEFAULT NULL COMMENT '委托开始时间',
    `endTime` datetime DEFAULT NULL COMMENT '委托结束时间',
    `rangeType` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '委托范围类型，全部：ALL；部分：PART',
    `state` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '委托规则状态，RUN;STOP',
    `creater` varchar(42) COLLATE utf8_bin DEFAULT NULL,
    `createTime` datetime DEFAULT NULL,
    `modifier` varchar(42) COLLATE utf8_bin DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `IDX_WF_TRUSTOR` (`trustor`),
    KEY `IDX_WF_TRUSTEE` (`trustee`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='流程、任务委托规则';


CREATE TABLE `h_biz_database_pool` (
    `id` varchar(120) NOT NULL,
    `creater` varchar(120) DEFAULT NULL,
    `createdTime` datetime DEFAULT NULL,
    `deleted` bit(1) DEFAULT NULL,
    `modifier` varchar(120) DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    `remarks` varchar(200) DEFAULT NULL,
    `code` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '数据库连接池编码',
    `name` varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT '数据库连接池名称',
    `description` varchar(2000) DEFAULT NULL COMMENT '描述',
    `databaseType` varchar(15) NOT NULL COMMENT '数据库类型',
    `jdbcUrl` varchar(200) DEFAULT NULL COMMENT '数据库连接串',
    `username` varchar(40) DEFAULT NULL COMMENT '账号',
    `password` varchar(40) DEFAULT NULL COMMENT '密码',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务数据库连接池';


ALTER TABLE `biz_workflow_instance` DROP COLUMN `isTrustStart`;
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trustType` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托类型，流程审批：APPROVAL；流程发起：START';

ALTER TABLE `h_org_user` ADD COLUMN `position` varchar(80) DEFAULT NULL COMMENT '职位';


ALTER TABLE `h_perm_biz_function` ADD COLUMN `editOwnerAble` BIT(1) DEFAULT NULL COMMENT '更新拥有者';

CREATE TABLE `h_log_synchro` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `trackId` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '同步批次',
    `creater` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
    `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
    `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步开始时间',
    `endTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步结束时间',
    `fixer` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '修复人',
    `fixedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新的修复时间',
    `fixedCount` int(11) NOT NULL DEFAULT 0 COMMENT '修复次数',
    `fixNotes` varchar(1000) CHARACTER SET utf8mb4 NOT NULL COMMENT '修复说明',
    `fixedStatus` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '修复状态',
    `executeStatus` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '执行状态',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='组织同步操作日志';

ALTER TABLE `h_org_synchronize_log` ADD COLUMN `corpId` varchar(120) DEFAULT NULL COMMENT '组织corpId';

ALTER TABLE `h_org_synchronize_log` ADD COLUMN `status` varchar(40) DEFAULT NULL COMMENT '状态';


ALTER TABLE `h_biz_database_pool` MODIFY `password` varchar(300)  DEFAULT NULL ;


ALTER TABLE `h_biz_property`
    ADD INDEX `Idx_schemaCode` (`schemaCode`) USING BTREE ;

ALTER TABLE `h_biz_schema`
    ADD INDEX `idx_schemaCode` (`code`) USING BTREE ;

CREATE TABLE IF NOT EXISTS `h_business_rule` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `node` longtext,
  `route` longtext,
  `schedulerSetting` longtext,
  `bizRuleType` varchar(15) DEFAULT NULL,
  `defaultRule` bit(1) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `h_log_business_rule_header` (
  `id` varchar(120) NOT NULL,
  `businessRuleCode` varchar(40) DEFAULT NULL,
  `businessRuleName` varchar(200) DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `originator` varchar(40) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `success` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `h_log_business_rule_content` (
  `id` varchar(120) NOT NULL,
  `exceptionContent` longtext,
  `exceptionNodeCode` varchar(120) DEFAULT NULL,
  `exceptionNodeName` varchar(200) DEFAULT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `triggerCoreData` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `h_log_business_rule_node` (
  `id` varchar(120) NOT NULL,
  `endTime` datetime DEFAULT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `nodeCode` varchar(120) DEFAULT NULL,
  `nodeInstanceId` varchar(120) DEFAULT NULL,
  `nodeName` varchar(200) DEFAULT NULL,
  `nodeSequence` int(11) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `h_log_business_rule_data_trace` (
  `id` varchar(120) NOT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `nodeCode` varchar(120) DEFAULT NULL,
  `nodeInstanceId` varchar(120) DEFAULT NULL,
  `nodeName` varchar(200) DEFAULT NULL,
  `ruleTriggerActionType` varchar(40) DEFAULT NULL,
  `targetObjectId` varchar(120) DEFAULT NULL,
  `targetSchemaCode` varchar(40) DEFAULT NULL,
  `traceLastData` longtext,
  `traceSetData` longtext,
  `traceUpdateDetail` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



ALTER TABLE `h_im_message` ADD COLUMN `externalLink` bit(1) DEFAULT NULL COMMENT '是否是外部链接';
ALTER TABLE `h_im_message_history` ADD COLUMN `externalLink` bit(1) DEFAULT NULL COMMENT '是否是外部链接';

ALTER TABLE `h_biz_schema` ADD COLUMN `businessRuleEnable` bit(1) DEFAULT 0;

ALTER TABLE `h_business_rule`
MODIFY COLUMN `node`  longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL AFTER `modifier`;


ALTER TABLE `h_workflow_header` ADD COLUMN `externalLinkEnable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启外链';
ALTER TABLE `h_workflow_header` ADD COLUMN `shortCode` varchar(50) DEFAULT NULL COMMENT '外链短码';
ALTER TABLE `h_log_business_rule_content`
    MODIFY COLUMN `triggerCoreData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL AFTER `flowInstanceId`;


ALTER TABLE `h_log_business_rule_data_trace`
    MODIFY COLUMN `traceLastData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL AFTER `targetSchemaCode`,
    MODIFY COLUMN `traceSetData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL AFTER `traceLastData`,
    MODIFY COLUMN `traceUpdateDetail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL AFTER `traceSetData`;


ALTER TABLE `h_log_business_rule_header`
    ADD INDEX `idx_h_log_business_rule_header_flowInstanceId` (`flowInstanceId`) USING BTREE ;

ALTER TABLE `h_log_business_rule_content`
    ADD INDEX `idx_h_log_business_rule_content_flowInstanceId` (`flowInstanceId`) USING BTREE ;

ALTER TABLE `h_log_business_rule_node`
    ADD INDEX `idx_h_log_business_rule_node_flowInstanceId` (`flowInstanceId`) USING BTREE ;

ALTER TABLE `h_log_business_rule_data_trace`
    ADD INDEX `idx_h_log_business_rule_data_trace_flowInstanceId` (`flowInstanceId`) USING BTREE ;

UPDATE h_biz_schema SET `businessRuleEnable`=0 WHERE 1=1;

ALTER TABLE `h_perm_admin`
    ADD COLUMN `parentId` varchar(120) COLLATE utf8_bin NULL COMMENT '基于哪个创建的' AFTER `userId`;

ALTER TABLE `h_perm_department_scope`
    MODIFY COLUMN `name`  varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `adminId`;


ALTER TABLE `biz_workflow_instance` ADD COLUMN `schemaCode` varchar(40) DEFAULT NULL COMMENT '模型编码';

-- 冗余schemaCode
update biz_workflow_instance w SET w.schemaCode = (
    SELECT t.schemaCode FROM h_workflow_header t WHERE w.workflowCode=t.workflowCode
) where id is not null;
UPDATE h_biz_schema SET `businessRuleEnable`=1 where id is not null;

ALTER TABLE `h_business_rule`
    MODIFY COLUMN `id` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL FIRST,
    MODIFY COLUMN `creater` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `createdTime`,
    MODIFY COLUMN `modifier` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `modifiedTime`,
    MODIFY COLUMN `bizRuleType` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `schedulerSetting`,
    MODIFY COLUMN `code` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `defaultRule`,
    MODIFY COLUMN `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `code`,
    MODIFY COLUMN `schemaCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `name`,
    MODIFY COLUMN `remarks` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `schemaCode`;

ALTER TABLE `h_log_business_rule_header`
    MODIFY COLUMN `schemaCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `originator`,
    ADD COLUMN `sourceFlowInstanceId` varchar(120) NULL AFTER `success`,
    ADD COLUMN `repair` bit(1) NULL DEFAULT NULL AFTER `sourceFlowInstanceId`,
    ADD COLUMN `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL AFTER `repair`;

-- 1.8版本
ALTER TABLE `h_org_department` MODIFY COLUMN `queryCode` VARCHAR(255);

ALTER TABLE `biz_workitem` ADD COLUMN `batchOperate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许批量处理，0：否；1：是';

ALTER TABLE `biz_workitem_finished` ADD COLUMN `batchOperate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许批量处理，0：否；1：是';

ALTER TABLE `h_workflow_header` ADD COLUMN `visibleType` varchar(40) NOT NULL DEFAULT 'PART_VISIABLE'
COMMENT '流程可见范围类型，ALL_VISIABLE: 全部人员可见， PART_VISIABLE：部分可见';

ALTER TABLE `h_biz_database_pool`
ADD COLUMN `driverClassName` varchar(50) NULL AFTER `databaseType`;

ALTER TABLE `h_biz_service`
    ADD COLUMN `isShared`  bit(1) NULL DEFAULT 0 COMMENT '是否共享，0-私有，1共享' AFTER `serviceCategoryId`,
ADD COLUMN `userIds`  longtext CHARACTER SET utf8 NULL COMMENT '用戶id，多個用戶用逗號隔開' AFTER `isShared`;
ALTER TABLE `biz_workflow_instance`
    ADD COLUMN `dataType`  varchar(20) NOT NULL DEFAULT 'NORMAL' COMMENT '数据类型，正常：NORMAL；模拟：SIMULATIVE',
ADD COLUMN `runMode`  varchar(20) NOT NULL DEFAULT 'MANUAL' COMMENT '运行模式，自动：AUTO；手动：MANUAL';
ALTER TABLE `h_biz_property`
    ADD COLUMN `relativeQuoteCode`  mediumtext  DEFAULT NULL COMMENT '关联表单引用属性' ;
ALTER TABLE `h_biz_service` CHANGE `isShared` `shared` bit(1);
ALTER TABLE `biz_workflow_token` ADD COLUMN `isSkipped` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否直接跳过';

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

-- 1.9版本

CREATE TABLE `h_biz_object_relation` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `srcSc` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '源模型编码',
  `srcId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '源i表id',
  `srcParentSc` varchar(42) COLLATE utf8_bin DEFAULT NULL,
  `srcParentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '如果srcSchemaCode是子表，则此字段是主表的id',
  `targetSc` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '目标模型编码',
  `targetId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '目标i表id',
  `targetParentSc` varchar(42) COLLATE utf8_bin DEFAULT NULL,
  `targetParentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '如果targetSchemaCode是子表，则此字段是主表的id',
  `createTime` datetime NOT NULL,
  `sortBy` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sc_id` (`targetSc`,`targetId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='两个i表数据的关联关系，source-->target : 1->N';


ALTER TABLE `biz_workitem` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_circulateitem` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_circulateitem_finished` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';


ALTER TABLE `h_biz_property`
ADD COLUMN `repeated`  int NULL DEFAULT 0 COMMENT '去重属性：1开启0不开启' AFTER `relativeQuoteCode`;

-- 6.0.0
ALTER TABLE `h_biz_rule_effect`
ADD INDEX `idx_trigger_id` (`triggerId`) USING BTREE ;

ALTER TABLE `h_biz_property`
ADD COLUMN `selectionJson` longtext NULL COMMENT '下拉框存值' AFTER `repeated`;

ALTER TABLE `h_org_synchronize_log`
ADD COLUMN `isSyncRoleScope`  tinyint NULL DEFAULT 0 AFTER `status`;

ALTER table h_perm_biz_function add column batchPrintAble bit(1) default null comment '批量打印';


ALTER TABLE `h_biz_attachment`
ADD COLUMN `base64ImageStr` longtext NULL COMMENT 'base64图片' AFTER `fileSize`;

ALTER TABLE `h_from_comment_attachment`
ADD COLUMN `base64ImageStr` longtext NULL COMMENT 'base64图片' AFTER `fileSize`;
-- 6.1.0
DELIMITER $$
CREATE FUNCTION `fristPinyin`(P_NAME VARCHAR(255)) RETURNS varchar(255) CHARSET utf8
DETERMINISTIC
BEGIN
    DECLARE V_RETURN VARCHAR(255);
    DECLARE V_BOOL INT DEFAULT 0;
          DECLARE FIRST_VARCHAR VARCHAR(1);

    SET FIRST_VARCHAR = left(CONVERT(P_NAME USING gbk),1);
    SELECT FIRST_VARCHAR REGEXP '[a-zA-Z]' INTO V_BOOL;
    IF V_BOOL = 1 THEN
      SET V_RETURN = FIRST_VARCHAR;
    ELSE
      SET V_RETURN = ELT(INTERVAL(CONV(HEX(left(CONVERT(P_NAME USING gbk),1)),16,10),
          0xB0A1,0xB0C5,0xB2C1,0xB4EE,0xB6EA,0xB7A2,0xB8C1,0xB9FE,0xBBF7,
          0xBFA6,0xC0AC,0xC2E8,0xC4C3,0xC5B6,0xC5BE,0xC6DA,0xC8BB,
          0xC8F6,0xCBFA,0xCDDA,0xCEF4,0xD1B9,0xD4D1),
      'a','b','c','d','e','f','g','h','j','k','l','m','n','o','p','q','r','s','t','w','x','y','z');
    END IF;
    RETURN V_RETURN;
END $$
DELIMITER ;


drop table if exists h_biz_datasource_category;

/*==============================================================*/
/* Table: h_biz_datasource_category                             */
/*==============================================================*/
create table h_biz_datasource_category
(
   id                   varchar(128) not null comment '主键',
   createdTime          datetime default CURRENT_TIMESTAMP comment '创建时间',
   modifiedTime         datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   name                 varchar(128) not null default '‘’' comment '目录名称',
   primary key (id)
)ENGINE = InnoDB COLLATE = utf8_general_ci;

alter table h_biz_datasource_category comment '第三方数据源目录';


drop table if exists h_biz_datasource_method;

/*==============================================================*/
/* Table: h_biz_datasource_method                               */
/*==============================================================*/
create table h_biz_datasource_method
(
   id                   varchar(128) not null comment '主键',
   createdTime          datetime default CURRENT_TIMESTAMP comment '创建时间',
   creater              varchar(128) comment '链接名称创建者',
   modifier             varchar(128) comment '修改者',
   modifiedTime         datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   deleted              bit comment '删除标志',
   remarks              varchar(256) comment '备注',
   code                 varchar(32) not null default '' comment '编码',
   name                 varchar(256) not null default '' comment '名称',
   sqlConfig            varchar(512) not null default '' comment 'sql执行语句',
   datasourceCategoryId varchar(128) not null default '' comment '集成目录ID',
   dataBaseConnectId    varchar(128) not null default '' comment '数据源Id',
   reportObjectId       varchar(32) not null default '' comment '自定义SQL高级数据源的唯一标志',
   reportTableName      varchar(32) not null default '' comment '报表数据源表别名',
   primary key (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

alter table h_biz_datasource_method comment '第三方数据源方法';

/*==============================================================*/
/* Index: uk_code                                               */
/*==============================================================*/
create unique index uk_code on h_biz_datasource_method
(
   code
);

-- auto-generated definition
create table h_org_user_extend_attr
(
    id           varchar(120)               not null comment '主键ID',
    name         varchar(255) default ''    null comment '扩展字段名称',
    code         varchar(120) default ''    null comment '编码code',
    mapKey       varchar(120) default ''    null comment '映射key',
    enable       tinyint(1)   default 0     null comment '是否启用 0：否  1：是',
    belong       varchar(120) default ''    null comment '所属分组',
    corpId       varchar(128) default 'ALL' null comment '组织ID',
    deleted      tinyint(1)   default 1     null comment '是否删除  0：否  1：是',
    createdBy    varchar(120) default ''    null comment '创建者',
    createdTime  datetime                   null comment '创建时间',
    modifiedBy   varchar(120)               null comment '修改者',
    modifiedTime datetime                   null comment '修改时间',
    constraint UK_code_corpId
        unique (code, corpId)
);

create index IDX_corpId
    on h_org_user_extend_attr (corpId);

-- auto-generated definition
create table h_org_user_union_extend_attr
(
    id           varchar(120)             not null comment '主键ID',
    userId       varchar(120) default ''  null comment '用户主键ID',
    extendAttrId varchar(120) default ''  null comment '扩展属性ID',
    mapVal       varchar(500) default '0' null comment '映射值',
    deleted      tinyint(1)   default 1   null comment '是否删除  0：否  1：是',
    createdBy    varchar(128) default ''  null comment '创建者',
    createdTime  datetime                 null comment '创建时间',
    modifiedBy   varchar(128)             null comment '修改者',
    modifiedTime datetime                 null comment '修改时间',
    constraint UK_userId_attrId
        unique (userId, extendAttrId)
);

create index IDX_extendAttrId
    on h_org_user_union_extend_attr (extendAttrId);

create index IDX_userId
    on h_org_user_union_extend_attr (userId);


alter table h_perm_admin
    add appManage bit null comment '是否拥有创建应用的权限';

UPDATE h_org_role SET corpId='main' WHERE roleType='SYS';

create unique index uq_schemaCode_code on h_biz_property (schemaCode, code);

alter table h_related_corp_setting
    add enabled bit null comment '是否禁用';
alter table h_org_user
    add enabled bit null comment '是否禁用';
alter table h_org_department
    add enabled bit null comment '是否禁用';
update h_related_corp_setting set enabled = 1 where id != '';
update h_org_user set enabled = 1 where id != '';
update h_org_department set enabled = 1 where id != '';

CREATE TABLE IF NOT EXISTS `h_biz_sheet_history` (
 `id` varchar(120) NOT NULL,
 `createdTime` datetime DEFAULT NULL,
 `creater` varchar(120) DEFAULT NULL,
 `deleted` bit(1) DEFAULT NULL,
 `modifiedTime` datetime DEFAULT NULL,
 `modifier` varchar(120) DEFAULT NULL,
 `remarks` varchar(200) DEFAULT NULL,
 `code` varchar(40) DEFAULT NULL,
 `draftAttributesJson` longtext,
 `draftViewJson` longtext,
 `icon` varchar(50) DEFAULT NULL,
 `mobileIsPc` bit(1) DEFAULT NULL,
 `mobileUrl` varchar(500) DEFAULT NULL,
 `name` varchar(50) DEFAULT NULL,
 `pcUrl` varchar(500) DEFAULT NULL,
 `printIsPc` bit(1) DEFAULT NULL,
 `printUrl` varchar(500) DEFAULT NULL,
 `published` bit(1) DEFAULT NULL,
 `publishedAttributesJson` longtext,
 `publishedViewJson` longtext,
 `schemaCode` varchar(40) DEFAULT NULL,
 `sheetType` varchar(50) DEFAULT NULL,
 `sortKey` int(11) DEFAULT NULL,
 `serialCode` varchar(255) DEFAULT NULL,
 `serialResetType` varchar(40) DEFAULT NULL,
 `externalLinkAble` bit(1) DEFAULT NULL,
 `name_i18n` varchar(1000) DEFAULT NULL,
 `draftHtmlJson` longtext DEFAULT NULL,
 `publishedHtmlJson` longtext DEFAULT NULL,
 `draftActionsJson` longtext DEFAULT NULL,
 `publishedActionsJson` longtext DEFAULT NULL,
 `shortCode` varchar(50) DEFAULT NULL,
 `printTemplateJson` varchar(1000) DEFAULT NULL,
 `qrCodeAble` varchar(40) DEFAULT NULL,
 `tempAuthSchemaCodes` varchar(3500) DEFAULT NULL,
 `borderMode` varchar(10) DEFAULT NULL,
 `layoutType` varchar(20) DEFAULT NULL,
 `formComment` bit(1) DEFAULT NULL,
 `pdfAble` varchar(40) DEFAULT NULL,
 `publishBy` varchar(120) DEFAULT NULL,
 `version` int(20) DEFAULT 1,
 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER table h_biz_query_action add column extend1 varchar(100) default null;


-- auto-generated definition
create table h_perm_selection_scope
(
    id                varchar(120) not null
        primary key,
    createdTime       datetime     null,
    creater           varchar(120) null,
    deleted           bit          null,
    modifiedTime      datetime     null,
    modifier          varchar(120) null,
    remarks           varchar(200) null,
    departmentId      varchar(120) null,
    deptVisibleType   varchar(40)  null,
    deptVisibleScope  longtext     null,
    staffVisibleType  varchar(40)  null,
    staffVisibleScope longtext     null
)
    charset = utf8;


alter table h_org_role_group
	add parentId varchar(120) null comment '上一级角色组id';

/*==============================================================*/
/* Table: h_org_inc_sync_record                                 */
/*==============================================================*/
create table h_org_inc_sync_record
(
   id                   varchar(120) not null,
   syncSourceType       char(10) default 'DINGTALK' comment '同步源类型，钉钉|企业微信 等 默认为钉钉',
   createTime           datetime default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   corpId               varchar(120) default NULL comment '组织corpId',
   eventType            varchar(50) default NULL comment '钉钉回调事件类型',
   eventInfo            text comment '事件数据',
   handleStatus         varchar(20) default NULL comment '处理状态',
   retryCount           int(11) default NULL comment '重试次数',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_bin;

alter table h_org_inc_sync_record comment '增量同步记录表';

ALTER TABLE h_business_rule ADD enabled bit(1) NULL DEFAULT NULL comment '是否生效';
ALTER TABLE h_business_rule ADD quoteProperty longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL comment '引用编码 数据模型编码.数据项编码 ,分割';

update h_business_rule set enabled = 1 where enabled is null;

CREATE TABLE `h_business_rule_runmap` (
  `id` varchar(120) NOT NULL COMMENT '主键',
  `ruleCode` varchar(40) NOT NULL COMMENT '规则编码',
  `ruleName` varchar(100) DEFAULT NULL COMMENT '规则名称',
  `ruleType` varchar(15) NOT NULL COMMENT '规则类型',
  `nodeCode` varchar(40) NOT NULL COMMENT '节点编码',
  `nodeName` varchar(100) DEFAULT NULL COMMENT '节点名称',
  `nodeType` varchar(15) NOT NULL COMMENT '节点类型',
  `targetSchemaCode` varchar(40) NOT NULL COMMENT '目标对象模型编码',
  `triggerSchemaCode` varchar(40) NOT NULL COMMENT '触发对象模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


alter table h_biz_service_category add createdBy varchar(120) comment '创建人';
alter table h_biz_service_category add modifiedBy varchar(120) comment '更新人';
alter table h_biz_datasource_category add createdBy varchar(120) comment '创建人';
alter table h_biz_datasource_category add modifiedBy varchar(120) comment '更新人';

alter table h_biz_perm_property
    add encryptVisible bit null comment '是否可见加密';

update h_biz_perm_property set encryptVisible = 0 where id != '';

alter table h_biz_property
    add encryptOption bit null comment '加密类型';


alter table h_app_package
	add groupId varchar(120) null comment '应用分组id';

DROP TABLE IF EXISTS `h_app_group`;
CREATE TABLE `h_app_group`  (
  `id` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createdTime` datetime(0) NULL DEFAULT NULL,
  `creater` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT NULL,
  `modifiedTime` datetime(0) NULL DEFAULT NULL,
  `modifier` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remarks` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `code` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `disabled` bit(1) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sortKey` int(11) NULL DEFAULT NULL,
  `name_i18n` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '双语言',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO `h_app_group`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `remarks`, `code`, `disabled`, `name`, `sortKey`, `name_i18n`) VALUES ('2c928fe6785dbfbb01785dc6277a0000', '2021-03-23 14:29:31', '2c9280a26706a73a016706a93ccf002b', b'0', '2021-03-23 14:29:31', NULL, NULL, 'default', NULL, '默认', 1, NULL);
INSERT INTO `h_app_group`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `remarks`, `code`, `disabled`, `name`, `sortKey`, `name_i18n`) VALUES ('2c928fe6785dbfbb01785dc6277a0001', '2021-04-26 17:50:31', '2c9280a26706a73a016706a93ccf002b', b'0', '2021-04-26 17:50:31', NULL, NULL, 'all', NULL, '全部', 0, NULL);

update h_app_package set groupId='2c928fe6785dbfbb01785dc6277a0000' where groupId is null or groupId='';

create table h_org_direct_manager
(
    id           varchar(120)                           not null
        primary key,
    createdTime  datetime     default CURRENT_TIMESTAMP null comment '创建时间',
    creater      varchar(120) default ''                null comment '创建人',
    modifiedTime datetime     default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '修改时间',
    modifier     varchar(120) default ''                null comment '修改人',
    remarks      varchar(200) default ''                null comment '备注',
    userId       varchar(36)  default ''                not null comment '用户id',
    deptId       varchar(36)  default ''                not null comment '部门id',
    managerId    varchar(36)  default ''                not null comment '直属主管id',
    constraint uq_direct_user_dept
        unique (userId, deptId)
)
    comment '直属主管配置表';

ALTER TABLE h_biz_sheet ADD COLUMN printJson longtext comment '打印模板json';

alter table h_biz_property add options longtext null comment '数据项属性';

DROP TABLE IF EXISTS `h_biz_data_rule`;
CREATE TABLE `h_biz_data_rule`  (
  `id` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `creater` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createdTime` datetime(0) NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT NULL,
  `modifier` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modifiedTime` datetime(0) NULL DEFAULT NULL,
  `remarks` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `schemaCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `propertyCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `options` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `dataRuleType` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `checkType` int(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据规则' ROW_FORMAT = Dynamic;

alter table h_biz_export_task add refId varchar(200) null comment '附件id';
alter table h_biz_export_task add schemaCode varchar(200) null comment '数据模型编码';
alter table h_biz_export_task add expireTime datetime(0) null comment '过期时间';

ALTER TABLE h_biz_sheet ADD formTrack bit(1) NULL DEFAULT NULL comment '是否开启表单留痕';
ALTER TABLE h_biz_sheet ADD trackDataCodes longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL comment '需要留痕的表单数据项code,用 ; 号分割';

ALTER TABLE h_biz_sheet_history ADD formTrack bit(1) NULL DEFAULT NULL comment '是否开启表单留痕';
ALTER TABLE h_biz_sheet_history ADD trackDataCodes longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL comment '需要留痕的表单数据项code,用 ; 号分割';

ALTER TABLE h_perm_admin ADD dataDictionaryManage bit(1) NULL DEFAULT NULL comment '是否有数据字典管理权限';

update h_biz_sheet set formTrack = 0 where formTrack is null or formTrack = '';
update h_biz_sheet_history set formTrack = 0 where formTrack is null or formTrack = '';
update h_perm_admin set dataDictionaryManage = 0 where dataDictionaryManage is null or dataDictionaryManage ='';

CREATE TABLE `h_data_dictionary` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT b'0',
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `code` varchar(50) DEFAULT NULL COMMENT '字典编码',
  `dictionaryType` varchar(40) DEFAULT NULL COMMENT '字典类型',
  `sortKey` int(11) DEFAULT NULL COMMENT '排序值',
  `status` bit(1) DEFAULT NULL COMMENT '启用状态',
  `classificationId` varchar(120) DEFAULT NULL COMMENT '所属分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE `h_dictionary_class` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '字典分类名',
  `sortKey` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE `h_dictionary_record` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '字典数据名称',
  `code` varchar(50) DEFAULT NULL COMMENT '字典数据编码',
  `dictionaryId` varchar(120) DEFAULT NULL COMMENT '所属字典ID',
  `sortKey` int(11) DEFAULT NULL,
  `parentId` varchar(120) DEFAULT NULL COMMENT '上级字典数据ID',
  `status` bit(1) DEFAULT NULL COMMENT '字典数据启用状态',
  `initialUsed`  bit(1) DEFAULT NULL COMMENT '字典数据历史使用状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE `h_biz_data_track` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL COMMENT '留痕的表单名称',
  `bizObjectId` varchar(120) DEFAULT NULL COMMENT '留痕的表单ID',
  `departmentId` varchar(120) DEFAULT NULL COMMENT '此次留痕记录的修改人部门',
  `departmentName` varchar(50) DEFAULT NULL COMMENT '此次留痕记录的修改人部门名称',
  `creatorName` varchar(50) DEFAULT NULL COMMENT '此次留痕记录的修改人',
  `schemaCode` varchar(40) DEFAULT NULL COMMENT '所属数据模型编码',
  `sheetCode` varchar(40) DEFAULT NULL COMMENT '所属表单编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE `h_biz_data_track_detail` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `trackId` varchar(120) DEFAULT NULL COMMENT '留痕记录ID',
  `bizObjectId` varchar(120) DEFAULT NULL COMMENT '留痕的表单ID',
  `name` varchar(50) DEFAULT NULL COMMENT '留痕的字段名称',
  `beforeValue` longtext DEFAULT NULL COMMENT '留痕字段新值',
  `afterValue` longtext DEFAULT NULL COMMENT '留痕字段旧值',
  `type` varchar(40) DEFAULT NULL COMMENT '留痕字段类型',
  `departmentName` varchar(50) DEFAULT NULL COMMENT '此次留痕记录的修改人部门名称',
  `creatorName` varchar(50) DEFAULT NULL COMMENT '此次留痕记录的修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

alter table h_biz_sheet add formSystemVersion varchar(32) null comment '系统版本号';

alter table h_biz_sheet add draftSchemaOptionsJson longtext;
alter table h_biz_perm_group add appPermGroupId varchar(120) null comment '关联的应用管理权限组ID';

ALTER TABLE h_perm_admin ADD COLUMN roleManage bit(1) comment '角色管理权限';
UPDATE h_perm_admin SET roleManage = TRUE WHERE adminType IN ('SYS_MNG', 'ADMIN');

CREATE TABLE `h_perm_admin_group` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `departmentsJson` longtext,
  `name` varchar(50) DEFAULT NULL,
  `appPackagesJson` longtext,
  `adminId` varchar(120) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `h_biz_batch_update_record`;
CREATE TABLE `h_biz_batch_update_record`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schemaCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `propertyCode` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userId` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modifiedTime` datetime(0) NULL DEFAULT NULL,
  `propertyName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `total` int(10) NULL DEFAULT NULL,
  `successCount` int(10) NULL DEFAULT NULL,
  `failCount` int(10) NULL DEFAULT NULL,
  `modifiedValue` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '列表数据批量修改记录' ROW_FORMAT = Dynamic;


ALTER table h_perm_biz_function add column batchUpdateAble bit(1) default null comment '批量修改';


create table h_report_datasource_permission
(
   id                   varchar(32) not null,
   creater              varchar(32) default NULL,
   createdTime          datetime default NULL,
   modifier             varchar(32) default NULL,
   modifiedTime         datetime default NULL,
   remarks              varchar(256) default NULL,
   objectId             varchar(64) comment '数据流节点',
   userScope            longtext comment '用户使用范围',
   ownerId              varchar(32),
   nodeType             bit comment '节点类型',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_bin;

alter table h_report_datasource_permission comment '报表高级数据源权限设置';

/*==============================================================*/
/* Index: uq_object_id                                          */
/*==============================================================*/
create unique index uq_object_id on h_report_datasource_permission
(
   objectId
);

ALTER TABLE h_biz_datasource_method ADD COLUMN shared bit(1);
ALTER TABLE h_biz_datasource_method ADD COLUMN userIds longtext;

-- 6.6
DROP TABLE IF EXISTS `h_user_common_comment`;
CREATE TABLE `h_user_common_comment` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `content` varchar(4000) DEFAULT NULL,
  `sortKey` int(11) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户常用意见表';

-- 6.7
DROP TABLE IF EXISTS `h_system_notify_setting`;
CREATE TABLE `h_system_notify_setting` (
  `id` varchar(120) NOT NULL,
  `corpId` varchar(120) DEFAULT NULL,
  `unitType` varchar(20) DEFAULT NULL,
  `msgChannelType` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息推送设置表';

-- 批量向模型表中添加version字段
DROP PROCEDURE IF EXISTS addVersionParam;
-- 1.创建存储过程
DELIMITER &&
CREATE PROCEDURE `addVersionParam`(IN vDBName VARCHAR(100))
BEGIN
    DECLARE vSchemaCode VARCHAR(50) DEFAULT '';
    DECLARE vTableName VARCHAR(100) DEFAULT '';
    DECLARE vAlterSQL VARCHAR(500) DEFAULT '';
    DECLARE nCount int DEFAULT 0;
    DECLARE nCount2 int DEFAULT 0;
    DECLARE nCount3 int DEFAULT 0;
    DECLARE nCount4 int DEFAULT 0;
    DECLARE done INT DEFAULT 0;
    DECLARE taskCursor CURSOR FOR SELECT table_name
                                  FROM INFORMATION_SCHEMA.TABLES
                                  WHERE table_schema = vDBName and table_name LIKE "i%";
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN taskCursor;
    REPEAT
        FETCH taskCursor INTO vTableName;
        IF NOT done THEN
            set vSchemaCode = SUBSTR(vTableName, LOCATE('_', vTableName) + 1);
            -- 判断是否为模型相关表
            SELECT count(*) into nCount4 FROM h_biz_schema where `code` = vSchemaCode;
            if nCount4 > 0 THEN
                -- 判断表是否存在（可省略）
                SELECT count(*)
                into nCount3
                FROM information_schema.TABLES
                WHERE TABLE_SCHEMA = vDBName and table_name = vTableName;
                if nCount3 > 0 THEN
                    -- 判断该表是否存在该字段
                    SELECT count(*)
                    into nCount2
                    FROM information_schema.columns
                    WHERE TABLE_SCHEMA = vDBName
                      and table_name = vTableName
                      AND column_name = 'version';
                    if nCount2 = 0 THEN
                        SET vAlterSQL = concat('ALTER TABLE ', vTableName,
                                               ' ADD COLUMN `version` decimal(25, 8) default  0.00000000  COMMENT \'版本号\'');
                    ELSE
                        SET vAlterSQL = concat('ALTER TABLE ', vTableName,
                                               ' MODIFY COLUMN `version` decimal(25, 8) default  0.00000000  COMMENT \'版本号\'');
                    end if;
                    set @vSql = vAlterSQL;
                    PREPARE stmt FROM @vSql;
                    EXECUTE stmt;
                    select count(*)
                    into nCount
                    from h_biz_property
                    where lower(schemaCode) = vSchemaCode and `code` = 'version';
                    if nCount = 0 THEN
                        INSERT INTO `h_biz_property` (`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `code`,
                                                      `defaultProperty`, `defaultValue`, `name`, `propertyEmpty`,
                                                      `propertyIndex`, `propertyLength`, `propertyType`, `published`,
                                                      `relativeCode`, `schemaCode`, `repeated`)
                        VALUES (replace(uuid(), '-', ''), now(), NULL, false, now(), 'version', true, '0', '版本号', false,
                                false, 12, 'NUMERICAL', true, NULL, vSchemaCode, 0);
                    ELSE
                        UPDATE h_biz_property
                        set propertyType='NUMERICAL',
                            defaultValue='0',
                            `name`='版本号'
                        where schemaCode = vSchemaCode
                          and `code` = 'version';
                    end if;
                end if;
            end if;
        END IF;
    UNTIL done END REPEAT;
    CLOSE taskCursor;
END
;
&&
DELIMITER ;
-- 2.执行存储过程 !!! 默认当前库，可修改需要执行的库名
CALL addVersionParam(database());
-- 3.执行完删除
DROP PROCEDURE IF EXISTS addVersionParam;

alter table h_biz_database_pool add datasourceType varchar(40) null;
update h_biz_database_pool set datasourceType = 'DATABASE';
alter table h_biz_database_pool add externInfo longtext null;

alter table h_related_corp_setting add syncConfig varchar(2048) null;
alter table h_related_corp_setting add customizeRelateType varchar(64) null;
alter table h_related_corp_setting add mailListConfig varchar(2048) null;

alter table h_report_datasource_permission add parentObjectId varchar(64) null after objectId;

ALTER TABLE h_app_function
ADD INDEX idx_type_ac (type, appCode) USING BTREE;

-- 附件表refid索引
ALTER TABLE `h_biz_attachment` ADD INDEX idx_h_biz_attachment_refid(`refid`);

-- 流程模板 编码和版本号联合索引
ALTER TABLE `h_workflow_template` ADD INDEX `idx_workflow_template_code_verison` (`workflowCode`,`workflowVersion`);

-- 展示字段 视图id和排序值联合索引
ALTER TABLE `h_biz_query_column` ADD INDEX `idx_biz_query_column_queryId_sortKey` (`queryId`,`sortKey`);

-- 查询字段 视图id和排序值联合索引
ALTER TABLE `h_biz_query_condition` ADD INDEX `idx_biz_query_condition_queryId_sortKey` (`queryId`,`sortKey`);

-- 用户表 账号名和组织id联合索引
ALTER TABLE `h_org_user` ADD INDEX `idx_org_user_username_corpid` (`username`,`corpId`);

ALTER TABLE h_user_favorites
MODIFY COLUMN bizObjectType varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
MODIFY COLUMN appCode varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

ALTER TABLE h_perm_admin_group ADD externalLinkVisible bit(1) NOT NULL DEFAULT TRUE COMMENT '是否可查看外链';

ALTER TABLE h_app_package ADD fromAppMarket bit(1) COMMENT '是否来自应用市场';

-- 视图多模型查询

ALTER TABLE h_biz_query_present
ADD COLUMN queryViewDataSource longtext NULL COMMENT '视图属性-数据源' AFTER columnsJson,
ADD COLUMN schemaRelations longtext NULL COMMENT '视图多模型查询，关联关系' AFTER queryViewDataSource;

ALTER TABLE h_biz_query_column
ADD COLUMN schemaAlias varchar(100)  NULL DEFAULT NULL COMMENT '模型编码别名' AFTER clientType,
ADD COLUMN propertyAlias varchar(100) NULL DEFAULT NULL COMMENT '数据项编码别名' AFTER schemaAlias,
ADD COLUMN queryLevel int(4) NULL DEFAULT 1 COMMENT '查询批次 1-主表 2-子表' AFTER propertyAlias;

update h_biz_query_column set schemaAlias = schemaCode where schemaAlias is null ;
update h_biz_query_column set propertyAlias = propertyCode where propertyAlias is null;

ALTER TABLE h_open_api_event
ADD COLUMN options longtext NULL COMMENT '扩展参数' AFTER eventType;

alter table h_biz_datasource_method add inputParamConfig text null;

ALTER TABLE biz_workflow_instance
ADD COLUMN source varchar(255) NULL COMMENT '来源';

ALTER TABLE biz_workflow_instance_bak
ADD COLUMN source varchar(255) NULL COMMENT '来源';


CREATE TABLE `h_workflow_admin` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime(0) NULL DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime(0) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `adminType` varchar(120) DEFAULT NULL COMMENT '授权范围',
  `workflowCode` varchar(200) DEFAULT NULL COMMENT '流程编码',
  `manageScope` varchar(512) DEFAULT NULL COMMENT '流程运维范围',
  `options` longtext COMMENT '扩展参数',
  PRIMARY KEY (`id`),
  KEY `idx_work_admin_workflowCode` (`workflowCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `h_workflow_admin_scope`  (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime(0) DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime(0) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `adminId` varchar(120) DEFAULT NULL,
  `unitType` varchar(10) DEFAULT NULL,
  `unitId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_workflow_adminId`(`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE biz_workitem ADD COLUMN workItemSource  varchar(120) NULL COMMENT '任务来源';

ALTER TABLE biz_workitem_finished ADD COLUMN workItemSource  varchar(120) NULL COMMENT '任务来源';

ALTER TABLE h_biz_schema ADD COLUMN modelType varchar(40) NULL DEFAULT NULL COMMENT '模型类型 LIST/TREE';

CREATE TABLE `h_system_sms_template` (
    `id` varchar(120) NOT NULL,
    `type` varchar(20) NOT NULL COMMENT '1待办、2催办、3事件通知',
    `code` varchar(20) NOT NULL COMMENT '模板编码',
    `name` varchar(40) NOT NULL COMMENT '模板名称',
    `content` text NOT NULL COMMENT '模板内容',
    `params` longtext DEFAULT NULL COMMENT '参数说明',
    `enabled` bit(1) DEFAULT NULL COMMENT '是否启用',
    `defaults` bit(1) DEFAULT NULL COMMENT '是否默认',
    `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
    `deleted` bit(1) DEFAULT NULL COMMENT '是否删除',
    `creater` varchar(120) DEFAULT NULL,
    `createdTime` datetime DEFAULT NULL,
    `modifier` varchar(120) DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `h_system_sms_template` VALUES ('2c928ff67de11137017de119dec601c2', 'TODO', 'Todo', '默认待办通知', '您有新的流程待处理，流程标题：${name}，请及时处理！', '[{\"key\":\"name\",\"value\":\"\"}]', b'1', b'1', NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `h_system_sms_template` VALUES ('2c928ff67de11137017de11d5b3001c4', 'URGE', 'Remind', '默认催办通知', '您的流程任务被人催办，流程标题：${name}，催办人${creater}，请及时处理！', '[{\"key\":\"name\",\"value\":\"流程的标题\"},{\"key\":\"creater\",\"value\":\"流程发起人\"}]', b'1', b'1', NULL, b'0', NULL, NULL, NULL, NULL);

INSERT INTO `h_system_setting` VALUES ('c82a2b8d5d5c11ecb2370242ac110005', 'sms.todo.switch', 'false', 'SMS_CONF', b'1', null);
INSERT INTO `h_system_setting` VALUES ('c82d39a85d5c11ecb2370242ac110006', 'sms.urge.switch', 'false', 'SMS_CONF', b'1', null);

ALTER TABLE h_biz_export_task ADD COLUMN fileSize int(11) NULL COMMENT '文件大小';

ALTER TABLE h_im_message ADD COLUMN smsParams longtext NULL COMMENT '短信模板参数';
ALTER TABLE h_im_message ADD COLUMN smsCode varchar(50) NULL COMMENT '短信模板编码';

ALTER TABLE h_im_message_history ADD COLUMN smsParams longtext NULL COMMENT '短信模板参数';
ALTER TABLE h_im_message_history ADD COLUMN smsCode varchar(50) NULL COMMENT '短信模板编码';


ALTER TABLE h_system_pair ADD COLUMN objectId varchar(120) NULL COMMENT '数据id';
ALTER TABLE h_system_pair ADD COLUMN schemaCode varchar(40) NULL COMMENT '模型编码';
ALTER TABLE h_system_pair ADD COLUMN formCode varchar(40) NULL COMMENT '表单编码';
ALTER TABLE h_system_pair ADD COLUMN workflowInstanceId varchar(120) NULL COMMENT '流程实例ID';

ALTER TABLE h_system_pair ADD INDEX `idx_bid_fcode`(`objectId`, `formCode`);

-- 适配政务钉sourceId的长度
alter table h_org_user modify column sourceId varchar(180);
alter table h_org_department modify column sourceId varchar(180);
alter table h_org_role modify column sourceId varchar(180);
alter table h_org_role_group modify column sourceId varchar(180);
alter table h_org_department modify column sourceId varchar(180);
alter table h_org_department_history modify column sourceId varchar(180);