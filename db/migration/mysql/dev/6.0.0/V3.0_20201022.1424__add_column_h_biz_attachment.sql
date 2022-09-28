ALTER TABLE `h_biz_attachment`
ADD COLUMN `base64ImageStr` longtext NULL COMMENT 'base64图片' AFTER `fileSize`;