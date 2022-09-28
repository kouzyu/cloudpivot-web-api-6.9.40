-- auto-generated definition
create table h_org_user_extend_attr
(
    id           varchar(120)               not null ,
    name         varchar(255) default ''    null,
    code         varchar(120) default ''    null,
    mapKey       varchar(120) default ''    null,
    enable       number(1)   default 0      null,
    belong       varchar(120) default ''    null,
    corpId       varchar(128) default 'ALL' null,
    deleted      number(1)   default 1      null,
    createdBy    varchar(120) default ''    null,
    createdTime  date                       null,
    modifiedBy   varchar(120)               null,
    modifiedTime date                       null,
    constraint UK_code_corpId
        unique (code, corpId)
);

comment on column h_org_user_extend_attr.id is '主键ID';
comment on column h_org_user_extend_attr.name is '扩展字段名称';
comment on column h_org_user_extend_attr.code is '编码code';
comment on column h_org_user_extend_attr.mapKey is '映射key';
comment on column h_org_user_extend_attr.enable is '是否启用 0：否  1：是';
comment on column h_org_user_extend_attr.belong is '所属分组';
comment on column h_org_user_extend_attr.corpId is '组织ID';
comment on column h_org_user_extend_attr.deleted is '是否删除  0：否  1：是';
comment on column h_org_user_extend_attr.createdBy is '创建者';
comment on column h_org_user_extend_attr.createdTime is '创建时间';
comment on column h_org_user_extend_attr.modifiedBy is '修改者';
comment on column h_org_user_extend_attr.modifiedTime is '修改时间';

create index IDX_corpId
    on h_org_user_extend_attr (corpId);

