ALTER TABLE h_org_synchronize_log ADD (corpId varchar2(120) DEFAULT null);
comment on column h_org_synchronize_log.corpId is '组织corpId';

ALTER TABLE h_org_synchronize_log ADD (status varchar2(40) DEFAULT null);
comment on column h_org_synchronize_log.status is '状态';