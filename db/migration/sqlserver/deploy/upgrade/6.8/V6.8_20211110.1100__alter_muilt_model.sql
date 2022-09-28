-- 视图多模型查询
ALTER TABLE h_biz_query_present ADD queryViewDataSource ntext
go
ALTER TABLE h_biz_query_present ADD schemaRelations ntext
go

ALTER TABLE h_biz_query_column ADD schemaAlias nvarchar(100)
go
ALTER TABLE h_biz_query_column ADD propertyAlias nvarchar(100)
go
ALTER TABLE h_biz_query_column ADD queryLevel int DEFAULT 1 NULL
go

update h_biz_query_column set schemaAlias = schemaCode where schemaAlias is null
go
update h_biz_query_column set propertyAlias = propertyCode where propertyAlias is null
go