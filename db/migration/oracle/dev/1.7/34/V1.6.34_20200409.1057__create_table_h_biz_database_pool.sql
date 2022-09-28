create table h_biz_database_pool
(
    id            varchar2(120) not null
        primary key,
    creater       varchar2(120) null,
    createdTime   date          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  date          null,
    remarks       varchar2(200) null,
    code          varchar2(40)  null,
    name          varchar2(50)  null,
    description   CLOB          null,
    databaseType  varchar2(15)  null,
    jdbcUrl       varchar2(200) null,
    username      varchar2(40)  null,
    password      varchar2(300)  null
);