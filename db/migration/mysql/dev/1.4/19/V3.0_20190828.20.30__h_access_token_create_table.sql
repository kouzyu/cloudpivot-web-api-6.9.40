CREATE TABLE `h_access_token` (
  `id` varchar(40) COLLATE utf8_bin NOT NULL,
  `userId` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `leastUse` tinyint(1) DEFAULT NULL,
  `accessToken` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access_token_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
