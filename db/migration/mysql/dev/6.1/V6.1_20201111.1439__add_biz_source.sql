drop table if exists h_biz_datasource_category;

/*==============================================================*/
/* Table: h_biz_datasource_category                             */
/*==============================================================*/
create table h_biz_datasource_category
(
   id                   varchar(128) not null comment '主键',
   createdTime          datetime default CURRENT_TIMESTAMP comment '创建时间',
   modifiedTime         datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   name                 varchar(128) not null default '' comment '目录名称',
   primary key (id)
)ENGINE = InnoDB COLLATE = utf8_general_ci;

alter table h_biz_datasource_category comment '第三方数据源目录';


drop table if exists h_biz_datasource_method;

/*==============================================================*/
/* Table: h_biz_datasource_method                               */
/*==============================================================*/
create table h_biz_datasource_method
(
   id                   varchar(128) not null comment '主键',
   createdTime          datetime default CURRENT_TIMESTAMP comment '创建时间',
   creater              varchar(128) comment '链接名称创建者',
   modifier             varchar(128) comment '修改者',
   modifiedTime         datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   deleted              bit comment '删除标志',
   remarks              varchar(256) comment '备注',
   code                 varchar(32) not null default '' comment '编码',
   name                 varchar(256) not null default '' comment '名称',
   sqlConfig            varchar(512) not null default '' comment 'sql执行语句',
   datasourceCategoryId varchar(128) not null default '' comment '集成目录ID',
   dataBaseConnectId    varchar(128) not null default '' comment '数据源Id',
   reportObjectId       varchar(32) not null default '' comment '自定义SQL高级数据源的唯一标志',
   reportTableName      varchar(32) not null default '' comment '报表数据源表别名',
   primary key (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

alter table h_biz_datasource_method comment '第三方数据源方法';

/*==============================================================*/
/* Index: uk_code                                               */
/*==============================================================*/
create unique index uk_code on h_biz_datasource_method
(
   code
);
