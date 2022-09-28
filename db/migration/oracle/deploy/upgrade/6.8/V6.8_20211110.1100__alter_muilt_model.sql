-- 视图多模型查询
ALTER TABLE h_biz_query_present ADD (queryViewDataSource CLOB DEFAULT NULL);
comment on column h_biz_query_present.queryViewDataSource is '视图属性-数据源';
ALTER TABLE h_biz_query_present ADD (schemaRelations CLOB DEFAULT NULL);
comment on column h_biz_query_present.schemaRelations is '视图多模型查询，关联关系';

ALTER TABLE h_biz_query_column ADD (schemaAlias VARCHAR2(100 BYTE) DEFAULT NULL);
comment on column h_biz_query_column.schemaAlias is '模型编码别名';
ALTER TABLE h_biz_query_column ADD (propertyAlias VARCHAR2(100 BYTE) DEFAULT NULL);
comment on column h_biz_query_column.propertyAlias is '数据项编码别名';
ALTER TABLE h_biz_query_column ADD (queryLevel NUMBER);
comment on column h_biz_query_column.queryLevel is '查询批次 1-主表 2-子表';

update h_biz_query_column set schemaAlias = schemaCode where schemaAlias is null ;
update h_biz_query_column set propertyAlias = propertyCode where propertyAlias is null;