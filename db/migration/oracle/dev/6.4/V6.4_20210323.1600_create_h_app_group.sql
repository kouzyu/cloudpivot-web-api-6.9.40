create table h_app_group (
  id varchar(120)
		constraint h_app_group_pk
			primary key,
  creater varchar2(120 byte) visible ,
  createdtime date visible ,
  deleted number(1) visible ,
  modifier varchar2(120 byte) visible ,
  modifiedtime date visible ,
  remarks varchar2(200 byte) visible ,
  code varchar2(40 byte) visible ,
  disabled number(1) visible ,
  name varchar2(50 byte) visible ,
  sortkey number visible ,
  name_i18n varchar2(1000 byte) visible
);


INSERT INTO TESTCURSOR.h_app_group (
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