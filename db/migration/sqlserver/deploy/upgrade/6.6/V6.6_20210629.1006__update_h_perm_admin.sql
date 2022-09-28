alter table h_perm_admin add roleManage bit null;
GO
update h_perm_admin set roleManage = 1 where adminType in ('SYS_MNG', 'ADMIN');