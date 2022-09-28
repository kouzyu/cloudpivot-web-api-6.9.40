CREATE TABLE `h_business_rule_runmap` (
  `id` varchar(120) NOT NULL COMMENT '主键',
  `ruleCode` varchar(40) NOT NULL COMMENT '规则编码',
  `ruleName` varchar(100) DEFAULT NULL COMMENT '规则名称',
  `ruleType` varchar(15) NOT NULL COMMENT '规则类型',
  `nodeCode` varchar(40) NOT NULL COMMENT '节点编码',
  `nodeName` varchar(100) DEFAULT NULL COMMENT '节点名称',
  `nodeType` varchar(15) NOT NULL COMMENT '节点类型',
  `targetSchemaCode` varchar(40) NOT NULL COMMENT '目标对象模型编码',
  `triggerSchemaCode` varchar(40) NOT NULL COMMENT '触发对象模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8