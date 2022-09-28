create table h_report_datasource_permission
(
       id           nvarchar(120) not null
        primary key,
   creater              nvarchar(120),
   createdTime          datetime,
   modifier             nvarchar(120) ,
   modifiedTime         datetime,
   remarks              nvarchar(256),
   objectId             nvarchar(64),
   userScope            ntext,
   ownerId              nvarchar(32),
   nodeType             bit
)
go


CREATE UNIQUE INDEX uq_object_id
   ON h_report_datasource_permission(objectId);
GO
