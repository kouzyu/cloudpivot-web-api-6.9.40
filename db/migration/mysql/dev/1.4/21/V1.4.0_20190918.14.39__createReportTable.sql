
CREATE TABLE IF NOT EXISTS `h_report_page` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `pcAble` bit(1) DEFAULT NULL COMMENT 'PC是否可见',
  `name` varchar(50) DEFAULT NULL,
  `mobileAble` bit(1) DEFAULT NULL COMMENT '移动端是否可见',
  `appCode` varchar(40) DEFAULT NULL,
  `name_i18n` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '双语言',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;