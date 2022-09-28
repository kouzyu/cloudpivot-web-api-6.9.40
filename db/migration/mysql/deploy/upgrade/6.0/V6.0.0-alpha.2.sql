ALTER TABLE `h_biz_property`
ADD COLUMN `selectionJson` longtext NULL COMMENT '下拉框存值' AFTER `repeated`;

ALTER TABLE `h_org_synchronize_log`
ADD COLUMN `isSyncRoleScope`  tinyint NULL DEFAULT 0 AFTER `status`;

ALTER TABLE `h_org_role_user`
MODIFY COLUMN `ouScope`  longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `remarks`;

ALTER table h_perm_biz_function add column batchPrintAble bit(1) default null comment '批量打印';

ALTER TABLE `h_biz_attachment`
ADD COLUMN `base64ImageStr` longtext NULL COMMENT 'base64图片' AFTER `fileSize`;

ALTER TABLE `h_from_comment_attachment`
ADD COLUMN `base64ImageStr` longtext NULL COMMENT 'base64图片' AFTER `fileSize`;