ALTER TABLE `h_im_message` ADD COLUMN `externalLink` bit(1) DEFAULT NULL COMMENT '是否是外部链接';
ALTER TABLE `h_im_message_history` ADD COLUMN `externalLink` bit(1) DEFAULT NULL COMMENT '是否是外部链接';