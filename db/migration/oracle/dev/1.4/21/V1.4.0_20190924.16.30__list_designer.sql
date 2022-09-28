
CREATE TABLE h_biz_query_present (
  id varchar2(120)  NOT NULL primary key,
  creater varchar2(120)  DEFAULT NULL,
  createdTime date DEFAULT NULL,
  deleted number(1, 0) DEFAULT NULL,
  modifier varchar2(120)  DEFAULT NULL,
  modifiedTime date DEFAULT NULL,
  remarks varchar2(200)  DEFAULT NULL,
  queryId varchar2(36) DEFAULT NULL,
  schemaCode varchar2(40) DEFAULT NULL,
  clientType number(1, 0)  DEFAULT NULL,
  htmlJson varchar2(2000)  DEFAULT NULL,
  actionsJson varchar2(2000)  DEFAULT NULL,
  columnsJson varchar2(20)  DEFAULT NULL
);

comment on column h_biz_query_present.clientType is 'PC或者MOBILE端';
comment on column h_biz_query_present.htmlJson is '列表htmlJson数据';
comment on column h_biz_query_present.actionsJson is '列表action操作JSON数据';
comment on column h_biz_query_present.columnsJson is '列表展示字段columnJSON数据';



ALTER TABLE h_biz_query ADD (queryPresentationType VARCHAR(40) DEFAULT 'LIST');
comment on column h_biz_query.queryPresentationType is '列表视图类型';


ALTER TABLE h_biz_query ADD (showOnPc number(1, 0) DEFAULT NULL);
comment on column h_biz_query.showOnPc is 'PC是否可见';


ALTER TABLE h_biz_query ADD (showOnMobile number(1, 0) DEFAULT NULL);
comment on column h_biz_query.showOnMobile is '移动端是否可见';

ALTER TABLE h_biz_query ADD (publish number(1, 0) DEFAULT NULL);
comment on column h_biz_query.publish is '发布状态';


ALTER TABLE h_biz_query_column ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_column.clientType is 'PC或者MOBILE端';


ALTER TABLE h_biz_query_condition ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_condition.clientType is 'PC或者MOBILE端';

ALTER TABLE h_biz_query_sorter ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_sorter.clientType is 'PC或者MOBILE端';


ALTER TABLE h_biz_query_action ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_action.clientType is 'PC或者MOBILE端';