ALTER TABLE h_open_api_event
ADD COLUMN options longtext NULL COMMENT '扩展参数' AFTER eventType;