ALTER TABLE `h_org_dept_user` ADD COLUMN `userSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉用户id非unionId';
ALTER TABLE `h_org_dept_user` ADD COLUMN `deptSourceId` varchar(255) DEFAULT NULL COMMENT '钉钉部门id';

-- 更新数据
update h_org_dept_user,h_org_department set h_org_dept_user.deptSourceId = h_org_department.sourceId WHERE h_org_dept_user.deptId = h_org_department.id;

update h_org_dept_user,h_org_user set h_org_dept_user.userSourceId = h_org_user.userId WHERE h_org_dept_user.userId = h_org_user.id;