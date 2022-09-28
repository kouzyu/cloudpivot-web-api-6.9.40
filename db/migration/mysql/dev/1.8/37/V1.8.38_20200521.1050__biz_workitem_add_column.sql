ALTER TABLE `biz_workitem` ADD COLUMN `batchOperate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许批量处理，0：否；1：是';

ALTER TABLE `biz_workitem_finished` ADD COLUMN `batchOperate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否允许批量处理，0：否；1：是';