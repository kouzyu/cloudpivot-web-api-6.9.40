ALTER TABLE `h_biz_export_task` CHANGE `syncResult` `exportResultStatus` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '同步结果';