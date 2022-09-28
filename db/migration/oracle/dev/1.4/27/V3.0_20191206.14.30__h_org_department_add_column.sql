ALTER TABLE h_org_department ADD (isShow number(1,0) DEFAULT 1);
comment on column h_org_department.isShow is '部门是否可见';

ALTER TABLE h_org_department ADD (deptType VARCHAR(40) DEFAULT 'DEPT');
comment on column h_org_department.deptType is '部门类型';

ALTER TABLE h_org_role_group ADD (roleType VARCHAR(40) DEFAULT 'SYS');
comment on column h_org_role_group.roleType is '角色类型';

ALTER TABLE h_org_role ADD (roleType VARCHAR(40) DEFAULT 'SYS');
comment on column h_org_role.roleType is '角色类型';

ALTER TABLE h_org_role_user ADD (unitType VARCHAR(40) DEFAULT 'USER');
comment on column h_org_role_user.unitType is '角色关联类型';

ALTER TABLE h_org_role_user ADD (deptId VARCHAR(40) );
comment on column h_org_role_user.deptId is '角色关联部门ID';

UPDATE h_org_role_group SET roleType = 'DINGTALK' WHERE  sourceId is not null;

UPDATE h_org_role SET roleType = 'DINGTALK' WHERE  sourceId is not null;
