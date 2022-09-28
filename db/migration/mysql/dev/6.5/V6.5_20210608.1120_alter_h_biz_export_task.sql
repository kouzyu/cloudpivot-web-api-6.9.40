alter table h_biz_export_task add refId varchar(200) null comment '附件id';
alter table h_biz_export_task add schemaCode varchar(200) null comment '数据模型编码';
alter table h_biz_export_task add expireTime datetime(0) null comment '过期时间';