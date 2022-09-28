

create table h_business_rule
(
  id varchar2(120) not null primary key,
  createdTime date null,
  creater       varchar2(120) null,
  deleted       number(1, 0)  null,
  modifiedTime  date          null,
  modifier      varchar2(120) null,
  node CLOB          null,
  route CLOB          null,
  schedulerSetting CLOB          null,
  bizRuleType varchar2(120) null,
  defaultRule number(1, 0)  null,
  code varchar2(120) null,
  name varchar2(300) null,
  schemaCode varchar2(120) null,
  remarks varchar2(600) null
);

create table h_log_business_rule_header (
  id varchar2(120) not null primary key,
  businessRuleCode varchar2(120) null,
  businessRuleName varchar2(600) null,
  endTime date          null,
  flowInstanceId varchar2(400) null,
  originator varchar2(120) null,
  schemaCode varchar2(120) null,
  startTime date          null,
  success number(1, 0)  null
);

create table h_log_business_rule_content (
  id varchar2(120) not null primary key,
  exceptionContent CLOB          null,
  exceptionNodeCode varchar2(400) null,
  exceptionNodeName varchar2(600) null,
  flowInstanceId varchar2(400) null,
  triggerCoreData CLOB          null
);


create table h_log_business_rule_node (
  id varchar2(120) not null primary key,
  endTime date          null,
  flowInstanceId varchar2(400) null,
  nodeCode varchar2(400) null,
  nodeInstanceId varchar2(400) null,
  nodeName varchar2(600) null,
  nodeSequence INTEGER NULL,
  startTime date          null
);

create table h_log_business_rule_data_trace (
  id varchar2(120) not null primary key,
  flowInstanceId varchar2(400) null,
  nodeCode varchar2(400) null,
  nodeInstanceId varchar2(400) null,
  nodeName varchar2(600) null,
  ruleTriggerActionType varchar2(400) null,
  targetObjectId varchar2(400) null,
  targetSchemaCode varchar2(400) null,
  traceLastData CLOB          null,
  traceSetData CLOB          null,
  traceUpdateDetail CLOB          null
);


ALTER TABLE h_im_message ADD (externalLink number(1, 0)  null);
comment on column h_im_message.externalLink is '是否是外部链接';

ALTER TABLE h_im_message_history ADD (externalLink number(1, 0)  null);
comment on column h_im_message_history.externalLink is '是否是外部链接';


ALTER TABLE h_biz_schema ADD (businessRuleEnable number(1, 0)  DEFAULT 0);
comment on column h_biz_schema.businessRuleEnable is '是否启用业务规则';


create index Idx_h_log_business_rule_header_flowInstanceId on h_log_business_rule_header(flowInstanceId);
create index Idx_h_log_business_rule_content_flowInstanceId on h_log_business_rule_content(flowInstanceId);
create index Idx_h_log_business_rule_node_flowInstanceId on h_log_business_rule_node(flowInstanceId);
create index Idx_h_log_business_rule_data_trace_flowInstanceId on h_log_business_rule_data_trace(flowInstanceId);




