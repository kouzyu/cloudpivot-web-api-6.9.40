-- auto-generated definition
create table h_perm_selection_scope
(
    id                varchar(120) not null
        primary key,
    createdTime       datetime     null,
    creater           varchar(120) null,
    deleted           bit          null,
    modifiedTime      datetime     null,
    modifier          varchar(120) null,
    remarks           varchar(200) null,
    departmentId      varchar(120) null,
    deptVisibleType   varchar(40)  null,
    deptVisibleScope  longtext     null,
    staffVisibleType  varchar(40)  null,
    staffVisibleScope longtext     null
)
    charset = utf8;