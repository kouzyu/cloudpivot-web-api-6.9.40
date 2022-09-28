create table h_biz_data_rule (
  id varchar(120)
		constraint h_biz_data_rule_pk
			primary key,
  creater varchar2(120)  ,
  createdtime date  ,
  deleted number(1)  ,
  modifier varchar2(120)  ,
  modifiedtime date  ,
  remarks varchar2(200)  ,
  schemaCode varchar2(40)  ,
  propertyCode varchar2(40)  ,
  options CLOB  ,
  dataRuleType varchar2(40)  ,
  checkType number(1)
);