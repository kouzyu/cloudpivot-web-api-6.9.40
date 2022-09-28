ALTER TABLE `h_org_role_user`
ADD COLUMN `type`  varchar(10) NULL DEFAULT 0 COMMENT '取值：USER-用户，ORG-组织' AFTER `deptId`,
ADD COLUMN `orgIds`  longtext CHARACTER SET utf8 NULL COMMENT '当type值为ORG时，该字段不能为空，组织id，多个组织用逗号隔开' AFTER `type`;
