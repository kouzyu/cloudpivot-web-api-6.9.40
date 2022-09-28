CREATE TABLE h_workflow_admin_scope (
	id nvarchar(120) NOT NULL PRIMARY KEY,
	creater nvarchar(120),
	createdTime datetime,
	deleted bit,
	modifier nvarchar(120),
	modifiedTime datetime,
	remarks nvarchar(200),
	adminId nvarchar(120),
	unitType nvarchar(10),
	unitId nvarchar(36)
)
GO