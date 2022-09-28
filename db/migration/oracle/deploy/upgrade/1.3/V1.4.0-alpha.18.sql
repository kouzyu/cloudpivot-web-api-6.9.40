
ALTER TABLE h_perm_biz_function ADD (printAble number(1, 0) DEFAULT null);

update h_biz_property t set t.propertyType = 'SHORT_TEXT' where t.code = 'id' and t.propertyType = 'WORK_SHEET';

ALTER TABLE h_timer_job ADD (taskId varchar2(120) DEFAULT null);
comment on column h_timer_job.taskId is '任务id';

ALTER TABLE h_job_result ADD (taskId varchar2(120) DEFAULT null);
comment on column h_job_result.taskId is '任务id';




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
  targetParentId varchar2(36)  DEFAULT NULL,
  targetQueryCode varchar2(512)  DEFAULT NULL,
  changeTime date DEFAULT NULL,
  version int DEFAULT NULL,
  changeAction varchar2(20)  DEFAULT NULL
);

create index idx_hist_source_id on h_org_department_history (sourceId);
