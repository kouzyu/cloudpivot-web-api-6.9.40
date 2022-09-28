ALTER TABLE h_org_role_user ADD (usScope clob DEFAULT NULL);
comment on column h_org_role_user.usScope is '管理范围（人员）';