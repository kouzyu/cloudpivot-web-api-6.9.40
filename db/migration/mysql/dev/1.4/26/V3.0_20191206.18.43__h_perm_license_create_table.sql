CREATE TABLE `h_perm_license` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `bizId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '授权的业务id',
  `bizType` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '业务类型，USER：用户；DEPART：部门；ROLE：角色',
  `createdTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
