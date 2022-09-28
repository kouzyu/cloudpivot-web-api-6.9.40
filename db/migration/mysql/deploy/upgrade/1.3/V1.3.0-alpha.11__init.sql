/*
Navicat MySQL Data Transfer

Source Server         : dev_back_120.79.187.180
Source Server Version : 50724
Source Host           : 120.79.187.180:3306
Source Database       : h3bpm_dev

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-04-17 16:21:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for base_security_client
-- ----------------------------
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
  `options`           varchar(500)  DEFAULT NULL,
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
  `gender` varchar(5) DEFAULT NULL,
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
