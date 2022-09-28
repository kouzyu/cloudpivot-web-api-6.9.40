ALTER TABLE `h_biz_property`
ADD COLUMN `repeated`  int NULL DEFAULT 0 COMMENT '去重属性：1开启0不开启' AFTER `relativeQuoteCode`;