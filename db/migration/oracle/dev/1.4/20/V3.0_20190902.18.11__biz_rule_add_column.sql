ALTER TABLE h_biz_rule ADD (targetTableCode VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.targetTableCode is '目标对象编码';

ALTER TABLE h_biz_rule ADD (ruleScopeChildJson CLOB);
comment on column h_biz_rule.ruleScopeChildJson is '子表查找范围json';

ALTER TABLE h_biz_rule ADD (ruleActionMainScopeJson CLOB);
comment on column h_biz_rule.ruleActionMainScopeJson is '执行动作中主表筛选条件json';
