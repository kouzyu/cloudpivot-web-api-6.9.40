alter table h_biz_sheet add formTrack BIT default 0;
go

alter table h_biz_sheet add trackDataCodes ntext;
go

alter table h_biz_sheet_history add formTrack BIT default 0;
go
alter table h_biz_sheet_history add trackDataCodes ntext ;
go

alter table h_perm_admin ADD dataDictionaryManage BIT default 0;
go

create table h_data_dictionary (
  id nvarchar (36) NOT NULL PRIMARY KEY,
  createdTime datetime,
  creater nvarchar(120),
  deleted BIT ,
  modifiedTime datetime,
  modifier nvarchar(120),
  remarks nvarchar(200),
  name nvarchar(50),
  code nvarchar(50),
  dictionaryType nvarchar(40) ,
  sortKey INT ,
  status BIT default 1,
  classificationId nvarchar(120)
)
go

create table h_dictionary_class (
  id nvarchar (36) NOT NULL PRIMARY KEY,
  createdTime datetime,
  creater nvarchar(120),
  deleted BIT ,
  modifiedTime datetime,
  modifier nvarchar(120),
  remarks nvarchar(200),
  name nvarchar(50),
  sortKey INT
)
go

CREATE TABLE h_dictionary_record (
  id nvarchar (36) NOT NULL PRIMARY KEY,
  createdTime datetime,
  creater nvarchar(120) ,
  deleted BIT ,
  modifiedTime datetime ,
  modifier nvarchar(120) ,
  remarks nvarchar(200) ,
  name nvarchar(50) ,
  code nvarchar(50) ,
  dictionaryId nvarchar(120) ,
  sortKey INT ,
  parentId nvarchar(120) ,
  status BIT default 1
)
go

create table h_biz_data_track (
  id nvarchar (36) NOT NULL PRIMARY KEY,
  createdTime datetime,
  creater nvarchar(120),
  deleted BIT,
  modifiedTime datetime,
  modifier nvarchar(120),
  remarks nvarchar(200),
  title nvarchar(200),
  bizObjectId nvarchar(120),
  departmentId nvarchar(120),
  departmentName nvarchar(50),
  creatorName nvarchar(50),
  schemaCode nvarchar(40),
  sheetCode nvarchar(40),
)
go

create table h_biz_data_track_detail (
  id nvarchar (36) NOT NULL PRIMARY KEY,
  createdTime datetime ,
  creater nvarchar(120) ,
  deleted BIT ,
  modifiedTime datetime ,
  modifier nvarchar(120) ,
  remarks nvarchar(200) ,
  trackId nvarchar(120) ,
  bizObjectId nvarchar(120) ,
  name nvarchar(50) ,
  beforeValue ntext ,
  afterValue ntext ,
  departmentName nvarchar(50),
  creatorName nvarchar(50),
  type nvarchar(40)
)
go

update h_biz_sheet set formTrack = 0 where formTrack is null or formTrack ='';
update h_biz_sheet_history set formTrack = 0 where formTrack is null or formTrack ='';
update h_perm_admin set dataDictionaryManage = 0 where dataDictionaryManage is null or dataDictionaryManage ='';