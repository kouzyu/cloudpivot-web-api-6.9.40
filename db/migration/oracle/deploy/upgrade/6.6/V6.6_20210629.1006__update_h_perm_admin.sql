ALTER TABLE h_perm_admin ADD roleManage NUMBER(1);
comment ON COLUMN h_perm_admin.roleManage IS '角色管理权限';
UPDATE h_perm_admin SET roleManage = 1 WHERE adminType IN ('SYS_MNG', 'ADMIN');

