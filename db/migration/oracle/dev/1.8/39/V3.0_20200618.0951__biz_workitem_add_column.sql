ALTER TABLE biz_workitem ADD (rootTaskId varchar2(42) DEFAULT NULL);
ALTER TABLE biz_workitem ADD (sourceTaskId varchar2(42) DEFAULT NULL);

ALTER TABLE biz_workitem_finished ADD (rootTaskId varchar2(42) DEFAULT NULL);
ALTER TABLE biz_workitem_finished ADD (sourceTaskId varchar2(42) DEFAULT NULL);