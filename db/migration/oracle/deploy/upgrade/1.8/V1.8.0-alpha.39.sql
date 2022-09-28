alter table h_biz_property modify name varchar2(600);

CREATE TABLE biz_workflow_instance_bak (
  id                        varchar2(42) not null primary key,
  finishTime                date,
  receiveTime               date,
  startTime                 date,
  backupTime                date,
  appCode                   varchar2(200) NULL,
  bizObjectId               varchar2(36) NULL,
  departmentId              varchar2(200) NULL,
  departmentName            varchar2(200) NULL,
  instanceName              varchar2(200) NULL,
  originator                varchar2(200) NULL,
  originatorName            varchar2(200) NULL,
  parentId                  varchar2(36) NULL,
  remark                    varchar2(200) NULL,
  state                     varchar2(20) NULL,
  stateValue                number(11) NULL,
  usedTime                  number(20) NULL,
  waitTime                  number(20) NULL,
  workflowCode              varchar2(200) NULL,
  workflowTokenId           varchar2(36) NULL,
  workflowVersion           number(11) NULL,
  sheetBizObjectId          varchar2(36) NULL,
  sheetSchemaCode           varchar2(64) NULL,
  sequenceNo                varchar2(200) NULL,
  trustee                   varchar2(42) NULL,
  trusteeName               varchar2(80) NULL,
  trustType                 varchar2(20) NULL,
  schemaCode                varchar2(40) NULL,
  dataType                  varchar2(20) NULL,
  runMode                   varchar2(20) NULL
);

CREATE TABLE h_workflow_template_bak (
  id                        varchar2(42) not null primary key,
  creater                   varchar2(120) NULL,
  createdTime               date NULL,
  backupTime                date NULL,
  deleted                   number(1, 0) DEFAULT NULL,
  modifier                  varchar2(120)  NULL,
  modifiedTime              date NULL,
  remarks                   varchar2(200)  NULL,
  activateEventHandler      CLOB NULL,
  cancelEventHandler        CLOB NULL,
  content                   CLOB NULL,
  endEventHandler           CLOB NULL,
  startEventHandler         CLOB NULL,
  templateType              varchar2(10) NULL,
  workflowCode              varchar2(40) NULL,
  workflowVersion           number(11) NULL
);


alter table h_biz_perm_property modify name varchar2(600);

alter table h_biz_query_column modify name varchar2(600);

alter table h_biz_query_condition modify name varchar2(600);

alter table h_biz_query_sorter modify name varchar2(600);

alter table h_biz_property modify defaultValue varchar2(4000);

ALTER TABLE biz_workitem ADD (rootTaskId varchar2(42) DEFAULT NULL);
ALTER TABLE biz_workitem ADD (sourceTaskId varchar2(42) DEFAULT NULL);

ALTER TABLE biz_workitem_finished ADD (rootTaskId varchar2(42) DEFAULT NULL);
ALTER TABLE biz_workitem_finished ADD (sourceTaskId varchar2(42) DEFAULT NULL);

ALTER TABLE h_org_role_user ADD (usScope clob DEFAULT NULL);
comment on column h_org_role_user.usScope is '管理范围（人员）';