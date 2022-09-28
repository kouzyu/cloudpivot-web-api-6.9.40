ALTER TABLE `biz_workflow_instance`
ADD COLUMN `dataType`  varchar(20) NOT NULL DEFAULT 'NORMAL' COMMENT '数据类型，正常：NORMAL；模拟：SIMULATIVE',
ADD COLUMN `runMode`  varchar(20) NOT NULL DEFAULT 'MANUAL' COMMENT '运行模式，自动：AUTO；手动：MANUAL';
