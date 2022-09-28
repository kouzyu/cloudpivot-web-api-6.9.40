create table h_biz_datasource_category
(
	id varchar(128) default '' not null
		constraint H_BIZ_DATASOURCE_CATEGORY_PK
			primary key,
	createdTime timestamp default current_timestamp,
	modifiedTime timestamp default current_timestamp,
	name varchar(128) default '' not null
)


comment on table h_biz_datasource_category is '第三方数据源目录'


comment on column h_biz_datasource_category.id is '主键'


comment on column h_biz_datasource_category.createdTime is '创建时间'


comment on column h_biz_datasource_category.modifiedTime is '修改时间'


comment on column h_biz_datasource_category.name is '目录名称'





create table h_biz_datasource_method
(
	id varchar(128) default '' not null
		constraint H_BIZ_DATASOURCE_METHOD_PK
			primary key,
	createdTime timestamp default current_timestamp,
	creater varchar(128),
	modifier varchar(128),
	modifiedTime timestamp default current_timestamp,
	deleted number(1),
	remarks varchar(256),
	code varchar(64) default '' not null,
	name varchar(256) default '' not null,
	sqlConfig varchar(512) default '',
	datasourceCategoryId varchar(128) default '' not null,
	dataBaseConnectId varchar(128) default '' not null,
	reportObjectId varchar(32) not null,
	reportTableName varchar(32) default '' not null
)


comment on table h_biz_datasource_method is '第三方数据源方法'


comment on column h_biz_datasource_method.id is '主键'


comment on column h_biz_datasource_method.createdTime is '创建时间'


comment on column h_biz_datasource_method.creater is '创建者'


comment on column h_biz_datasource_method.modifier is '修改者'


comment on column h_biz_datasource_method.deleted is '删除标志'


comment on column h_biz_datasource_method.remarks is '备注'


comment on column h_biz_datasource_method.code is '编码'


comment on column h_biz_datasource_method.name is '名称'


comment on column h_biz_datasource_method.sqlConfig is 'sql执行语句'


comment on column h_biz_datasource_method.datasourceCategoryId is '集成目录ID'


comment on column h_biz_datasource_method.dataBaseConnectId is '数据源Id'


comment on column h_biz_datasource_method.reportObjectId is '自定义SQL高级数据源的唯一标志'


comment on column h_biz_datasource_method.reportTableName is '报表数据源表别名'


create unique index H_BIZ_DATASOURCE_METHOD_CODE_UINDEX
	on h_biz_datasource_method (code)


