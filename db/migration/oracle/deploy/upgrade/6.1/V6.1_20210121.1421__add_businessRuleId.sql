alter table H_BIZ_METHOD_MAPPING	add businessRuleId varchar(40);
comment on column H_BIZ_METHOD_MAPPING.businessRuleId is '关联的业务规则id';

alter table H_BIZ_METHOD_MAPPING	add nodeCode varchar(40);
comment on column H_BIZ_METHOD_MAPPING.nodeCode is '关联的业务规则节点';