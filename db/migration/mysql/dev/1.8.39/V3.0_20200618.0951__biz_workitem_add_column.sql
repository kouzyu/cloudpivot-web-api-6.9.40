ALTER TABLE `biz_workitem` ADD COLUMN `rootTaskId` varchar(42) DEFAULT NULL;
ALTER TABLE `biz_workitem` ADD COLUMN `sourceTaskId` varchar(42) DEFAULT NULL;

ALTER TABLE `biz_workitem_finished` ADD COLUMN `rootTaskId` varchar(42) DEFAULT NULL;
ALTER TABLE `biz_workitem_finished` ADD COLUMN `sourceTaskId` varchar(42) DEFAULT NULL;