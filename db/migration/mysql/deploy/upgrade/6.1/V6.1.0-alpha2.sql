-- auto-generated definition
create table h_org_user_extend_attr
(
    id           varchar(120)               not null comment '主键ID',
    name         varchar(255) default ''    null comment '扩展字段名称',
    code         varchar(120) default ''    null comment '编码code',
    mapKey       varchar(120) default ''    null comment '映射key',
    enable       tinyint(1)   default 0     null comment '是否启用 0：否  1：是',
    belong       varchar(120) default ''    null comment '所属分组',
    corpId       varchar(128) default 'ALL' null comment '组织ID',
    deleted      tinyint(1)   default 1     null comment '是否删除  0：否  1：是',
    createdBy    varchar(120) default ''    null comment '创建者',
    createdTime  datetime                   null comment '创建时间',
    modifiedBy   varchar(120)               null comment '修改者',
    modifiedTime datetime                   null comment '修改时间',
    constraint UK_code_corpId
        unique (code, corpId)
);

create index IDX_corpId
    on h_org_user_extend_attr (corpId);

-- auto-generated definition
create table h_org_user_union_extend_attr
(
    id           varchar(120)             not null comment '主键ID',
    userId       varchar(120) default ''  null comment '用户主键ID',
    extendAttrId varchar(120) default ''  null comment '扩展属性ID',
    mapVal       varchar(500) default '0' null comment '映射值',
    deleted      tinyint(1)   default 1   null comment '是否删除  0：否  1：是',
    createdBy    varchar(128) default ''  null comment '创建者',
    createdTime  datetime                 null comment '创建时间',
    modifiedBy   varchar(128)             null comment '修改者',
    modifiedTime datetime                 null comment '修改时间',
    constraint UK_userId_attrId
        unique (userId, extendAttrId)
);

create index IDX_extendAttrId
    on h_org_user_union_extend_attr (extendAttrId);

create index IDX_userId
    on h_org_user_union_extend_attr (userId);