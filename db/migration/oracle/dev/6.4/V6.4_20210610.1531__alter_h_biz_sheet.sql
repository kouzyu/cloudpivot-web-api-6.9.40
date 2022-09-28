ALTER TABLE H_BIZ_SHEET ADD formTrack NUMBER(1);

comment on column H_BIZ_SHEET.formTrack is '是否开启表单留痕' ;

ALTER TABLE H_BIZ_SHEET ADD trackDataCodes CLOB;

comment on column H_BIZ_SHEET.trackDataCodes is '需要留痕的表单数据项code,用 ; 号分割' ;

update H_BIZ_SHEET set formTrack = 0 where formTrack is null;