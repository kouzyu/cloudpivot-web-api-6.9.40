ALTER TABLE h_biz_sheet ADD (tempAuthSchemaCodes VARCHAR(350) DEFAULT null);
comment on column h_biz_sheet.tempAuthSchemaCodes is '临时授权的SchemaCode 以,分割';
