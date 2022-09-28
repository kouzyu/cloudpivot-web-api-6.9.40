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