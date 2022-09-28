ALTER TABLE `h_log_business_rule_header`
MODIFY COLUMN `schemaCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `originator`,
ADD COLUMN `sourceFlowInstanceId` varchar(120) NULL AFTER `success`,
ADD COLUMN `repair` bit(1) NULL DEFAULT NULL AFTER `sourceFlowInstanceId`,
ADD COLUMN `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL AFTER `repair`;