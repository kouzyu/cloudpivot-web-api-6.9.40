ALTER TABLE `h_biz_sheet` ADD COLUMN `printTemplateJson` varchar(1000) DEFAULT NULL COMMENT '关联的打印模板';
ALTER TABLE `h_biz_sheet` ADD COLUMN `qrCodeAble` VARCHAR(40) DEFAULT NULL COMMENT '是否开启二维码';