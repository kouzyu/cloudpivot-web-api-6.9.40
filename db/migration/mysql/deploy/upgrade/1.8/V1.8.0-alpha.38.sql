ALTER TABLE `h_biz_service`
    ADD COLUMN `isShared`  bit(1) NULL DEFAULT 0 COMMENT '是否共享，0-私有，1共享' AFTER `serviceCategoryId`,
ADD COLUMN `userIds`  longtext CHARACTER SET utf8 NULL COMMENT '用戶id，多個用戶用逗號隔開' AFTER `isShared`;
ALTER TABLE `biz_workflow_instance`
    ADD COLUMN `dataType`  varchar(20) NOT NULL DEFAULT 'NORMAL' COMMENT '数据类型，正常：NORMAL；模拟：SIMULATIVE',
ADD COLUMN `runMode`  varchar(20) NOT NULL DEFAULT 'MANUAL' COMMENT '运行模式，自动：AUTO；手动：MANUAL';
ALTER TABLE `h_biz_property`
    ADD COLUMN `relativeQuoteCode`  mediumtext  DEFAULT NULL COMMENT '关联表单引用属性' ;
ALTER TABLE `h_biz_service` CHANGE `isShared` `shared` bit(1);
ALTER TABLE `biz_workflow_token` ADD COLUMN `isSkipped` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否直接跳过';
