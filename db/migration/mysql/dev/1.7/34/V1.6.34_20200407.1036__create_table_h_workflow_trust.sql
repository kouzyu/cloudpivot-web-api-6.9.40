
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
