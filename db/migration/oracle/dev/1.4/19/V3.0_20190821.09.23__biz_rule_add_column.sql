ALTER TABLE h_biz_rule ADD (dataConditionJoinType VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.dataConditionJoinType is '触发数据条件连接类型';

ALTER TABLE h_biz_rule ADD (dataConditionJson CLOB);
comment on column h_biz_rule.dataConditionJson is '数据条件json';