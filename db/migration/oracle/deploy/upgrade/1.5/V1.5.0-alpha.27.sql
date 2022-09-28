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

ALTER TABLE d_process_template RENAME COLUMN wfWorkItemId TO queryId;
ALTER TABLE d_process_template MODIFY (queryId VARCHAR(42));
comment on column d_process_template.queryId is '列表ID';

INSERT INTO h_system_setting(id, paramCode, paramValue, settingType, checked, fileUploadType)
VALUES ('2c928e636f3fe9b5016f3feb81c70000', 'dingtalk.isSynEdu', 'false', 'DINGTALK_BASE', 0, NULL);

-- DROP index UK_h_system_pair_paramCode;
alter table h_system_pair drop constraint UK_h_system_pair_paramCode;
