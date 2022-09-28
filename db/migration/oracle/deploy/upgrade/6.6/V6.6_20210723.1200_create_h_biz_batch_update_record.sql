create table h_biz_batch_update_record (
  id varchar(36) primary key,
  schemaCode varchar2(40)  ,
  propertyCode varchar2(200)  ,
  userId varchar2(36),
  modifiedTime date,
  propertyName varchar2(200),
  total NUMBER(10,0),
  successCount NUMBER(10,0),
  failCount NUMBER(10,0),
  modifiedValue CLOB
  );

ALTER TABLE h_perm_biz_function ADD batchUpdateAble NUMBER(1);
comment ON COLUMN h_perm_biz_function.batchUpdateAble IS '批量修改';