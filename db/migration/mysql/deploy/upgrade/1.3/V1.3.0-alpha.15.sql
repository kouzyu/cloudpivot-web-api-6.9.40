ALTER TABLE `h_perm_function_condition` ADD `functionId` varchar(40) DEFAULT NULL;

ALTER TABLE `h_org_dept_user` ADD `sortKey` varchar(200) DEFAULT NULL;
ALTER TABLE `h_org_dept_user` ADD `leader` bit(1) DEFAULT NULL;
