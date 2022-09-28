ALTER TABLE H_DICTIONARY_RECORD ADD initialUsed NUMBER(1);

comment on column H_DICTIONARY_RECORD.initialUsed is '字典数据历史使用状态' ;

update H_DICTIONARY_RECORD set initialUsed = 0 where initialUsed is null or initialUsed = '';

alter table H_BIZ_QUERY_CONDITION modify options VARCHAR2(2048);