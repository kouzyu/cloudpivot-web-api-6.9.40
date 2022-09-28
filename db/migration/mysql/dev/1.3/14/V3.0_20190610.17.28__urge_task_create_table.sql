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