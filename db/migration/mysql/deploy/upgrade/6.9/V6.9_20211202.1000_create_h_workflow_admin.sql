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
