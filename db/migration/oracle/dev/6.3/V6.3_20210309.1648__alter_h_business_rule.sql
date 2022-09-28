ALTER TABLE H_BUSINESS_RULE ADD ENABLED NUMBER(1);
ALTER TABLE H_BUSINESS_RULE ADD QUOTEPROPERTY CLOB;

comment on column H_BUSINESS_RULE.ENABLED is '是否生效';
comment on column H_BUSINESS_RULE.QUOTEPROPERTY is '引用编码 数据模型编码.数据项编码 ,分割';

update h_business_rule set enabled = 1 where enabled is null;