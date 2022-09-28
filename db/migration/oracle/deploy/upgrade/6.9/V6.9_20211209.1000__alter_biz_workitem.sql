alter table BIZ_WORKITEM add WORKITEMSOURCE varchar2(120);
comment on column BIZ_WORKITEM.WORKITEMSOURCE is '任务来源';

alter table BIZ_WORKITEM_FINISHED add WORKITEMSOURCE varchar2(120);
comment on column BIZ_WORKITEM_FINISHED.WORKITEMSOURCE is '任务来源';