CREATE TABLE `h_biz_query_present` (
   `id` varchar(120) COLLATE utf8_bin NOT NULL,
   `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL,
   `createdTime` datetime DEFAULT NULL,
   `deleted` bit(1) DEFAULT NULL,
   `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL,
   `modifiedTime` datetime DEFAULT NULL,
   `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL,
   `queryId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
   `schemaCode` varchar(40) COLLATE utf8_bin DEFAULT NULL,
   `clientType` varchar(40) DEFAULT NULL COMMENT 'PC或者MOBILE端',
   `htmlJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表htmlJson数据',
   `actionsJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表action操作JSON数据',
   `columnsJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表展示字段columnJSON数据',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


ALTER TABLE `h_biz_query` ADD COLUMN `queryPresentationType` varchar(40) DEFAULT 'LIST' COMMENT '列表视图类型';

ALTER TABLE `h_biz_query` ADD COLUMN `showOnPc` bit(1) DEFAULT NULL COMMENT 'PC是否可见';

ALTER TABLE `h_biz_query` ADD COLUMN `showOnMobile` bit(1) DEFAULT NULL COMMENT '移动端是否可见';

ALTER TABLE `h_biz_query` ADD COLUMN `publish` bit(1) DEFAULT NULL COMMENT '发布状态';

ALTER TABLE `h_biz_query_column` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_condition` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_sorter` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_action` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';


ALTER TABLE `h_org_department` ADD COLUMN `dingDeptManagerId` varchar(255) DEFAULT NULL COMMENT '钉钉部门主管id集合';

ALTER TABLE `h_org_role_user` ADD COLUMN `userSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉用户id非unionId';
ALTER TABLE `h_org_role_user` ADD COLUMN `roleSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉角色id';

-- 更新数据
update h_org_role_user,h_org_role set h_org_role_user.roleSourceId = h_org_role.sourceId WHERE h_org_role_user.roleId = h_org_role.id;

update h_org_role_user,h_org_user set h_org_role_user.userSourceId = h_org_user.userId WHERE h_org_role_user.userId = h_org_user.id;


ALTER TABLE `h_org_dept_user` ADD COLUMN `userSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉用户id非unionId';
ALTER TABLE `h_org_dept_user` ADD COLUMN `deptSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉部门id';

-- 更新数据
update h_org_dept_user,h_org_department set h_org_dept_user.deptSourceId = h_org_department.sourceId WHERE h_org_dept_user.deptId = h_org_department.id;

update h_org_dept_user,h_org_user set h_org_dept_user.userSourceId = h_org_user.userId WHERE h_org_dept_user.userId = h_org_user.id;


-- 角色用户关联表联合索引
ALTER TABLE `h_org_role_user` ADD INDEX `idx_role_user_sourceid` (`userSourceId`,`roleSourceId`);

-- 部门用户关联表联合索引
ALTER TABLE `h_org_dept_user` ADD INDEX `idx_dept_user_composeid` (`userId`,`deptId`);

-- 修改部门名称字段的字符编码
ALTER TABLE `h_org_department` CHANGE `name` `name` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

-- 修改角色名称字段的字符编码
ALTER TABLE `h_org_role` CHANGE `name` `name` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;

-- 修改日志表内容字段的字符编码
ALTER TABLE `h_log_metadata` CHANGE `metaData` `metaData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;