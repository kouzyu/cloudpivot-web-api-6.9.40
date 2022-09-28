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