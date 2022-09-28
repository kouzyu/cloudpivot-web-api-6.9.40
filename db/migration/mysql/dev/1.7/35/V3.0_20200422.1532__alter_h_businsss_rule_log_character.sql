ALTER TABLE `h_log_business_rule_content`
MODIFY COLUMN `triggerCoreData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL AFTER `flowInstanceId`;


ALTER TABLE `h_log_business_rule_data_trace`
MODIFY COLUMN `traceLastData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL AFTER `targetSchemaCode`,
MODIFY COLUMN `traceSetData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL AFTER `traceLastData`,
MODIFY COLUMN `traceUpdateDetail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NULL AFTER `traceSetData`;


ALTER TABLE `h_log_business_rule_header`
ADD INDEX `idx_h_log_business_rule_header_flowInstanceId` (`flowInstanceId`) USING BTREE ;

ALTER TABLE `h_log_business_rule_content`
ADD INDEX `idx_h_log_business_rule_content_flowInstanceId` (`flowInstanceId`) USING BTREE ;

ALTER TABLE `h_log_business_rule_node`
ADD INDEX `idx_h_log_business_rule_node_flowInstanceId` (`flowInstanceId`) USING BTREE ;

ALTER TABLE `h_log_business_rule_data_trace`
ADD INDEX `idx_h_log_business_rule_data_trace_flowInstanceId` (`flowInstanceId`) USING BTREE ;

