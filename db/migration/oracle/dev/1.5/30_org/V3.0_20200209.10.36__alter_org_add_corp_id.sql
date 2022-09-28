
-- 部门新增组织外键关联
ALTER TABLE `h_org_department`
ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 部门历史新增组织外键关联
ALTER TABLE `h_org_department_history`
ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;

ALTER TABLE h_org_user ADD (corpId VARCHAR(256) DEFAULT null);
comment on column h_org_user.corpId is '用户新增组织外键关联';

ALTER TABLE h_org_role_group ADD (corpId VARCHAR(256) DEFAULT null);
comment on column h_org_role_group.corpId is '角色组新增组织外键关联';

ALTER TABLE h_org_role ADD (corpId VARCHAR(256) DEFAULT null);
comment on column h_org_role.corpId is '角色新增组织外键关联';