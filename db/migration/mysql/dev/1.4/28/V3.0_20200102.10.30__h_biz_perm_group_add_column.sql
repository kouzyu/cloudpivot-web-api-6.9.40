ALTER TABLE `h_biz_perm_group` ADD COLUMN `departments` longtext COMMENT '部门范围';
ALTER TABLE `h_biz_perm_group` ADD COLUMN `authorType` varchar(40) DEFAULT null COMMENT '授权类型';
