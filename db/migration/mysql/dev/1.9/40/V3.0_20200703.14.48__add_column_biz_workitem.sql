ALTER TABLE `biz_workitem` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_circulateitem` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_circulateitem_finished` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
