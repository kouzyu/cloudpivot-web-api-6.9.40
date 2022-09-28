ALTER TABLE `h_org_department` ADD COLUMN `isShow` bit(1) DEFAULT 1 COMMENT '部门是否可见';

ALTER TABLE `h_org_department` ADD COLUMN `deptType` varchar(40) DEFAULT 'DEPT' COMMENT '部门类型';

ALTER TABLE `h_org_role_group` ADD COLUMN `roleType` varchar(40) DEFAULT 'SYS' COMMENT '角色类型';

ALTER TABLE `h_org_role` ADD COLUMN `roleType` varchar(40) DEFAULT 'SYS' COMMENT '角色类型';

ALTER TABLE `h_org_role_user` ADD COLUMN `unitType` varchar(40) DEFAULT 'USER' COMMENT '角色关联类型';

ALTER TABLE `h_org_role_user` ADD COLUMN `deptId` varchar(40)  COMMENT '角色关联部门ID';

update `h_org_role_group` set roleType = 'DINGTALK' where sourceId is not null;

update `h_org_role` set roleType = 'DINGTALK' where sourceId is not null;

ALTER TABLE d_process_template CHANGE wfWorkItemId queryId VARCHAR(42) DEFAULT NULL COMMENT '列表ID';

INSERT INTO `h_system_setting`(`id`, `paramCode`, `paramValue`, `settingType`, `checked`, `fileUploadType`) VALUES ('2c928e636f3fe9b5016f3feb81c70000', 'dingtalk.isSynEdu', 'false', 'DINGTALK_BASE', b'0', NULL);

ALTER TABLE `h_system_pair`
MODIFY COLUMN `paramCode`  varchar(200) BINARY CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `id`;

DROP index UK_9tviae6s7glway1kpyiybg4yp on `h_system_pair`;