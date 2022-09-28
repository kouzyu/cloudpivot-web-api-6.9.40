create table h_workflow_trust
(
    id                        varchar2(42) not null primary key,
    workflowTrustRuleId       varchar2(42) null,
    workflowCode              varchar2(40) null,
    creater                   varchar2(42) null,
    createTime                date         null
);

create table h_workflow_trust_rule
(
    id                        varchar2(42) not null primary key,
    trustor                   varchar2(42) null,
    trustorName               varchar2(80) null,
    trustee                   varchar2(42) null,
    trusteeName               varchar2(80) null,
    trustType                 varchar2(20) null,
    startTime                 date         null,
    endTime                   date         null,
    rangeType                 varchar2(20) null,
    state                     varchar2(20) null,
    creater                   varchar2(42) null,
    createTime                date         null,
    modifier                  varchar2(42) null,
    modifiedTime              date         null
);

create index IDX_WF_TRUSTOR on h_workflow_trust_rule(trustor);
create index IDX_WF_TRUSTEE on h_workflow_trust_rule(trustee);

ALTER TABLE biz_workitem ADD (isTrust number(1, 0) DEFAULT null);
ALTER TABLE biz_workitem ADD (trustor varchar2(42) DEFAULT null);
ALTER TABLE biz_workitem ADD (trustorName varchar2(80) DEFAULT null);
comment on column biz_workitem.isTrust is '是否被委托，0：否；1：是';
comment on column biz_workitem.trustor is '委托人ID';
comment on column biz_workitem.trustorName is '委托人名称';

ALTER TABLE biz_workitem_finished ADD (isTrust number(1, 0) DEFAULT null);
ALTER TABLE biz_workitem_finished ADD (trustor varchar2(42) DEFAULT null);
ALTER TABLE biz_workitem_finished ADD (trustorName varchar2(80) DEFAULT null);
comment on column biz_workitem_finished.isTrust is '是否被委托，0：否；1：是';
comment on column biz_workitem_finished.trustor is '委托人ID';
comment on column biz_workitem_finished.trustorName is '委托人名称';

ALTER TABLE biz_workflow_instance ADD (trustType varchar2(20) DEFAULT null);
ALTER TABLE biz_workflow_instance ADD (trustee varchar2(42) DEFAULT null);
ALTER TABLE biz_workflow_instance ADD (trusteeName varchar2(80) DEFAULT null);
comment on column biz_workflow_instance.trustType is '委托类型，流程审批：APPROVAL；流程发起：START';
comment on column biz_workflow_instance.trustee is '被委托人ID';
comment on column biz_workflow_instance.trusteeName is '被委托人名称';

