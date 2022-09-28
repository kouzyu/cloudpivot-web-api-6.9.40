ALTER TABLE `h_perm_department_scope`
MODIFY COLUMN `name`  varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `adminId`;

