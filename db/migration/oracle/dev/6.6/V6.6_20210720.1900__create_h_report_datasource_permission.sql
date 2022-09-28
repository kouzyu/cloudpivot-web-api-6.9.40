create table h_report_datasource_permission
(
	id varchar(36) primary key,
   creater              varchar2(120),
   createdTime          date,
   modifier             varchar2(120) ,
   modifiedTime         date,
   remarks              varchar2(256),
   objectId             varchar2(64),
   userScope            CLOB,
   ownerId              varchar2(32),
   nodeType             number(1)
);

create unique index uq_object_id
	on h_report_datasource_permission (objectId)
