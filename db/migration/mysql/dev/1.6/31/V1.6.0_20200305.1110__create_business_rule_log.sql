CREATE TABLE IF NOT EXISTS `h_log_business_rule_header` (
  `id` varchar(120) NOT NULL,
  `businessRuleCode` varchar(40) DEFAULT NULL,
  `businessRuleName` varchar(200) DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `originator` varchar(40) DEFAULT NULL,
  `schemaCode` varchar(40) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `success` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `h_log_business_rule_content` (
  `id` varchar(120) NOT NULL,
  `exceptionContent` longtext,
  `exceptionNodeCode` varchar(120) DEFAULT NULL,
  `exceptionNodeName` varchar(200) DEFAULT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `triggerCoreData` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `h_log_business_rule_node` (
  `id` varchar(120) NOT NULL,
  `endTime` datetime DEFAULT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `nodeCode` varchar(120) DEFAULT NULL,
  `nodeInstanceId` varchar(120) DEFAULT NULL,
  `nodeName` varchar(200) DEFAULT NULL,
  `nodeSequence` int(11) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `h_log_business_rule_data_trace` (
  `id` varchar(120) NOT NULL,
  `flowInstanceId` varchar(120) DEFAULT NULL,
  `nodeCode` varchar(120) DEFAULT NULL,
  `nodeInstanceId` varchar(120) DEFAULT NULL,
  `nodeName` varchar(200) DEFAULT NULL,
  `ruleTriggerActionType` varchar(40) DEFAULT NULL,
  `targetObjectId` varchar(120) DEFAULT NULL,
  `targetSchemaCode` varchar(40) DEFAULT NULL,
  `traceLastData` longtext,
  `traceSetData` longtext,
  `traceUpdateDetail` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;