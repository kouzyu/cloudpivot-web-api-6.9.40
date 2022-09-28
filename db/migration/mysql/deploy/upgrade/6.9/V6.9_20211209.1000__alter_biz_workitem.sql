ALTER TABLE biz_workitem ADD COLUMN workItemSource  varchar(120) NULL COMMENT '任务来源';

ALTER TABLE biz_workitem_finished ADD COLUMN workItemSource  varchar(120) NULL COMMENT '任务来源';