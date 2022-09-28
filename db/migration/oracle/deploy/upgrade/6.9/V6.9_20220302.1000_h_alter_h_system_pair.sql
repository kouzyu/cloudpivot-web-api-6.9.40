
alter table h_system_pair add objectId varchar2(120);
comment on column h_system_pair.objectId is '数据id';

alter table h_system_pair add schemaCode varchar2(40);
comment on column h_system_pair.schemaCode is '模型编码';

alter table h_system_pair add formCode varchar2(40);
comment on column h_system_pair.formCode is '表单编码';

alter table h_system_pair add workflowInstanceId varchar2(120);
comment on column h_system_pair.workflowInstanceId is '流程实例ID';

CREATE INDEX "idx_bid_fcode" ON  H_SYSTEM_PAIR (OBJECTID, FORMCODE);

