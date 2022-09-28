ALTER TABLE biz_workflow_instance
ADD COLUMN source varchar(255) NULL COMMENT '来源';

ALTER TABLE biz_workflow_instance_bak
ADD COLUMN source varchar(255) NULL COMMENT '来源';