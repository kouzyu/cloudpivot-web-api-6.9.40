ALTER TABLE H_BIZ_SHEET ADD formTrack NUMBER(1);

comment on column H_BIZ_SHEET.formTrack is '是否开启表单留痕' ;

ALTER TABLE H_BIZ_SHEET ADD trackDataCodes CLOB;

comment on column H_BIZ_SHEET.trackDataCodes is '需要留痕的表单数据项code,用 ; 号分割' ;

update H_BIZ_SHEET set formTrack = 0 where formTrack is null or formTrack = '';


ALTER TABLE H_BIZ_SHEET_HISTORY ADD formTrack NUMBER(1);

comment on column H_BIZ_SHEET_HISTORY.formTrack is '是否开启表单留痕' ;

ALTER TABLE H_BIZ_SHEET_HISTORY ADD trackDataCodes CLOB;

comment on column H_BIZ_SHEET_HISTORY.trackDataCodes is '需要留痕的表单数据项code,用 ; 号分割' ;

update H_BIZ_SHEET_HISTORY set formTrack = 0 where formTrack is null or formTrack = '';

ALTER TABLE H_PERM_ADMIN ADD dataDictionaryManage NUMBER(1);

comment on column H_PERM_ADMIN.dataDictionaryManage is '是否有数据字典管理权限' ;

update H_PERM_ADMIN set dataDictionaryManage = 0 where dataDictionaryManage is null or dataDictionaryManage = '';


create table h_data_dictionary (
  id varchar2(120)
        constraint h_data_dictionary_pk
			primary key,
  createdTime date,
  creater varchar2(120),
  deleted number(1) ,
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
  name varchar2(50),
  code varchar2(50),
  dictionaryType varchar2(40) ,
  sortKey number(11) ,
  status number(1),
  classificationId varchar2(120)
) ;

create table h_dictionary_class (
  id varchar2(120)
        constraint h_dictionary_class_pk
			primary key,
  createdTime date,
  creater varchar2(120),
  deleted number(1) ,
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
  name varchar2(50),
  sortKey number(11)
);

CREATE TABLE h_dictionary_record (
  id varchar2(120)
          constraint h_dictionary_record_pk
			primary key,
  createdTime date,
  creater varchar2(120) ,
  deleted number(1) ,
  modifiedTime date ,
  modifier varchar2(120) ,
  remarks varchar2(200) ,
  name varchar2(50) ,
  code varchar2(50) ,
  dictionaryId varchar2(120) ,
  sortKey number(11) ,
  parentId varchar2(120) ,
  status number(1)
);

create table h_biz_data_track (
  id varchar2(120)
          constraint h_biz_data_track_pk
			primary key,
  createdTime date,
  creater varchar2(120),
  deleted number(1),
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
  title varchar2(200),
  bizObjectId varchar2(120),
  departmentId varchar2(120),
  departmentName varchar2(50),
  creatorName varchar2(50),
  schemaCode varchar2(40),
  sheetCode varchar2(40)
);

create table h_biz_data_track_detail (
  id varchar2(120)
          constraint h_biz_data_track_detail_pk
			primary key,
  createdTime date ,
  creater varchar2(120) ,
  deleted number(1) ,
  modifiedTime date ,
  modifier varchar2(120) ,
  remarks varchar2(200) ,
  trackId varchar2(120) ,
  bizObjectId varchar2(120) ,
  name varchar2(50) ,
  beforeValue CLOB ,
  afterValue CLOB ,
  type varchar2(40),
  departmentName varchar2(50),
  creatorName varchar2(50)
);