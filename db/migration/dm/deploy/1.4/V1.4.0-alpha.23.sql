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
  clientType varchar2(40)  DEFAULT NULL,
  htmlJson clob  DEFAULT NULL,
  actionsJson clob  DEFAULT NULL,
  columnsJson clob  DEFAULT NULL
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

ALTER TABLE h_org_department ADD (dingDeptManagerId VARCHAR(255) DEFAULT null);
comment on column h_org_department.dingDeptManagerId is '钉钉部门主管id集合';


ALTER TABLE h_org_role_user ADD (userSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_role_user.userSourceId is '钉钉用户id非unionId';
ALTER TABLE h_org_role_user ADD (roleSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_role_user.roleSourceId is '钉钉角色id';

-- 更新数据
update h_org_role_user,h_org_role set h_org_role_user.roleSourceId = h_org_role.sourceId WHERE h_org_role_user.roleId = h_org_role.id;

update h_org_role_user,h_org_user set h_org_role_user.userSourceId = h_org_user.userId WHERE h_org_role_user.userId = h_org_user.id;


ALTER TABLE h_org_dept_user ADD (userSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_dept_user.userSourceId is '钉钉用户id非unionId';
ALTER TABLE h_org_dept_user ADD (deptSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_dept_user.deptSourceId is '钉钉部门id';

-- 更新数据
update h_org_dept_user,h_org_department set h_org_dept_user.deptSourceId = h_org_department.sourceId WHERE h_org_dept_user.deptId = h_org_department.id;

update h_org_dept_user,h_org_user set h_org_dept_user.userSourceId = h_org_user.userId WHERE h_org_dept_user.userId = h_org_user.id;

-- 角色用户关联表联合索引
CREATE INDEX idx_role_user_sourceid ON h_org_role_user(userSourceId,roleSourceId);

-- 部门用户关联表联合索引
CREATE INDEX idx_dept_user_composeid ON h_org_dept_user(userId,deptId);