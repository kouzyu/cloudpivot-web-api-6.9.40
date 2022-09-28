-- 角色用户关联表联合索引
ALTER TABLE `h_org_role_user` ADD INDEX `idx_role_user_sourceid` (`userSourceId`,`roleSourceId`);

-- 部门用户关联表联合索引
ALTER TABLE `h_org_dept_user` ADD INDEX `idx_dept_user_composeid` (`userId`,`deptId`);