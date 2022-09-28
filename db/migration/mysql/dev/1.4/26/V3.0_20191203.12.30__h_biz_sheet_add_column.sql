ALTER TABLE `h_biz_sheet` ADD COLUMN `borderMode` varchar (10) DEFAULT null COMMENT '表单是否支持边框模式,close或open';
ALTER TABLE `h_biz_sheet` ADD COLUMN `layout` varchar (20) DEFAULT null COMMENT '表单边框布局,horizontal-左右布局,vertical-上下布局';
