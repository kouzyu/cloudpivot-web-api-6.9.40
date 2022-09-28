create table h_perm_selection_scope
(
    id varchar(128) default '' not null
        constraint H_PERM_SELECTION_SCOPE_PK
            primary key,
    createdTime date,
    creater varchar2(120),
    deleted number,
    modifiedTime date,
    modifier varchar2(120),
    remarks varchar2(200),
    departmentId varchar2(120),
    deptVisibleType varchar2(40),
    deptVisibleScope clob,
    staffVisibleType varchar2(40),
    staffVisibleScope clob
);
