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

