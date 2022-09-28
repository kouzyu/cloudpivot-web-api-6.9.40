alter table h_biz_export_task add refId varchar(200);

comment on column h_biz_export_task.refId is '附件id';

alter table h_biz_export_task add schemaCode varchar(200);

comment on column h_biz_export_task.schemaCode is '数据模型编码';

alter table h_biz_export_task add expireTime date;

comment on column h_biz_export_task.expireTime is '过期时间';