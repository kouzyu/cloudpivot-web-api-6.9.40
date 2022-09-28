CREATE TABLE h_biz_batch_update_record (
	id nvarchar (36) NOT NULL PRIMARY KEY,
	schemaCode nvarchar (40),
	propertyCode nvarchar (200),
	userId nvarchar (36),
	modifiedTime datetime,
	propertyName nvarchar (200),
	total INT,
	successCount INT,
	failCount INT,
	modifiedValue ntext
)
GO

ALTER TABLE h_perm_biz_function ADD batchUpdateAble bit;
go