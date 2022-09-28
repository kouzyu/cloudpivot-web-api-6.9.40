CREATE TABLE h_org_department_history (
  id varchar2(120)  NOT NULL
    primary key,
  creater varchar2(120)  DEFAULT NULL,
  createdTime date DEFAULT NULL,
  deleted number(1, 0) DEFAULT NULL,
  modifier varchar2(120)  DEFAULT NULL,
  modifiedTime date DEFAULT NULL,
  remarks varchar2(200)  DEFAULT NULL,
  extend1 varchar2(255)  DEFAULT NULL,
  extend2 varchar2(255)  DEFAULT NULL,
  extend3 varchar2(255)  DEFAULT NULL,
  extend4 int DEFAULT NULL,
  extend5 int DEFAULT NULL,
  calendarId varchar2(36)  DEFAULT NULL,
  employees int DEFAULT NULL,
  leaf number(1, 0) DEFAULT NULL,
  managerId varchar2(2000)  DEFAULT NULL,
  name varchar2(200)  DEFAULT NULL,
  parentId varchar2(36)  DEFAULT NULL,
  queryCode varchar2(512)  DEFAULT NULL,
  sortKey int DEFAULT NULL,
  sourceId varchar2(40)  DEFAULT NULL,
  sourceParentId varchar2(40)  DEFAULT NULL,
  targetParentId varchar2(36)  DEFAULT NULL,
  targetQueryCode varchar2(512)  DEFAULT NULL,
  changeTime date DEFAULT NULL,
  version int DEFAULT NULL,
  changeAction varchar2(20)  DEFAULT NULL
);

create index idx_hist_source_id on h_org_department_history (sourceId);
