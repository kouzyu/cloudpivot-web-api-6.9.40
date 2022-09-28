ALTER TABLE biz_workitem ADD (batchOperate number(1, 0) DEFAULT null);
ALTER TABLE biz_workitem_finished ADD (batchOperate number(1, 0) DEFAULT null);
comment on column biz_workitem.batchOperate is '是否允许批量处理，0：否；1：是';
comment on column biz_workitem_finished.batchOperate is '是否允许批量处理，0：否；1：是';