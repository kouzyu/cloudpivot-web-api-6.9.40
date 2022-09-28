ALTER TABLE `h_org_user` ADD COLUMN `imgUrlId` varchar(40) DEFAULT NULL COMMENT '头像id';
ALTER TABLE `h_biz_query_condition` ADD COLUMN `dateType` varchar(40) DEFAULT null COMMENT '日期快捷方式';