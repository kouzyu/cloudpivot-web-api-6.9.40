alter table H_PERM_ADMIN add APPMANAGE NUMBER;

comment on column H_PERM_ADMIN.APPMANAGE is '是有拥有创建应用的权限';