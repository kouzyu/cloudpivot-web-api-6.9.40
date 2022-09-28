CREATE TABLE h_workflow_admin (
	id nvarchar(120) NOT NULL PRIMARY KEY,
	creater nvarchar(120),
	createdTime datetime,
	deleted bit,
	modifier nvarchar(120),
	modifiedTime datetime,
	remarks nvarchar(200),
	adminType nvarchar(120),
	workflowCode nvarchar(200),
	manageScope nvarchar(512),
	options ntext
) GO;