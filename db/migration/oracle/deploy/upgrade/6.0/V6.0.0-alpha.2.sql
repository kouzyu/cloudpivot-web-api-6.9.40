ALTER TABLE h_biz_property ADD (selectionJson CLOB DEFAULT NULL);
comment on column h_biz_property.selectionJson is '下拉框附属';
create index idx_trigger_id on h_biz_rule_effect(triggerId);

ALTER TABLE h_perm_biz_function ADD (batchPrintAble number(1,0) DEFAULT 0);
comment on column h_perm_biz_function.batchPrintAble is '批量打印';

ALTER TABLE h_org_synchronize_log ADD (isSyncRoleScope int DEFAULT NULL);

ALTER TABLE h_biz_attachment ADD (base64ImageStr CLOB DEFAULT NULL);
comment on column h_biz_attachment.base64ImageStr is 'base64图片';

ALTER TABLE h_from_comment_attachment ADD (base64ImageStr CLOB DEFAULT NULL);
comment on column h_from_comment_attachment.base64ImageStr is 'base64图片';
