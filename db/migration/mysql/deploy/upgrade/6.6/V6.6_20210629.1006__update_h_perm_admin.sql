ALTER TABLE h_perm_admin ADD COLUMN roleManage bit(1) comment '角色管理权限';
UPDATE h_perm_admin SET roleManage = TRUE WHERE adminType IN ('SYS_MNG', 'ADMIN');
