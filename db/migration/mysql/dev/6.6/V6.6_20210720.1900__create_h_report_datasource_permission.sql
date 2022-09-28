create table h_report_datasource_permission
(
   id                   varchar(32) not null,
   creater              varchar(32) default NULL,
   createdTime          datetime default NULL,
   modifier             varchar(32) default NULL,
   modifiedTime         datetime default NULL,
   remarks              varchar(256) default NULL,
   objectId             varchar(64) comment '数据流节点',
   userScope            longtext comment '用户使用范围',
   ownerId              varchar(32),
   nodeType             bit comment '节点类型',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_bin;

alter table h_report_datasource_permission comment '报表高级数据源权限设置';

/*==============================================================*/
/* Index: uq_object_id                                          */
/*==============================================================*/
create unique index uq_object_id on h_report_datasource_permission
(
   objectId
);