-- auto-generated definition
create table h_org_user_union_extend_attr
(
    id           varchar(120)             not null,
    userId       varchar(120) default ''  null,
    extendAttrId varchar(120) default ''  null,
    mapVal       varchar(500) default '0' null,
    deleted      number(1)   default 1    null,
    createdBy    varchar(128) default ''  null,
    createdTime  date                     null,
    modifiedBy   varchar(128)             null,
    modifiedTime date                     null,
    constraint UK_userId_attrId
        unique (userId, extendAttrId)
);

comment on column h_org_user_union_extend_attr.id is '主键ID';
comment on column h_org_user_union_extend_attr.userId is '用户主键ID';
comment on column h_org_user_union_extend_attr.extendAttrId is '扩展属性ID';
comment on column h_org_user_union_extend_attr.mapVal is '映射值';
comment on column h_org_user_union_extend_attr.deleted is '是否删除  0：否  1：是';
comment on column h_org_user_union_extend_attr.createdBy is '创建者';
comment on column h_org_user_union_extend_attr.createdTime is '创建时间';
comment on column h_org_user_union_extend_attr.modifiedBy is '修改者';
comment on column h_org_user_union_extend_attr.modifiedTime is '修改时间';

create index IDX_extendAttrId
    on h_org_user_union_extend_attr (extendAttrId);

create index IDX_userId
    on h_org_user_union_extend_attr (userId);

