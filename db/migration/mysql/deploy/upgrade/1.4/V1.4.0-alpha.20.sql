ALTER TABLE `h_biz_rule` ADD COLUMN `targetTableCode` varchar(40) DEFAULT NULL COMMENT '目标对象编码';

ALTER TABLE `h_biz_rule` ADD COLUMN `ruleScopeChildJson` longtext COMMENT '子表查找范围json';

ALTER TABLE `h_biz_rule` ADD COLUMN `ruleActionMainScopeJson` longtext COMMENT '执行动作中主表筛选条件json';

ALTER TABLE `h_biz_rule` ADD COLUMN `insertConditionJoinType` varchar(40) DEFAULT NULL COMMENT '条件连接类型';


-- 放错到版本19
DELETE FROM h_perm_admin WHERE id='2c928a4c6c043e48016c04c108300a90';

INSERT INTO `h_perm_admin` (`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `adminType`, `dataManage`, `dataQuery`, `userId`)
VALUES ('2c928a4c6c043e48016c04c108300a90', '2c928e4c6a4d1d87016a4d1f2f760048', '2019-9-6 10:23:15', '\0', NULL, '2019-9-6 10:23:15', NULL, 'ADMIN', true, true, '2c9280a26706a73a016706a93ccf002b');

-- 刪除审批意见类型数据项
DELETE FROM h_biz_property WHERE propertyType='COMMENT';