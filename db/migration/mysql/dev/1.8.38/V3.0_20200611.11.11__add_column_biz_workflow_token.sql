ALTER TABLE `biz_workflow_token` ADD COLUMN `isSkipped` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否直接跳过';
