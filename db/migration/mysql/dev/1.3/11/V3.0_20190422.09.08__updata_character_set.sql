-- 修改用户名称字段的字符编码
ALTER TABLE `h_org_user` CHANGE `name` `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;