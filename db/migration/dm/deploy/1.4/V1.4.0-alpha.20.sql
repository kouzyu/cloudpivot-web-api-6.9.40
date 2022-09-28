ALTER TABLE h_biz_rule ADD (targetTableCode VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.targetTableCode is '目标对象编码';

ALTER TABLE h_biz_rule ADD (ruleScopeChildJson CLOB);
comment on column h_biz_rule.ruleScopeChildJson is '子表查找范围json';

ALTER TABLE h_biz_rule ADD (ruleActionMainScopeJson CLOB);
comment on column h_biz_rule.ruleActionMainScopeJson is '执行动作中主表筛选条件json';


ALTER TABLE h_biz_rule ADD (insertConditionJoinType VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.insertConditionJoinType is '条件连接类型';



DELETE FROM h_perm_admin WHERE id='2c928a4c6c043e48016c04c108300a90';

INSERT INTO h_perm_admin (id, creater, createdTime, deleted, modifier, modifiedTime, remarks, adminType, dataManage, dataQuery, userId)
VALUES ('2c928a4c6c043e48016c04c108300a90', '2c928e4c6a4d1d87016a4d1f2f760048', sysdate, 0, NULL, sysdate, NULL, 'ADMIN', 1, 1, '2c9280a26706a73a016706a93ccf002b');

-- 刪除审批意见类型数据项
DELETE FROM h_biz_property WHERE propertyType='COMMENT';
