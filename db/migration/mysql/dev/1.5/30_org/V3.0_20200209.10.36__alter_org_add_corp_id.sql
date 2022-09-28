
-- 用户新增组织外键关联
ALTER TABLE `h_org_user`
ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 角色组新增组织外键关联
ALTER TABLE `h_org_role_group`
ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 角色新增组织外键关联
ALTER TABLE `h_org_role`
ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 部门新增组织外键关联
ALTER TABLE `h_org_department`
ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 部门历史新增组织外键关联
ALTER TABLE `h_org_department_history`
ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;