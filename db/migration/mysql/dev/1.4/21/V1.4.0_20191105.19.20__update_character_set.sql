-- 修改部门名称字段的字符编码
ALTER TABLE `h_org_department` CHANGE `name` `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

-- 修改角色名称字段的字符编码
ALTER TABLE `h_org_role` CHANGE `name` `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

-- 修改日志表内容字段的字符编码
ALTER TABLE `h_log_metadata` CHANGE `metaData` `metaData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;