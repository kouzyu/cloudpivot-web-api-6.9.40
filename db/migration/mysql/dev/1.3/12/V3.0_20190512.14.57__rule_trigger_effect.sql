CREATE TABLE IF NOT EXISTS `h_biz_rule_trigger` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `conditionJoinType` varchar(40) DEFAULT NULL COMMENT '条件连接类型',
  `ruleId` varchar(100) DEFAULT NULL COMMENT '数据规则id',
  `ruleName` varchar(100) DEFAULT NULL COMMENT '数据规则名称',
  `targetSchemaCode` varchar(40) DEFAULT NULL COMMENT '目标模型编码',
  `triggerActionType` varchar(40) DEFAULT NULL COMMENT '触发动作类型',
  `triggerConditionType` varchar(40) DEFAULT NULL COMMENT '触发条件类型',
  `triggerObjectId` varchar(100) DEFAULT NULL COMMENT '触发对象Id',
  `triggerSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发对象模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '数据规则触发记录';

CREATE TABLE IF NOT EXISTS `h_biz_rule_effect` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `actionType` varchar(40) DEFAULT NULL COMMENT '动作类型',
  `actionValue` varchar(255) DEFAULT NULL COMMENT '动作值',
  `lastValue` longtext COMMENT '规则执行前数据',
  `setValue` longtext COMMENT '规则执行后数据',
  `targetObjectId` varchar(100) DEFAULT NULL COMMENT '目标对象id',
  `targetPropertyCode` varchar(40) DEFAULT NULL COMMENT '目标属性',
  `targetSchemaCode` varchar(40) DEFAULT NULL COMMENT '目标模型编码',
  `triggerActionType` varchar(40) DEFAULT NULL COMMENT '触发动作类型',
  `triggerId` varchar(100) DEFAULT NULL COMMENT '规则触发id',
  `triggerObjectId` varchar(100) DEFAULT NULL COMMENT '触发对象id',
  `triggerSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发对象模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '数据规则执行影响数据记录';

