ALTER TABLE `h_biz_service`
ADD COLUMN `isShared`  bit(1) NULL DEFAULT 0 COMMENT '是否共享，0-私有，1共享' AFTER `serviceCategoryId`,
ADD COLUMN `userIds`  longtext CHARACTER SET utf8 NULL COMMENT '用戶id，多個用戶用逗號隔開' AFTER `isShared`;
