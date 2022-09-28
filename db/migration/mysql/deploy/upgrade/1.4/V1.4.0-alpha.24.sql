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
