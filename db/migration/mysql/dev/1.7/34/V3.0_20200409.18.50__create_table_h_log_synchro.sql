CREATE TABLE `h_log_synchro` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `trackId` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '同步批次',
  `creater` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步开始时间',
  `endTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步结束时间',
  `fixer` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '修复人',
  `fixedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新的修复时间',
  `fixedCount` int(11) NOT NULL DEFAULT 0 COMMENT '修复次数',
  `fixNotes` varchar(1000) CHARACTER SET utf8mb4 NOT NULL COMMENT '修复说明',
  `fixedStatus` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '修复状态',
  `executeStatus` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '执行状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='组织同步操作日志';