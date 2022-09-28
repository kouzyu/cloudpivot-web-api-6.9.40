ALTER TABLE `base_security_client` MODIFY `registeredRedirectUris` varchar(2000) DEFAULT NULL;

ALTER TABLE `h_biz_sheet` ADD COLUMN `externalLinkAble` bit(1) DEFAULT 0 COMMENT '是否开启外链';