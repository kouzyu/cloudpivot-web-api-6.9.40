
CREATE TABLE IF NOT EXISTS `h_business_rule` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `node` longtext,
  `route` longtext,
  `schedulerSetting` longtext,
  `bizRuleType` varchar(15) DEFAULT NULL,
  `defaultRule` bit(1) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;