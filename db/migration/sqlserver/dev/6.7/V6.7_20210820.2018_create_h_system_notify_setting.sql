CREATE TABLE h_system_notify_setting (
  id nvarchar (36) NOT NULL PRIMARY KEY,
  corpId nvarchar(120) ,
  unitType nvarchar(120) ,
  msgChannelType nvarchar(120)
)
go