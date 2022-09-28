-- 附件表refid索引
ALTER TABLE `h_biz_attachment` ADD INDEX idx_h_biz_attachment_refid(`refid`);

-- 流程模板 编码和版本号联合索引
ALTER TABLE `h_workflow_template` ADD INDEX `idx_workflow_template_code_verison` (`workflowCode`,`workflowVersion`);

-- 展示字段 视图id和排序值联合索引
ALTER TABLE `h_biz_query_column` ADD INDEX `idx_biz_query_column_queryId_sortKey` (`queryId`,`sortKey`);

-- 查询字段 视图id和排序值联合索引
ALTER TABLE `h_biz_query_condition` ADD INDEX `idx_biz_query_condition_queryId_sortKey` (`queryId`,`sortKey`);

-- 用户表 账号名和组织id联合索引
ALTER TABLE `h_org_user` ADD INDEX `idx_org_user_username_corpid` (`username`,`corpId`);