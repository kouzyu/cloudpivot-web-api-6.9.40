alter table BIZ_WORKFLOW_INSTANCE add source varchar2(255);
comment on column BIZ_WORKFLOW_INSTANCE.source is '来源';

alter table BIZ_WORKFLOW_INSTANCE_BAK add source varchar2(255);
comment on column BIZ_WORKFLOW_INSTANCE_BAK.source is '来源';