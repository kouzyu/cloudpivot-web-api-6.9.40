alter table H_BIZ_PERM_GROUP add appPermGroupId varchar2(120) ;

comment on column H_BIZ_PERM_GROUP.appPermGroupId is '关联的应用管理权限组ID';