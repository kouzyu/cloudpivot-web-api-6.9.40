CREATE TABLE `h_im_urge_workitem` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL,
  `workitemId` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '代办id',
  `userId` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '催办用户id',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '催办时间',
  `modifyTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `urgeCount` int(255) NOT NULL DEFAULT '1' COMMENT '催办次数',
  PRIMARY KEY (`id`),
  KEY `IDX_URGE_ITEMID_USERID` (`workitemId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催办代办表';