create table h_user_common_comment (
  id varchar(36) primary key,
  createdTime date,
  creater varchar2(120),
  deleted NUMBER(1),
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
	content CLOB,
	sortKey number(11),
  userId varchar2(36)
  );