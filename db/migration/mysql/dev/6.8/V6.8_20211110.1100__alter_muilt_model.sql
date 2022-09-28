-- 视图多模型查询

ALTER TABLE h_biz_query_present
ADD COLUMN queryViewDataSource longtext NULL COMMENT '视图属性-数据源' AFTER columnsJson,
ADD COLUMN schemaRelations longtext NULL COMMENT '视图多模型查询，关联关系' AFTER queryViewDataSource;

ALTER TABLE h_biz_query_column
ADD COLUMN schemaAlias varchar(100)  NULL DEFAULT NULL COMMENT '模型编码别名' AFTER clientType,
ADD COLUMN propertyAlias varchar(100) NULL DEFAULT NULL COMMENT '数据项编码别名' AFTER schemaAlias,
ADD COLUMN queryLevel int(4) NULL DEFAULT 1 COMMENT '查询批次 1-主表 2-子表' AFTER propertyAlias;

update h_biz_query_column set schemaAlias = schemaCode where schemaAlias is null ;
update h_biz_query_column set propertyAlias = propertyCode where propertyAlias is null;