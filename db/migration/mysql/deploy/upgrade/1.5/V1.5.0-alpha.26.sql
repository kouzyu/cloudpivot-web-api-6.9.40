ALTER TABLE `h_biz_sheet` ADD COLUMN `borderMode` varchar (10) DEFAULT null COMMENT '表单是否支持边框模式,close或open';
ALTER TABLE `h_biz_sheet` ADD COLUMN `layout` varchar (20) DEFAULT null COMMENT '表单边框布局,horizontal-左右布局,vertical-上下布局';

ALTER TABLE `h_biz_sheet` change `layout` `layoutType` varchar(20);

CREATE TABLE `h_perm_license` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `bizId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '授权的业务id',
  `bizType` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '业务类型，USER：用户；DEPART：部门；ROLE：角色',
  `createdTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `h_biz_schema` MODIFY `remarks` varchar(2000) DEFAULT NULL;