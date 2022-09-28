ALTER TABLE `h_biz_rule` ADD COLUMN `dataConditionJoinType` varchar(40) DEFAULT NULL COMMENT '触发数据条件连接类型';

ALTER TABLE `h_biz_rule` ADD COLUMN `dataConditionJson` longtext COMMENT '数据条件json';