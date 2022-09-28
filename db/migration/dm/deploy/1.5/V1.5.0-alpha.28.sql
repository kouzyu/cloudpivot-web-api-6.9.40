ALTER TABLE h_biz_perm_group ADD (departments blob DEFAULT null);
comment on column h_biz_perm_group.departments is '部门范围';

ALTER TABLE h_biz_perm_group ADD (authorType VARCHAR(40) DEFAULT null);
comment on column h_biz_perm_group.authorType is '授权类型';

ALTER TABLE h_biz_rule ADD (triggerSchemaCodeIsGroup number(1, 0) DEFAULT null);
comment on column h_biz_rule.triggerSchemaCodeIsGroup is '主表加子表数据项';

ALTER TABLE biz_workflow_instance ADD (sequenceNo VARCHAR(200) DEFAULT null);
comment on column biz_workflow_instance.sequenceNo is '单据号';
