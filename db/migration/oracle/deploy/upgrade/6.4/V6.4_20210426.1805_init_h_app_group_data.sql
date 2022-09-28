INSERT INTO h_app_group (
 id, creater, createdtime, deleted, modifier, modifiedtime, remarks, code, disabled, name, sortkey, name_i18n
)
VALUES
	(
	'2c928fe6785dbfbb01785dc6277a0d1',
	NULL,
	TO_DATE( '2021-04-26 15:48:25', 'SYYYY-MM-DD HH24:MI:SS' ),
	'0',
	NULL,
	TO_DATE( '2021-04-26 15:48:36', 'SYYYY-MM-DD HH24:MI:SS' ),
	NULL,
	'all',
	NULL,
	'全部',
	'0',
NULL
	);

update h_app_package set groupId='2c928fe6785dbfbb01785dc6277a0000' where groupId is null or groupId='';
