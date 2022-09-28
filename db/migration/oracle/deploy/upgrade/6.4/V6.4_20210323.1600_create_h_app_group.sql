create table h_app_group (
  id varchar(120)
		constraint h_app_group_pk
			primary key,
  creater varchar2(120 )  ,
  createdtime date  ,
  deleted number(1)  ,
  modifier varchar2(120 )  ,
  modifiedtime date  ,
  remarks varchar2(200 )  ,
  code varchar2(40 )  ,
  disabled number(1)  ,
  name varchar2(50 )  ,
  sortkey number  ,
  name_i18n varchar2(1000 )
);


INSERT INTO h_app_group (
 id, creater, createdtime, deleted, modifier, modifiedtime, remarks, code, disabled, name, sortkey, name_i18n
)
VALUES
	(
	'2c928fe6785dbfbb01785dc6277a0d0',
	NULL,
	TO_DATE( '2021-04-16 15:48:25', 'SYYYY-MM-DD HH24:MI:SS' ),
	'0',
	NULL,
	TO_DATE( '2021-04-16 15:48:36', 'SYYYY-MM-DD HH24:MI:SS' ),
	NULL,
	'default',
	NULL,
	'默认',
	'1',
NULL 
	); 