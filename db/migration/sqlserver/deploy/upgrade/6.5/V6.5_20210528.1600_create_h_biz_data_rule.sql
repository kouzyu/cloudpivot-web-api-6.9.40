CREATE TABLE h_biz_data_rule (
	id nvarchar (36) NOT NULL PRIMARY KEY,
	creater nvarchar (120),
	createdTime datetime,
	deleted BIT,
	modifiedTime datetime,
	modifier nvarchar (120),
	remarks nvarchar (200),
	schemaCode nvarchar (40),
	propertyCode nvarchar (40),
	options ntext,
	dataRuleType nvarchar (40),
	checkType INT
)