ALTER TABLE h_org_department ADD (dingDeptManagerId VARCHAR(255) DEFAULT null);
comment on column h_org_department.dingDeptManagerId is '钉钉部门主管id集合';