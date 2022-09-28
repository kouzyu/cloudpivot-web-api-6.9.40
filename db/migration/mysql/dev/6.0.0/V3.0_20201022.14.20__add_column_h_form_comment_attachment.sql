ALTER TABLE `h_from_comment_attachment`
ADD COLUMN `base64ImageStr` longtext NULL COMMENT 'base64图片' AFTER `fileSize`;