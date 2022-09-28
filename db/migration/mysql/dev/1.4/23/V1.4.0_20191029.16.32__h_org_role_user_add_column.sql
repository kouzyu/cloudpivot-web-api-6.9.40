ALTER TABLE `h_org_role_user` ADD COLUMN `userSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉用户id非unionId';
ALTER TABLE `h_org_role_user` ADD COLUMN `roleSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉角色id';

-- 更新数据
update h_org_role_user,h_org_role set h_org_role_user.roleSourceId = h_org_role.sourceId WHERE h_org_role_user.roleId = h_org_role.id;

update h_org_role_user,h_org_user set h_org_role_user.userSourceId = h_org_user.userId WHERE h_org_role_user.userId = h_org_user.id;