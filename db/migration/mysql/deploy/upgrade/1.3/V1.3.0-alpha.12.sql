

CREATE TABLE IF NOT EXISTS `h_biz_rule` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `conditionJoinType` varchar(40) DEFAULT NULL COMMENT '条件连接类型',
  `enabled` bit(1) DEFAULT NULL COMMENT '是否启用',
  `name` varchar(100) DEFAULT NULL COMMENT '数据规则名称',
  `ruleActionJson` longtext COMMENT '执行动作',
  `ruleScopeJson` longtext COMMENT '查找范围',
  `sourceSchemaCode` varchar(40) DEFAULT NULL COMMENT '规则所属模型编码',
  `targetSchemaCode` varchar(40) DEFAULT NULL COMMENT '目标模型编码',
  `triggerActionType` varchar(40) DEFAULT NULL COMMENT '触发动作类型',
  `triggerConditionType` varchar(40) DEFAULT NULL COMMENT '触发条件类型',
  `triggerSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发模型编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '数据规则';


ALTER TABLE `h_biz_rule` ADD COLUMN `chooseAction` varchar(100) DEFAULT NULL COMMENT '目标模型导航编码';


ALTER TABLE `h_biz_query_condition` ADD COLUMN `accurateSearch` bit(1) DEFAULT NULL COMMENT '精确查找';
ALTER TABLE `h_biz_query_condition` ADD COLUMN `displayFormat` varchar(40) DEFAULT NULL COMMENT '显示格式';


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


ALTER TABLE `h_biz_query_condition` MODIFY `defaultValue` VARCHAR(500) DEFAULT NULL COMMENT '默认值';


ALTER TABLE `h_perm_biz_function` ADD COLUMN `nodeType` VARCHAR(40) DEFAULT NULL COMMENT '节点类型';


CREATE TABLE IF NOT EXISTS `h_workflow_relative_event`
(
  `id`            varchar(120) NOT NULL,
  `creater`       varchar(120) DEFAULT NULL,
  `createdTime`   datetime     DEFAULT NULL,
  `deleted`       bit(1)       DEFAULT NULL,
  `modifier`      varchar(120) DEFAULT NULL,
  `modifiedTime`  datetime     DEFAULT NULL,
  `remarks`       varchar(200) DEFAULT NULL,
  `schemaCode`    varchar(40)  DEFAULT NULL COMMENT '模型编码',
  `workflowCode`  varchar(40)  DEFAULT NULL COMMENT '流程编码',
  `bizMethodCode` varchar(40)  DEFAULT NULL COMMENT '业务方法编码',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT '流程关联业务方法';