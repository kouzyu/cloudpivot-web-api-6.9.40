create table h_business_rule_runmap
(
	id varchar(120)
		constraint H_BUSINESS_RULE_RUNMAP_PK
			primary key,
	ruleCode varchar(40),
	ruleName varchar(100),
	ruleType varchar(15),
	nodeCode varchar(40),
	nodeName varchar(100),
	nodeType varchar(15),
	targetSchemaCode varchar(40),
	triggerSchemaCode varchar(40)
);

comment on column h_business_rule_runmap.id is '主键';

comment on column h_business_rule_runmap.ruleCode is '规则编码';

comment on column h_business_rule_runmap.ruleName is '规则名称';

comment on column h_business_rule_runmap.ruleType is '规则类型';

comment on column h_business_rule_runmap.nodeCode is '节点编码';

comment on column h_business_rule_runmap.nodeName is '节点名称';

comment on column h_business_rule_runmap.nodeType is '节点类型';

comment on column h_business_rule_runmap.targetSchemaCode is '目标对象模型编码';

comment on column h_business_rule_runmap.triggerSchemaCode is '触发对象模型编码';

