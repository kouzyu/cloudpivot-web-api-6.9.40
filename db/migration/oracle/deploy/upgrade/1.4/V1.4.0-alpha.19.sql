ALTER TABLE h_biz_rule ADD (dataConditionJoinType VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.dataConditionJoinType is '触发数据条件连接类型';

ALTER TABLE h_biz_rule ADD (dataConditionJson CLOB);
comment on column h_biz_rule.dataConditionJson is '数据条件json';

ALTER TABLE h_perm_group ADD (authorType varchar2(40) DEFAULT null);

ALTER TABLE h_org_user ADD (pinYin VARCHAR(250) DEFAULT null);
comment on column h_org_user.pinYin is '姓名拼音';

ALTER TABLE h_org_user ADD (shortPinYin VARCHAR(250) DEFAULT null);
comment on column h_org_user.shortPinYin is '姓名简拼';

ALTER TABLE h_app_package ADD (appNameSpace varchar2(40) DEFAULT NULL);

-- ALTER TABLE h_perm_function_condition MODIFY (value CLOB);

create table h_open_api_event
(
  id varchar2(120) not null
    primary key,
  callback varchar2(400) null,
  clientId varchar2(30) null,
  eventTarget varchar2(300) null,
  eventTargetType varchar2(255) null,
  eventType varchar2(255) null
);

update h_biz_query_column set name = '拥有者' where propertyCode = 'owner';
update h_biz_query_column set name = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_query_condition set name = '拥有者' where propertyCode = 'owner';
update h_biz_query_condition set name = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_property set name = '拥有者' where code = 'owner';
update h_biz_property set name = '拥有者部门' where code = 'ownerDeptId';

CREATE TABLE h_access_token (
                              id varchar2(40)  NOT NULL PRIMARY KEY,
                              userId varchar2(40)  DEFAULT NULL,
                              leastUse int DEFAULT NULL,
                              accessToken varchar2(2000)  DEFAULT NULL,
                              createTime date DEFAULT NULL
);

create index idx_access_token_userId on h_access_token (userId);