create table h_org_direct_manager
(
    id           varchar(120)                           not null
        primary key,
    createdTime  datetime     default CURRENT_TIMESTAMP null comment '创建时间',
    creater      varchar(120) default ''                null comment '创建人',
    modifiedTime datetime     default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '修改时间',
    modifier     varchar(120) default ''                null comment '修改人',
    remarks      varchar(200) default ''                null comment '备注',
    userId       varchar(36)  default ''                not null comment '用户id',
    deptId       varchar(36)  default ''                not null comment '部门id',
    managerId    varchar(36)  default ''                not null comment '直属主管id',
    constraint uq_direct_user_dept
        unique (userId, deptId)
)
    comment '直属主管配置表';