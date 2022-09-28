alter table h_related_corp_setting
    add enabled bit null comment '是否禁用';
alter table h_org_user
    add enabled bit null comment '是否禁用';
alter table h_org_department
    add enabled bit null comment '是否禁用';
update h_related_corp_setting set enabled = 1 where id != '';
update h_org_user set enabled = 1 where id != '';
update h_org_department set enabled = 1 where id != '';