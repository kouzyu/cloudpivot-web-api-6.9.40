CREATE TABLE IF NOT EXISTS `h_org_synchronize_log`(
  `id` varchar(120) NOT NULL,
  `targetType` varchar(30) DEFAULT NULL COMMENT '同步类型 部门|用户|角色|某个部门|某个角色用户',
  `trackId` varchar(60) DEFAULT NULL COMMENT '同步批次',
  `targetId` varchar(120) DEFAULT NULL COMMENT '目标源数据',
  `errorType` varchar(1000) DEFAULT NULL COMMENT '错误原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;