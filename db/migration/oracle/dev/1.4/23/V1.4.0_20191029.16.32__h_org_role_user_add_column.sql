
ALTER TABLE h_org_role_user ADD (userSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_role_user.userSourceId is '钉钉用户id非unionId';
ALTER TABLE h_org_role_user ADD (roleSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_role_user.roleSourceId is '钉钉角色id';

-- 更新数据
update h_org_role_user,h_org_role set h_org_role_user.roleSourceId = h_org_role.sourceId WHERE h_org_role_user.roleId = h_org_role.id;

update h_org_role_user,h_org_user set h_org_role_user.userSourceId = h_org_user.userId WHERE h_org_role_user.userId = h_org_user.id;