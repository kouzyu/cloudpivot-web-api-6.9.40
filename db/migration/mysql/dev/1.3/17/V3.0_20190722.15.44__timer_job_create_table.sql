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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='定时任务执行结果表';;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='定时任务表';;
