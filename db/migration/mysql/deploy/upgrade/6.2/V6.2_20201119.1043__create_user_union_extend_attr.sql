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

