/*==============================================================*/
/* Table: h_org_inc_sync_record                                 */
/*==============================================================*/

create table H_ORG_INC_SYNC_RECORD
(
    id varchar(128) default '' not null
        constraint H_ORG_INC_SYNC_RECORD_PK
            primary key,
    syncSourceType       char(10) default 'DINGTALK',
    createTime           date default CURRENT_TIMESTAMP,
    updateTime           date default CURRENT_TIMESTAMP ,
    corpId               varchar(120) default NULL ,
    eventType            varchar(50) default NULL ,
    eventInfo            CLOB ,
    handleStatus         varchar(20) default NULL ,
    retryCount           int default NULL
)/
comment on table H_ORG_INC_SYNC_RECORD is '增量同步记录表'/
comment on column H_ORG_INC_SYNC_RECORD.id is '主键'/
comment on column H_ORG_INC_SYNC_RECORD.syncSourceType is '同步源类型，钉钉|企业微信 等 默认为钉钉'/
comment on column H_ORG_INC_SYNC_RECORD.createTime is '创建时间'/
comment on column H_ORG_INC_SYNC_RECORD.updateTime is '修改时间'/
comment on column H_ORG_INC_SYNC_RECORD.corpId is '组织corpId'/
comment on column H_ORG_INC_SYNC_RECORD.eventType is '钉钉回调事件类型'/
comment on column H_ORG_INC_SYNC_RECORD.eventInfo is '事件数据'/
comment on column H_ORG_INC_SYNC_RECORD.handleStatus is '处理状态'/
comment on column H_ORG_INC_SYNC_RECORD.retryCount is '重试次数'/
