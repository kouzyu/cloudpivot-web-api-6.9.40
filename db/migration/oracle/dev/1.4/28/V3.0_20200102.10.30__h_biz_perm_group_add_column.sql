ALTER TABLE h_biz_perm_group ADD (departments longtext);
comment on column h_biz_perm_group.departments is '部门范围';
ALTER TABLE h_biz_perm_group ADD (authorType VARCHAR(40) DEFAULT null);
comment on column h_biz_perm_group.authorType is '授权类型';

