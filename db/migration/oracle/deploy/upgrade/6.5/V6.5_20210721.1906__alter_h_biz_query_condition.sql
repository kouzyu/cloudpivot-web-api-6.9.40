
ALTER TABLE H_BIZ_QUERY_CONDITION ADD temp_switch_column CLOB;

UPDATE H_BIZ_QUERY_CONDITION SET temp_switch_column = "TO_CLOB" (options);

COMMIT;

ALTER TABLE H_BIZ_QUERY_CONDITION DROP COLUMN options;

ALTER TABLE H_BIZ_QUERY_CONDITION RENAME COLUMN temp_switch_column TO options;

comment on column H_BIZ_QUERY_CONDITION.options is '下拉选项' ;