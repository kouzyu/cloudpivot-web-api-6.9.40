create table h_biz_datasource_category
(
	id varchar(128) default '' not null
		constraint H_BIZ_DATASOURCE_CATEGORY_PK
			primary key,
	createdTime timestamp default current_timestamp,
	modifiedTime timestamp default current_timestamp,
	name varchar(128) default '' not null
);


comment on table h_biz_datasource_category is '第三方数据源目录';


comment on column h_biz_datasource_category.id is '主键';


comment on column h_biz_datasource_category.createdTime is '创建时间';


comment on column h_biz_datasource_category.modifiedTime is '修改时间';


comment on column h_biz_datasource_category.name is '目录名称';





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
);


comment on table h_biz_datasource_method is '第三方数据源方法';


comment on column h_biz_datasource_method.id is '主键';


comment on column h_biz_datasource_method.createdTime is '创建时间';


comment on column h_biz_datasource_method.creater is '创建者';


comment on column h_biz_datasource_method.modifier is '修改者';


comment on column h_biz_datasource_method.deleted is '删除标志';


comment on column h_biz_datasource_method.remarks is '备注';


comment on column h_biz_datasource_method.code is '编码';


comment on column h_biz_datasource_method.name is '名称';


comment on column h_biz_datasource_method.sqlConfig is 'sql执行语句';


comment on column h_biz_datasource_method.datasourceCategoryId is '集成目录ID';


comment on column h_biz_datasource_method.dataBaseConnectId is '数据源Id';


comment on column h_biz_datasource_method.reportObjectId is '自定义SQL高级数据源的唯一标志';


comment on column h_biz_datasource_method.reportTableName is '报表数据源表别名';


create unique index UQ_CODE_DATASOURCE_METHOD
	on h_biz_datasource_method (code);

/*==============================================================*/
/* Table: create firstPinyin function                              */
/*==============================================================*/
create or replace function FIRSTPINYIN(
    P_NAME in varchar2)
return varchar2
as
V_COMPARE varchar2(100);
V_RETURN varchar2(4000);
function F_NLSSORT(P_WORD in varchar2) return varchar2 as
begin
return nlssort(P_WORD, 'NLS_SORT=SCHINESE_PINYIN_M');
end;
begin

  V_COMPARE := F_NLSSORT(substr(NVL(P_NAME,0), 0, 1));
  if V_COMPARE >= F_NLSSORT(' 吖 ') and V_COMPARE <= F_NLSSORT('驁 ') then
  V_RETURN := V_RETURN || 'a';
  elsif V_COMPARE >= F_NLSSORT('八 ') and V_COMPARE <= F_NLSSORT('簿 ') then
  V_RETURN := V_RETURN || 'b';
  elsif V_COMPARE >= F_NLSSORT('嚓 ') and V_COMPARE <= F_NLSSORT('錯 ') then
  V_RETURN := V_RETURN || 'c';
  elsif V_COMPARE >= F_NLSSORT('咑 ') and V_COMPARE <= F_NLSSORT('鵽 ') then
  V_RETURN := V_RETURN || 'd';
  elsif V_COMPARE >= F_NLSSORT('妸 ') and V_COMPARE <= F_NLSSORT('樲 ') then
  V_RETURN := V_RETURN || 'e';
  elsif V_COMPARE >= F_NLSSORT('发 ') and V_COMPARE <= F_NLSSORT('猤 ') then
  V_RETURN := V_RETURN || 'f';
  elsif V_COMPARE >= F_NLSSORT('旮 ') and V_COMPARE <= F_NLSSORT('腂 ') then
  V_RETURN := V_RETURN || 'g';
  elsif V_COMPARE >= F_NLSSORT('妎 ') and V_COMPARE <= F_NLSSORT('夻 ') then
  V_RETURN := V_RETURN || 'h';
  elsif V_COMPARE >= F_NLSSORT('丌 ') and V_COMPARE <= F_NLSSORT('攈 ') then
  V_RETURN := V_RETURN || 'j';
  elsif V_COMPARE >= F_NLSSORT('咔 ') and V_COMPARE <= F_NLSSORT('穒 ') then
  V_RETURN := V_RETURN || 'k';
  elsif V_COMPARE >= F_NLSSORT('垃 ') and V_COMPARE <= F_NLSSORT('擽 ') then
  V_RETURN := V_RETURN || 'l';
  elsif V_COMPARE >= F_NLSSORT('嘸 ') and V_COMPARE <= F_NLSSORT('椧 ') then
  V_RETURN := V_RETURN || 'm';
  elsif V_COMPARE >= F_NLSSORT('拏 ') and V_COMPARE <= F_NLSSORT('瘧 ') then
  V_RETURN := V_RETURN || 'n';
  elsif V_COMPARE >= F_NLSSORT('筽 ') and V_COMPARE <= F_NLSSORT('漚 ') then
  V_RETURN := V_RETURN || 'o';
  elsif V_COMPARE >= F_NLSSORT('妑 ') and V_COMPARE <= F_NLSSORT('曝 ') then
  V_RETURN := V_RETURN || 'p';
  elsif V_COMPARE >= F_NLSSORT('七 ') and V_COMPARE <= F_NLSSORT('裠 ') then
  V_RETURN := V_RETURN || 'q';
  elsif V_COMPARE >= F_NLSSORT('亽 ') and V_COMPARE <= F_NLSSORT('鶸 ') then
  V_RETURN := V_RETURN || 'r';
  elsif V_COMPARE >= F_NLSSORT('仨 ') and V_COMPARE <= F_NLSSORT('蜶 ') then
  V_RETURN := V_RETURN || 's';
  elsif V_COMPARE >= F_NLSSORT('侤 ') and V_COMPARE <= F_NLSSORT('籜 ') then
  V_RETURN := V_RETURN || 't';
  elsif V_COMPARE >= F_NLSSORT('屲 ') and V_COMPARE <= F_NLSSORT('鶩 ') then
  V_RETURN := V_RETURN || 'w';
  elsif V_COMPARE >= F_NLSSORT('夕 ') and V_COMPARE <= F_NLSSORT('鑂 ') then
  V_RETURN := V_RETURN || 'x';
  elsif V_COMPARE >= F_NLSSORT('丫 ') and V_COMPARE <= F_NLSSORT('韻 ') then
  V_RETURN := V_RETURN || 'y';
  elsif V_COMPARE >= F_NLSSORT('帀 ') and V_COMPARE <= F_NLSSORT('咗 ') then
  V_RETURN := V_RETURN || 'z';
  else
    V_RETURN := V_RETURN ||substr(P_NAME, 0, 1);
end if;


return V_RETURN;

end;
/