create table h_user_common_comment (
  id nvarchar (36) NOT NULL PRIMARY KEY,
  createdTime datetime ,
  creater nvarchar(120) ,
  deleted BIT ,
  modifiedTime datetime ,
  modifier nvarchar(120) ,
  remarks nvarchar(200) ,
  content ntext ,
	sortKey INT,
  userId nvarchar(36)
)
go