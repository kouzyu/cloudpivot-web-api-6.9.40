ALTER TABLE `h_org_department` ADD COLUMN `isShow` bit(1) DEFAULT 1 COMMENT '部门是否可见';

ALTER TABLE `h_org_department` ADD COLUMN `deptType` varchar(40) DEFAULT 'DEPT' COMMENT '部门类型';

ALTER TABLE `h_org_role_group` ADD COLUMN `roleType` varchar(40) DEFAULT 'SYS' COMMENT '角色类型';

ALTER TABLE `h_org_role` ADD COLUMN `roleType` varchar(40) DEFAULT 'SYS' COMMENT '角色类型';

ALTER TABLE `h_org_role_user` ADD COLUMN `unitType` varchar(40) DEFAULT 'USER' COMMENT '角色关联类型';

ALTER TABLE `h_org_role_user` ADD COLUMN `deptId` varchar(40)  COMMENT '角色关联部门ID';

update `h_org_role_group` set roleType = 'DINGTALK' where sourceId is not null;

update `h_org_role` set roleType = 'DINGTALK' where sourceId is not null;
