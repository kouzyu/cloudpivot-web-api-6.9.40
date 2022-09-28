/*==============================================================*/
/* Table: h_org_inc_sync_record                                 */
/*==============================================================*/
create table h_org_inc_sync_record
(
   id                   varchar(120) not null,
   syncSourceType       char(10) default 'DINGTALK' comment '同步源类型，钉钉|企业微信 等 默认为钉钉',
   createTime           datetime default CURRENT_TIMESTAMP comment '创建时间',
   updateTime           datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   corpId               varchar(120) default NULL comment '组织corpId',
   eventType            varchar(50) default NULL comment '钉钉回调事件类型',
   eventInfo            text comment '事件数据',
   handleStatus         varchar(20) default NULL comment '处理状态',
   retryCount           int(11) default NULL comment '重试次数',
   primary key (id)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_bin;

alter table h_org_inc_sync_record comment '增量同步记录表';
