-- auto-generated definition
create table H_ORG_DIRECT_MANAGER
(
    ID             VARCHAR2(120) not null
        constraint H_ORG_DIRECT_MANAGER_PK
            primary key,
    createdTime  DATE default current_timestamp,
    CREATER        VARCHAR2(120),
    modifiedTime DATE,
    MODIFIER       VARCHAR2(120),
    REMARKS        VARCHAR2(200),
    userId       VARCHAR2(36)  not null,
    deptId       VARCHAR2(36)  not null,
    managerId    VARCHAR2(36)  not null
)
/

comment on table H_ORG_DIRECT_MANAGER is '直属主管配置表'
/

comment on column H_ORG_DIRECT_MANAGER.createdTime is '创建时间'
/

comment on column H_ORG_DIRECT_MANAGER.CREATER is '创建人'
/

comment on column H_ORG_DIRECT_MANAGER.modifiedTime is '修改时间'
/

comment on column H_ORG_DIRECT_MANAGER.MODIFIER is '修改人'
/

comment on column H_ORG_DIRECT_MANAGER.REMARKS is '备注'
/

comment on column H_ORG_DIRECT_MANAGER.userId is '用户编号'
/

comment on column H_ORG_DIRECT_MANAGER.deptId is '部门编号'
/

comment on column H_ORG_DIRECT_MANAGER.managerId is '直属主管编号'
/

create unique index UQ_DIRECT_USER_DEPT
    on H_ORG_DIRECT_MANAGER (userId, deptId)
/

