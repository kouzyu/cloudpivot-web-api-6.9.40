create table h_perm_admin_group (
  id varchar(120)
		constraint h_perm_admin_group_pk
			primary key,
  creater varchar2(120 byte)  ,
  createdtime date  ,
  deleted number(1)  ,
  modifier varchar2(120 byte)  ,
  modifiedtime date  ,
  remarks varchar2(200 byte)  ,
  departmentsJson CLOB  ,
  appPackagesJson CLOB  ,
  name varchar2(50 byte)  ,
  adminId varchar(120)
  );

