ALTER TABLE `h_timer_job` ADD COLUMN `taskId` VARCHAR(120) DEFAULT NULL COMMENT '任务id';
ALTER TABLE `h_job_result` ADD COLUMN `taskId` VARCHAR(120) DEFAULT NULL COMMENT '任务id';