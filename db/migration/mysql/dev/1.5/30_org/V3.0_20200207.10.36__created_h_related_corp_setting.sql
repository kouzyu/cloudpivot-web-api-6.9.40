CREATE TABLE `h_related_corp_setting` (
  `id` varchar(120)  NOT NULL,
  `creater` varchar(120)  DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120)  DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200)  DEFAULT NULL,
  `agentId` varchar(120)  DEFAULT NULL,
  `appSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL,
  `appkey` varchar(120)  DEFAULT NULL,
  `corpId` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织的corpId',
  `corpSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织的corpSecret',
  `exportHost` varchar(32) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '多机器转发的地址',
  `extend1` varchar(120)  DEFAULT NULL,
  `extend2` varchar(120)  DEFAULT NULL,
  `extend3` varchar(120)  DEFAULT NULL,
  `extend4` varchar(120)  DEFAULT NULL,
  `extend5` varchar(120)  DEFAULT NULL,
  `headerNum` int(11) NOT NULL COMMENT ' 企业标记，用于部门sourceid',
  `name` varchar(64) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '公司名称',
  `orgType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '第三方类型',
  `relatedType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织类型',
  `scanAppId` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '扫码登录appid',
  `scanAppSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '扫码登录Secret',
  `redirectUri` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '登录回调地址',
  `synRedirectUri` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '增量回调地址',
  `pcServerUrl` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT 'pc端地址',
  `mobileServerUrl` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '手机端地址',
  `syncType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '同步方式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_ci;