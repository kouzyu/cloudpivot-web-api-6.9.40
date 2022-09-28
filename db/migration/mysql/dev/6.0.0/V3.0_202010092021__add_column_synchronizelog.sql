ALTER TABLE `h_org_synchronize_log`
ADD COLUMN `isSyncRoleScope`  tinyint NULL DEFAULT 0 AFTER `status`;