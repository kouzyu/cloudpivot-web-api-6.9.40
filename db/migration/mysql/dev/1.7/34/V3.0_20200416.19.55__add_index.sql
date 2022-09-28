ALTER TABLE `h_biz_property`
ADD INDEX `Idx_schemaCode` (`schemaCode`) USING BTREE ;

ALTER TABLE `h_biz_schema`
ADD INDEX `idx_schemaCode` (`code`) USING BTREE ;
