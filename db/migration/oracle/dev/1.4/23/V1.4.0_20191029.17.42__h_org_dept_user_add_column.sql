
ALTER TABLE h_org_dept_user ADD (userSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_dept_user.userSourceId is '钉钉用户id非unionId';
ALTER TABLE h_org_dept_user ADD (deptSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_dept_user.deptSourceId is '钉钉部门id';

-- 更新数据
update h_org_dept_user,h_org_department set h_org_dept_user.deptSourceId = h_org_department.sourceId WHERE h_org_dept_user.deptId = h_org_department.id;

update h_org_dept_user,h_org_user set h_org_dept_user.userSourceId = h_org_user.userId WHERE h_org_dept_user.userId = h_org_user.id;