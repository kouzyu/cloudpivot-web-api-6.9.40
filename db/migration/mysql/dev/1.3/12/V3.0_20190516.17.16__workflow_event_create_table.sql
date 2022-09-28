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