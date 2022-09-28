
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

-- 数据规则触发记录表
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerMainObjectId` varchar(100) DEFAULT NULL COMMENT '触发主表对象Id';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerMainObjectName` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '触发主表对象数据标题';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerTableType` varchar(40) DEFAULT NULL COMMENT '触发表类型：主表，子表';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceAppCode` varchar(40) DEFAULT NULL COMMENT '触发应用编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceAppName` varchar(50) DEFAULT NULL COMMENT '触发应用名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发对象所属模型编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceSchemaName` varchar(50) DEFAULT NULL COMMENT '触发对象所属模型名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `targetSchemaName` varchar(50) DEFAULT NULL COMMENT '目标所属模型名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标表编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `success` bit(1) DEFAULT NULL COMMENT '是否执行成功';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `failLog` longtext COMMENT '执行失败日志';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `effect` bit(1) DEFAULT NULL COMMENT '执行是否有影响数据';

-- 数据规则影响数据表
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetTableType` varchar(40) DEFAULT NULL COMMENT '目标表类型：主表，子表';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标表编码';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetMainObjectId` varchar(100) DEFAULT NULL COMMENT '目标主表对象Id';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetMainObjectName` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '目标主表对象数据标题';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyLastValue` longtext COMMENT '字段修改前数据';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertySetValue` longtext COMMENT '字段修改后数据';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyName` varchar(50) DEFAULT NULL COMMENT '目标字段名称';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyType` varchar(40) DEFAULT NULL COMMENT '目标字段类型';

ALTER TABLE `h_report_page` ADD COLUMN `reportObjectId` varchar(40) DEFAULT NULL COMMENT '报表编码';


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

-- 数据规则触发记录表
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerMainObjectId` varchar(100) DEFAULT NULL COMMENT '触发主表对象Id';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerMainObjectName` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '触发主表对象数据标题';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `triggerTableType` varchar(40) DEFAULT NULL COMMENT '触发表类型：主表，子表';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceAppCode` varchar(40) DEFAULT NULL COMMENT '触发应用编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceAppName` varchar(50) DEFAULT NULL COMMENT '触发应用名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceSchemaCode` varchar(40) DEFAULT NULL COMMENT '触发对象所属模型编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `sourceSchemaName` varchar(50) DEFAULT NULL COMMENT '触发对象所属模型名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `targetSchemaName` varchar(50) DEFAULT NULL COMMENT '目标所属模型名称';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标表编码';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `success` bit(1) DEFAULT NULL COMMENT '是否执行成功';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `failLog` longtext COMMENT '执行失败日志';
ALTER TABLE `h_biz_rule_trigger` ADD COLUMN `effect` bit(1) DEFAULT NULL COMMENT '执行是否有影响数据';

-- 数据规则影响数据表
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetTableType` varchar(40) DEFAULT NULL COMMENT '目标表类型：主表，子表';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标表编码';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetMainObjectId` varchar(100) DEFAULT NULL COMMENT '目标主表对象Id';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetMainObjectName` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '目标主表对象数据标题';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyLastValue` longtext COMMENT '字段修改前数据';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertySetValue` longtext COMMENT '字段修改后数据';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyName` varchar(50) DEFAULT NULL COMMENT '目标字段名称';
ALTER TABLE `h_biz_rule_effect` ADD COLUMN `targetPropertyType` varchar(40) DEFAULT NULL COMMENT '目标字段类型';

ALTER TABLE `h_report_page` ADD COLUMN `reportObjectId` varchar(40) DEFAULT NULL COMMENT '报表编码';