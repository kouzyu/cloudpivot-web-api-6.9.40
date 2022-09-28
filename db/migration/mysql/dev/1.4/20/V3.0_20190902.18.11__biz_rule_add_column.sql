ALTER TABLE `h_biz_rule` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标对象编码';

ALTER TABLE `h_biz_rule` ADD COLUMN `ruleScopeChildJson` longtext COMMENT '子表查找范围json';

ALTER TABLE `h_biz_rule` ADD COLUMN `ruleActionMainScopeJson` longtext COMMENT '执行动作中主表筛选条件json';