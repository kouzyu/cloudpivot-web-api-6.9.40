ALTER TABLE h_biz_rule ADD (insertConditionJoinType VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.insertConditionJoinType is '条件连接类型';
