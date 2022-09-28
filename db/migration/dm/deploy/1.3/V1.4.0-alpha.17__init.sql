create table base_security_client
(
    id                          varchar2(120)  not null
        primary key,
    createdTime                 timestamp           null,
    creater                     varchar2(120)  null,
    deleted                     number(1, 0)   null,
    extend1                     varchar2(255)  null,
    extend2                     varchar2(255)  null,
    extend3                     varchar2(255)  null,
    extend4                     int            null,
    extend5                     int            null,
    modifiedTime                timestamp           null,
    modifier                    varchar2(120)  null,
    remarks                     varchar2(200)  null,
    accessTokenValiditySeconds  int            not null,
    additionInformation         varchar2(255)  null,
    authorities                 varchar2(255)  null,
    authorizedGrantTypes        varchar2(255)  null,
    autoApproveScopes           varchar2(255)  null,
    clientId                    varchar2(100)  null,
    clientSecret                varchar2(100)  null,
    refreshTokenValiditySeconds int            not null,
    registeredRedirectUris      varchar2(2000) null,
    resourceIds                 varchar2(255)  null,
    scopes                      varchar2(255)  null,
    type                        varchar2(10)   null
)
;
create table biz_circulateitem
(
    id                varchar2(36)  not null
        primary key,
    finishTime        timestamp          null,
    receiveTime       timestamp          null,
    startTime         timestamp          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       timestamp          null,
    appCode           varchar2(200) null,
    departmentId      varchar2(200) null,
    departmentName    varchar2(200) null,
    sheetCode         varchar2(200) null,
    instanceId        varchar2(36)  null,
    instanceName      varchar2(200) null,
    originator        varchar2(200) null,
    originatorName    varchar2(200) null,
    participant       varchar2(200) null,
    participantName   varchar2(200) null,
    sourceId          varchar2(200) null,
    sourceName        varchar2(200) null,
    state             varchar2(20)  null,
    stateValue        int           null,
    timeoutStrategy   varchar2(20)  null,
    timeoutWarn1      timestamp          null,
    timeoutWarn2      timestamp          null,
    usedtime          int           null,
    workItemType      varchar2(20)  null,
    workItemTypeValue int           null,
    workflowCode      varchar2(36)  null,
    workflowTokenId   varchar2(200) null,
    workflowVersion   int           null
);
create table biz_circulateitem_finished
(
    id                varchar2(36)  not null
        primary key,
    finishTime        timestamp          null,
    receiveTime       timestamp          null,
    startTime         timestamp          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       timestamp          null,
    appCode           varchar2(200) null,
    departmentId      varchar2(200) null,
    departmentName    varchar2(200) null,
    sheetCode         varchar2(200) null,
    instanceId        varchar2(36)  null,
    instanceName      varchar2(200) null,
    originator        varchar2(200) null,
    originatorName    varchar2(200) null,
    participant       varchar2(200) null,
    participantName   varchar2(200) null,
    sourceId          varchar2(200) null,
    sourceName        varchar2(200) null,
    state             varchar2(20)  null,
    stateValue        int           null,
    timeoutStrategy   varchar2(20)  null,
    timeoutWarn1      timestamp          null,
    timeoutWarn2      timestamp          null,
    usedtime          int           null,
    workItemType      varchar2(20)  null,
    workItemTypeValue int           null,
    workflowCode      varchar2(36)  null,
    workflowTokenId   varchar2(200) null,
    workflowVersion   int           null
);
create table biz_work_record
(
    id               varchar2(36)  not null
        primary key,
    workitemId       varchar2(36)  not null,
    recordId         varchar2(36)  not null,
    requestId        varchar2(36)  not null,
    receivers        CLOB          null,
    title            varchar2(100) null,
    content          varchar2(200) null,
    url              varchar2(500) null,
    receiveTime      timestamp          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      timestamp          null,
    modifiedTime     timestamp          null
)
;
create table biz_work_record_history
(
    taskId           varchar2(36)  not null,
    id               varchar2(36)  not null
        primary key,
    workitemId       varchar2(36)  not null,
    recordId         varchar2(36)  not null,
    requestId        varchar2(36)  not null,
    receivers        CLOB          null,
    title            varchar2(100) null,
    content          varchar2(200) null,
    url              varchar2(500) null,
    receiveTime      timestamp          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      timestamp          null,
    modifiedTime     timestamp          null
)
;
create table biz_workflow_instance
(
    id               varchar2(36)  not null
        primary key,
    finishTime       timestamp          null,
    receiveTime      timestamp          null,
    startTime        timestamp          null,
    appCode          varchar2(200) null,
    bizObjectId      varchar2(36)  null,
    departmentId     varchar2(200) null,
    departmentName   varchar2(200) null,
    instanceName     varchar2(200) null,
    originator       varchar2(200) null,
    originatorName   varchar2(200) null,
    parentId         varchar2(36)  null,
    remark           varchar2(200) null,
    state            varchar2(20)  null,
    stateValue       int           null,
    usedTime         int           null,
    waitTime         int           null,
    workflowCode     varchar2(200) null,
    workflowTokenId  varchar2(36)  null,
    workflowVersion  int           null,
    sheetBizObjectId varchar2(36)  null,
    sheetSchemaCode  varchar2(64)  null
);
create table biz_workflow_token
(
    id                 varchar2(36)  not null
        primary key,
    finishTime         timestamp          null,
    receiveTime        timestamp          null,
    startTime          timestamp          null,
    activityCode       varchar2(200) null,
    activityType       varchar2(20)  null,
    approvalCount      int           null,
    approvalExit       varchar2(20)  null,
    disapprovalCount   int           null,
    exceptional        varchar2(20)  null,
    instanceId         varchar2(36)  null,
    instanceState      varchar2(20)  null,
    isRejectBack       varchar2(10)  null,
    isRetrievable      int           null,
    itemCount          int           null,
    sourceActivityCode varchar2(200) null,
    state              varchar2(20)  null,
    stateValue         int           null,
    tokenId            int           null,
    usedtime           int           null
);
create table biz_workitem
(
    id                varchar2(36)  not null
        primary key,
    finishTime        timestamp          null,
    receiveTime       timestamp          null,
    startTime         timestamp          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       timestamp          null,
    appCode           varchar2(200) null,
    departmentId      varchar2(200) null,
    departmentName    varchar2(200) null,
    sheetCode         varchar2(200) null,
    instanceId        varchar2(36)  null,
    instanceName      varchar2(200) null,
    originator        varchar2(200) null,
    originatorName    varchar2(200) null,
    participant       varchar2(200) null,
    participantName   varchar2(200) null,
    sourceId          varchar2(200) null,
    sourceName        varchar2(200) null,
    state             varchar2(20)  null,
    stateValue        int           null,
    timeoutStrategy   varchar2(20)  null,
    timeoutWarn1      timestamp          null,
    timeoutWarn2      timestamp          null,
    usedtime          int           null,
    workItemType      varchar2(20)  null,
    workItemTypeValue int           null,
    workflowCode      varchar2(36)  null,
    workflowTokenId   varchar2(200) null,
    workflowVersion   int           null,
    approval          varchar2(20)  null,
    approvalValue     int           null
);
create table biz_workitem_finished
(
    id                varchar2(36)  not null
        primary key,
    finishTime        timestamp          null,
    receiveTime       timestamp          null,
    startTime         timestamp          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       timestamp          null,
    appCode           varchar2(200) null,
    departmentId      varchar2(200) null,
    departmentName    varchar2(200) null,
    sheetCode         varchar2(200) null,
    instanceId        varchar2(36)  null,
    instanceName      varchar2(200) null,
    originator        varchar2(200) null,
    originatorName    varchar2(200) null,
    participant       varchar2(200) null,
    participantName   varchar2(200) null,
    sourceId          varchar2(200) null,
    sourceName        varchar2(200) null,
    state             varchar2(20)  null,
    stateValue        int           null,
    timeoutStrategy   varchar2(20)  null,
    timeoutWarn1      timestamp          null,
    timeoutWarn2      timestamp          null,
    usedtime          int           null,
    workItemType      varchar2(20)  null,
    workItemTypeValue int           null,
    workflowCode      varchar2(36)  null,
    workflowTokenId   varchar2(200) null,
    workflowVersion   int           null,
    approval          varchar2(20)  null,
    approvalValue     int           null
);
create table flyway_schema_history
(
    installed_rank int                  not null
        primary key,
    version        varchar2(50)         null,
    description    varchar2(200)        not null,
    type           varchar2(20)         not null,
    script         varchar2(1000)       not null,
    checksum       int                  null,
    installed_by   varchar2(100)        not null,
    installed_on   timestamp default sysdate not null,
    execution_time int                  not null,
    success        number(1, 0)         not null
);
create table h_app_function
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    appCode      varchar2(40)   null,
    code         varchar2(40)   null,
    icon         varchar2(50)   null,
    name         varchar2(50)   null,
    parentId     varchar2(36)   null,
    sortKey      int            null,
    type         varchar2(40)   null,
    name_i18n    varchar2(1000) null,
    constraint UK_h_app_function_code
        unique (code)
);
create table h_app_package
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    agentId      varchar2(40)   null,
    appKey       varchar2(200)  null,
    appSecret    varchar2(200)  null,
    code         varchar2(40)   null,
    enabled      number(1, 0)   null,
    logoUrl      varchar2(200)  null,
    logoUrlId    varchar2(36)   null,
    name         varchar2(50)   null,
    sortKey      int            null,
    name_i18n    varchar2(1000) null
);
create table h_biz_attachment
(
    id                varchar2(120) not null
        primary key,
    bizObjectId       varchar2(36)  not null,
    bizPropertyCode   varchar2(40)  not null,
    createdTime       timestamp          null,
    creater           varchar2(36)  null,
    fileExtension     varchar2(30)  null,
    fileSize          int           null,
    mimeType          varchar2(50)  null,
    name              varchar2(200) null,
    parentBizObjectId varchar2(36)  null,
    parentSchemaCode  varchar2(36)  null,
    refId             varchar2(500) not null,
    schemaCode        varchar2(36)  not null
);
create table h_biz_comment
(
    id                 varchar2(120)  not null
        primary key,
    actionType         varchar2(40)   not null,
    activityCode       varchar2(40)   null,
    activityName       varchar2(40)   null,
    bizObjectId        varchar2(36)   not null,
    bizPropertyCode    varchar2(40)   null,
    content            varchar2(4000) null,
    createdTime        timestamp           null,
    creater            varchar2(36)   null,
    modifiedTime       timestamp           null,
    modifier           varchar2(36)   null,
    relUsers           varchar2(4000) null,
    result             varchar2(40)   null,
    schemaCode         varchar2(40)   not null,
    tokenId            int            null,
    workItemId         varchar2(36)   not null,
    workflowInstanceId varchar2(36)   not null,
    workflowTokenId    varchar2(36)   not null
);
create table h_biz_method
(
    id            varchar2(120) not null
        primary key,
    creater       varchar2(120) null,
    createdTime   timestamp          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  timestamp          null,
    remarks       varchar2(200) null,
    code          varchar2(40)  null,
    defaultMethod number(1, 0)  null,
    description   CLOB          null,
    methodType    varchar2(40)  null,
    name          varchar2(100) null,
    schemaCode    varchar2(40)  null,
    constraint UK_h_biz_method_sc
        unique (schemaCode, code)
);
create table h_biz_method_mapping
(
    id                 varchar2(120) not null
        primary key,
    creater            varchar2(120) null,
    createdTime        timestamp          null,
    deleted            number(1, 0)  null,
    modifier           varchar2(120) null,
    modifiedTime       timestamp          null,
    remarks            varchar2(200) null,
    inputMappingsJson  CLOB          null,
    methodCode         varchar2(40)  null,
    outputMappingsJson CLOB          null,
    schemaCode         varchar2(40)  null,
    serviceCode        varchar2(40)  null,
    serviceMethodCode  varchar2(40)  null
);
create table h_biz_perm_group
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    enabled      number(1, 0)   null,
    name         varchar2(50)   null,
    name_i18n    varchar2(1000) null,
    roles        CLOB           null,
    schemaCode   varchar2(40)   null
)
;
create table h_biz_perm_property
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    bizPermType  varchar2(40)   null,
    groupId      varchar2(40)   null,
    name         varchar2(50)   null,
    name_i18n    varchar2(1000) null,
    propertyCode varchar2(40)   null,
    propertyType varchar2(40)   null,
    required     number(1, 0)   null,
    visible      number(1, 0)   null,
    writeAble    number(1, 0)   null,
    schemaCode   varchar2(40)   null
)
;
create table h_biz_property
(
    id              varchar2(120)  not null
        primary key,
    creater         varchar2(120)  null,
    createdTime     timestamp           null,
    deleted         number(1, 0)   null,
    modifier        varchar2(120)  null,
    modifiedTime    timestamp           null,
    remarks         varchar2(200)  null,
    code            varchar2(40)   null,
    defaultProperty number(1, 0)   null,
    defaultValue    varchar2(200)  null,
    name            varchar2(200)   null,
    propertyEmpty   number(1, 0)   null,
    propertyIndex   number(1, 0)   null,
    propertyLength  int            null,
    propertyType    varchar2(40)   null,
    published       number(1, 0)   null,
    relativeCode    varchar2(40)   null,
    schemaCode      varchar2(40)   null,
    name_i18n       varchar2(1000) null,
    sortKey         int            null
);
create table h_biz_query
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    code         varchar2(40)   null,
    icon         varchar2(50)   null,
    name         varchar2(50)   null,
    schemaCode   varchar2(40)   null,
    sortKey      int            null,
    name_i18n    varchar2(1000) null
);
create table h_biz_query_action
(
    id              varchar2(120)  not null
        primary key,
    creater         varchar2(120)  null,
    createdTime     timestamp           null,
    deleted         number(1, 0)   null,
    modifier        varchar2(120)  null,
    modifiedTime    timestamp           null,
    remarks         varchar2(200)  null,
    actionCode      varchar2(40)   null,
    associationCode varchar2(40)   null,
    associationType varchar2(40)   null,
    customService   number(1, 0)   null,
    icon            varchar2(50)   null,
    name            varchar2(50)   null,
    queryActionType varchar2(50)   null,
    queryId         varchar2(36)   null,
    schemaCode      varchar2(40)   null,
    serviceCode     varchar2(40)   null,
    serviceMethod   varchar2(40)   null,
    sortKey         int            null,
    systemAction    number(1, 0)   null,
    name_i18n       varchar2(1000) null
);
create table h_biz_query_column
(
    id            varchar2(120)  not null
        primary key,
    creater       varchar2(120)  null,
    createdTime   timestamp           null,
    deleted       number(1, 0)   null,
    modifier      varchar2(120)  null,
    modifiedTime  timestamp           null,
    remarks       varchar2(200)  null,
    isSystem      number(1, 0)   null,
    name          varchar2(150)   null,
    propertyCode  varchar2(40)   null,
    propertyType  varchar2(40)   null,
    queryId       varchar2(36)   null,
    schemaCode    varchar2(40)   null,
    sortKey       int            null,
    sumType       varchar2(40)   null,
    unit          int            null,
    width         varchar2(50)   null,
    displayFormat int            null,
    name_i18n     varchar2(1000) null
);
create table h_biz_query_condition
(
    id                varchar2(120)  not null
        primary key,
    creater           varchar2(120)  null,
    createdTime       timestamp           null,
    deleted           number(1, 0)   null,
    modifier          varchar2(120)  null,
    modifiedTime      timestamp           null,
    remarks           varchar2(200)  null,
    choiceType        varchar2(10)   null,
    dataStatus        varchar2(40)   null,
    defaultState      int            null,
    defaultValue      varchar2(500)  null,
    displayType       varchar2(10)   null,
    endValue          varchar2(50)   null,
    isSystem          number(1, 0)   null,
    name              varchar2(50)   null,
    options           varchar2(500)  null,
    propertyCode      varchar2(40)   null,
    propertyType      varchar2(40)   null,
    queryId           varchar2(36)   null,
    relativeQueryCode varchar2(40)   null,
    schemaCode        varchar2(40)   null,
    sortKey           int            null,
    startValue        varchar2(50)   null,
    userOptionType    varchar2(10)   null,
    visible           number(1, 0)   null,
    accurateSearch    number(1, 0)   null,
    displayFormat     varchar2(40)   null,
    name_i18n         varchar2(1000) null
);
create table h_biz_query_sorter
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    direction    varchar2(40)   null,
    isSystem     number(1, 0)   null,
    name         varchar2(50)   null,
    propertyCode varchar2(40)   null,
    propertyType varchar2(40)   null,
    queryId      varchar2(36)   null,
    schemaCode   varchar2(40)   null,
    sortKey      int            null,
    name_i18n    varchar2(1000) null
);
create table h_biz_remind
(
    id              varchar2(120) not null
        primary key,
    creater         varchar2(120) null,
    createdTime     timestamp          null,
    deleted         number(1, 0)  null,
    modifier        varchar2(120) null,
    modifiedTime    timestamp          null,
    remarks         varchar2(200) null,
    conditionType   varchar2(20)  null,
    dateOption      varchar2(300) null,
    dateType        varchar2(20)  null,
    depIds          CLOB          null,
    enabled         number(1, 0)  null,
    filterType      varchar2(20)  null,
    intervalTime    int           null,
    msgTemplate     CLOB          null,
    remindType      varchar2(20)  null,
    roleCondition   CLOB          null,
    roleIds         CLOB          null,
    schemaCode      varchar2(100) null,
    sheetCode       varchar2(100) null,
    userDataOptions CLOB          null,
    userIds         CLOB          null
)
;
create table h_biz_rule
(
    id                   varchar2(120) not null
        primary key,
    creater              varchar2(120) null,
    createdTime          timestamp          null,
    deleted              number(1, 0)  null,
    modifier             varchar2(120) null,
    modifiedTime         timestamp          null,
    remarks              varchar2(200) null,
    conditionJoinType    varchar2(40)  null,
    enabled              number(1, 0)  null,
    name                 varchar2(100) null,
    ruleActionJson       CLOB          null,
    ruleScopeJson        CLOB          null,
    sourceSchemaCode     varchar2(40)  null,
    targetSchemaCode     varchar2(40)  null,
    triggerActionType    varchar2(40)  null,
    triggerConditionType varchar2(40)  null,
    triggerSchemaCode    varchar2(40)  null,
    chooseAction         varchar2(100) null
)
;

create table H_BIZ_RULE_EFFECT
(
    ID VARCHAR2(120) not null
        primary key,
    CREATER VARCHAR2(120),
    CREATEDTIME TIMESTAMP,
    DELETED NUMBER(1),
    MODIFIER VARCHAR2(120),
    MODIFIEDTIME TIMESTAMP,
    REMARKS VARCHAR2(200),
    ACTIONTYPE VARCHAR2(40),
    ACTIONVALUE VARCHAR2(255),
    LASTVALUE CLOB,
    SETVALUE CLOB,
    TARGETOBJECTID VARCHAR2(100),
    TARGETPROPERTYCODE VARCHAR2(40),
    TARGETSCHEMACODE VARCHAR2(40),
    TRIGGERACTIONTYPE VARCHAR2(40),
    TRIGGERID VARCHAR2(100),
    TRIGGEROBJECTID VARCHAR2(100),
    TRIGGERSCHEMACODE VARCHAR2(40),
    TARGETTABLETYPE VARCHAR2(40),
    TARGETTABLECODE VARCHAR2(40),
    TARGETMAINOBJECTID VARCHAR2(100),
    TARGETMAINOBJECTNAME VARCHAR2(200),
    TARGETPROPERTYLASTVALUE CLOB,
    TARGETPROPERTYSETVALUE CLOB,
    TARGETPROPERTYNAME VARCHAR2(50),
    TARGETPROPERTYTYPE VARCHAR2(40)
);



create table H_BIZ_RULE_TRIGGER
(
    ID VARCHAR2(120) not null
        primary key,
    CREATER VARCHAR2(120),
    CREATEDTIME TIMESTAMP,
    DELETED NUMBER(1),
    MODIFIER VARCHAR2(120),
    MODIFIEDTIME TIMESTAMP,
    REMARKS VARCHAR2(200),
    CONDITIONJOINTYPE VARCHAR2(40),
    RULEID VARCHAR2(100),
    RULENAME VARCHAR2(100),
    TARGETSCHEMACODE VARCHAR2(40),
    TRIGGERACTIONTYPE VARCHAR2(40),
    TRIGGERCONDITIONTYPE VARCHAR2(40),
    TRIGGEROBJECTID VARCHAR2(100),
    TRIGGERSCHEMACODE VARCHAR2(40),
    TRIGGERMAINOBJECTID VARCHAR2(100),
    TRIGGERMAINOBJECTNAME VARCHAR2(200),
    TRIGGERTABLETYPE VARCHAR2(40),
    SOURCEAPPCODE VARCHAR2(40),
    SOURCEAPPNAME VARCHAR2(50),
    SOURCESCHEMACODE VARCHAR2(40),
    SOURCESCHEMANAME VARCHAR2(50),
    TARGETSCHEMANAME VARCHAR2(50),
    TARGETTABLECODE VARCHAR2(40),
    SUCCESS NUMBER(1),
    FAILLOG CLOB,
    EFFECT NUMBER(1)
);
create table h_biz_schema
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    code         varchar2(40)   null,
    icon         varchar2(50)   null,
    name         varchar2(50)   null,
    published    number(1, 0)   null,
    summary      varchar2(2000) null,
    name_i18n    varchar2(1000) null
);
create table h_biz_service
(
    id                varchar2(120)  not null
        primary key,
    creater           varchar2(120)  null,
    createdTime       timestamp           null,
    deleted           number(1, 0)   null,
    modifier          varchar2(120)  null,
    modifiedTime      timestamp           null,
    remarks           varchar2(200)  null,
    adapterCode       varchar2(40)   null,
    code              varchar2(40)   null,
    configJson        CLOB           null,
    description       varchar2(2000) null,
    name              varchar2(50)   null,
    serviceCategoryId varchar2(40)   null
);
create table h_biz_service_category
(
    id           varchar2(120) not null
        primary key,
    createdTime  timestamp          null,
    modifiedTime timestamp          null,
    name         varchar2(50)  null
);
create table h_biz_service_method
(
    id                   varchar2(120)  not null
        primary key,
    creater              varchar2(120)  null,
    createdTime          timestamp           null,
    deleted              number(1, 0)   null,
    modifier             varchar2(120)  null,
    modifiedTime         timestamp           null,
    remarks              varchar2(200)  null,
    code                 varchar2(40)   null,
    configJson           CLOB           null,
    description          varchar2(2000) null,
    inputParametersJson  CLOB           null,
    name                 varchar2(50)   null,
    outputParametersJson CLOB           null,
    protocolAdapterType  varchar2(40)   null,
    serviceCode          varchar2(40)   null
);
create table h_biz_sheet
(
    id                      varchar2(120)          not null
        primary key,
    creater                 varchar2(120)          null,
    createdTime             timestamp                   null,
    deleted                 number(1, 0)           null,
    modifier                varchar2(120)          null,
    modifiedTime            timestamp                   null,
    remarks                 varchar2(200)          null,
    code                    varchar2(40)           null,
    draftAttributesJson     CLOB                   null,
    draftViewJson           CLOB                   null,
    sheetType               varchar2(50)           null,
    icon                    varchar2(50)           null,
    mobileIsPc              number(1, 0)           null,
    mobileUrl               varchar2(500)          null,
    name                    varchar2(50)           null,
    pcUrl                   varchar2(500)          null,
    printIsPc               number(1, 0)           null,
    printUrl                varchar2(500)          null,
    published               number(1, 0)           null,
    publishedAttributesJson CLOB                   null,
    publishedViewJson       CLOB                   null,
    schemaCode              varchar2(40)           null,
    sortKey                 int                    null,
    serialCode              varchar2(255)          null,
    serialResetType         varchar2(40)           null,
    name_i18n               varchar2(1000)         null,
    externalLinkAble        number(1, 0) default 0 null,
    draftHtmlJson           CLOB                   null,
    publishedHtmlJson       CLOB                   null,
    draftActionsJson        CLOB                   null,
    publishedActionsJson    CLOB                   null,
    shortCode               varchar2(50)           null,
    printTemplateJson       varchar2(1000)         null,
    qrCodeAble              varchar2(40)           null
);
create table h_custom_page
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    code         varchar2(40)   null,
    icon         varchar2(50)   null,
    mobileUrl    varchar2(500)  null,
    name         varchar2(50)   null,
    openMode     varchar2(40)   null,
    pcUrl        varchar2(500)  null,
    appCode      varchar2(40)   null,
    name_i18n    varchar2(1000) null
);
create table h_im_message
(
    id            varchar2(36)  not null
        primary key,
    bizParams     CLOB          null,
    channel       varchar2(40)  null,
    content       CLOB          null,
    createdTime   timestamp          null,
    failRetry     number(1, 0)  null,
    failUserRetry number(1, 0)  null,
    messageType   varchar2(40)  null,
    modifiedTime  timestamp          null,
    receivers     CLOB          null,
    title         varchar2(100) null,
    tryTimes      int           null,
    url           varchar2(500) null
);
create table h_im_message_history
(
    id              varchar2(36)  not null
        primary key,
    bizParams       CLOB          null,
    channel         varchar2(40)  null,
    content         CLOB          null,
    createdTime     timestamp          null,
    failRetry       number(1, 0)  null,
    failUserRetry   number(1, 0)  null,
    messageType     varchar2(40)  null,
    modifiedTime    timestamp          null,
    receivers       CLOB          null,
    title           varchar2(100) null,
    tryTimes        int           null,
    url             varchar2(500) null,
    sendFailUserIds CLOB          null,
    status          varchar2(40)  null,
    taskId          varchar2(40)  null
);
create table h_im_urge_task
(
    id         varchar2(64)         not null
        primary key,
    instanceId varchar2(120)        not null,
    text       varchar2(255)        not null,
    userId     varchar2(80)         not null,
    opTime     timestamp default sysdate not null,
    urgeType   int  default 0       not null,
    messageId  varchar2(120)        null
)
;
create table h_im_urge_workitem
(
    id         varchar2(64)         not null
        primary key,
    workitemId varchar2(120)        not null,
    userId     varchar2(80)         not null,
    createTime timestamp default sysdate not null,
    modifyTime timestamp default sysdate not null,
    urgeCount  int  default 1       not null
)
;
create table h_im_work_record
(
    id               varchar2(36)  not null
        primary key,
    workitemId       varchar2(100) null,
    recordId         varchar2(100) null,
    requestId        varchar2(100) null,
    receivers        CLOB          null,
    title            varchar2(100) null,
    content          CLOB          null,
    url              varchar2(500) null,
    receiveTime      timestamp          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      timestamp          null,
    modifiedTime     timestamp          null,
    channel          varchar2(40)  null
)
;
create table h_im_work_record_history
(
    id               varchar2(36)  not null
        primary key,
    workitemId       varchar2(100) null,
    recordId         varchar2(100) null,
    requestId        varchar2(100) null,
    receivers        CLOB          null,
    title            varchar2(100) null,
    content          varchar2(200) null,
    url              varchar2(500) null,
    receiveTime      timestamp          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      timestamp          null,
    modifiedTime     timestamp          null,
    channel          varchar2(40)  null,
    status           varchar2(40)  null,
    taskId           varchar2(42)  null
)
;
create table h_job_result
(
    id             varchar2(120) not null
        primary key,
    jobName        varchar2(100) null,
    beanName       varchar2(100) null,
    methodName     varchar2(100) null,
    methodParams   varchar2(255) null,
    year           int           null,
    cronExpression varchar2(80)  null,
    jobRunType     varchar2(20)  null,
    createTime     timestamp          null,
    executeStatus  varchar2(20)  null
)
;
create table h_log_biz_object
(
    id                 varchar2(120) not null
        primary key,
    client             CLOB          null,
    detail             CLOB          null,
    ip                 varchar2(500) null,
    operateNode        varchar2(100) null,
    operationType      varchar2(50)  null,
    time               timestamp          null,
    username           varchar2(100) null,
    workflowInstanceId varchar2(120) null
);
create table h_log_biz_service
(
    id               varchar2(120)  not null
        primary key,
    bizServiceStatus varchar2(20)   null,
    code             varchar2(40)   null,
    createdTime      timestamp           null,
    endTime          timestamp           null,
    exception        CLOB           null,
    methodName       varchar2(120)  null,
    options          CLOB           null,
    params           varchar2(2000) null,
    result           CLOB           null,
    server           varchar2(200)  null,
    startTime        timestamp           null,
    usedTime         int            null,
    schemaCode       varchar2(40)   null,
    bizObjectId      varchar2(200)  null
);
create table h_log_login
(
    id              varchar2(120) not null
        primary key,
    browser         varchar2(50)  null,
    clientAgent     varchar2(500) null,
    ipAddress       varchar2(20)  null,
    loginSourceType varchar2(40)  null,
    loginTime       timestamp          null,
    name            varchar2(40)  null,
    userId          varchar2(40)  null,
    username        varchar2(40)  null
);
create table h_log_metadata
(
    id          varchar2(120) not null
        primary key,
    bizKey      varchar2(120) null,
    metaData    CLOB          null,
    moduleName  varchar2(60)  null,
    objId       varchar2(120) null,
    operateTime timestamp          null,
    operateType int           null,
    operator    varchar2(120) null
);
create table h_log_workflow_exception
(
    id                   varchar2(120)  not null
        primary key,
    createdTime          timestamp           null,
    creater              varchar2(120)  not null,
    createrName          varchar2(200)  null,
    detail               CLOB           null,
    extData              varchar2(1000) null,
    fixNotes             varchar2(1000) null,
    fixedTime            timestamp           null,
    fixer                varchar2(120)  null,
    fixerName            varchar2(200)  null,
    status               varchar2(40)   not null,
    summary              varchar2(500)  not null,
    workflowCode         varchar2(40)   not null,
    workflowInstanceId   varchar2(120)  not null,
    workflowInstanceName varchar2(200)  null,
    workflowName         varchar2(200)  null,
    workflowVersion      int            not null
);
create table h_org_department
(
    id             varchar2(120)  not null
        primary key,
    creater        varchar2(120)  null,
    createdTime    timestamp           null,
    deleted        number(1, 0)   null,
    modifier       varchar2(120)  null,
    modifiedTime   timestamp           null,
    remarks        varchar2(200)  null,
    extend1        varchar2(255)  null,
    extend2        varchar2(255)  null,
    extend3        varchar2(255)  null,
    extend4        int            null,
    extend5        int            null,
    calendarId     varchar2(36)   null,
    employees      int            null,
    leaf           number(1, 0)   null,
    managerId      varchar2(2000) null,
    name           varchar2(200)  null,
    parentId       varchar2(36)   null,
    queryCode      varchar2(128)  null,
    sortKey        int            null,
    sourceId       varchar2(40)   null,
    constraint UK_h_org_department_sourceId
        unique (sourceId)
);
create table h_org_dept_user
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    deptId       varchar2(36)  null,
    main         number(1, 0)  null,
    userId       varchar2(36)  null,
    sortKey      varchar2(200) null,
    leader       number(1, 0)  null
);
create table h_org_role
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    extend1      varchar2(255) null,
    extend2      varchar2(255) null,
    extend3      varchar2(255) null,
    extend4      int           null,
    extend5      int           null,
    code         varchar2(256) null,
    groupId      varchar2(36)  null,
    name         varchar2(256) null,
    sortKey      int           null,
    sourceId     varchar2(40)  null,
    constraint UK_h_org_role_sourceId
        unique (sourceId)
);
create table h_org_role_group
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    code         varchar2(256) null,
    defaultGroup number(1, 0)  null,
    name         varchar2(256) null,
    roleId       varchar2(36)  null,
    sortKey      int           null,
    sourceId     varchar2(40)  null,
    constraint UK_h_org_role_group_sourceId
        unique (sourceId),
    constraint UK_h_org_role_group_code
        unique (code)
);
create table h_org_role_user
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  timestamp           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime timestamp           null,
    remarks      varchar2(200)  null,
    ouScope      varchar2(4000) null,
    roleId       varchar2(36)   null,
    userId       varchar2(36)   null
);
create table h_org_user
(
    id             varchar2(120) not null
        primary key,
    createdTime    timestamp          null,
    creater        varchar2(120) null,
    deleted        number(1, 0)  null,
    extend1        varchar2(255) null,
    extend2        varchar2(255) null,
    extend3        varchar2(255) null,
    extend4        int           null,
    extend5        int           null,
    modifiedTime   timestamp          null,
    modifier       varchar2(120) null,
    remarks        varchar2(200) null,
    active         number(1, 0)  null,
    admin          number(1, 0)  null,
    appellation    varchar2(40)  null,
    birthday       timestamp          null,
    boss           number(1, 0)  null,
    departmentId   varchar2(255) null,
    departureDate  timestamp          null,
    dingtalkId     varchar2(100) null,
    email          varchar2(40)  null,
    employeeNo     varchar2(40)  null,
    employeeRank   int           null,
    entryDate      timestamp          null,
    gender         varchar2(5)   null,
    identityNo     varchar2(18)  null,
    imgUrl         varchar2(200) null,
    leader         number(1, 0)  null,
    managerId      varchar2(40)  null,
    mobile         varchar2(100) null,
    name           varchar2(250) null,
    officePhone    varchar2(20)  null,
    password       varchar2(100) null,
    username       varchar2(40)  null,
    privacyLevel   varchar2(40)  null,
    secretaryId    varchar2(36)  null,
    sortKey        bigint           null,
    sourceId       varchar2(50)  null,
    status         varchar2(40)  null,
    userId         varchar2(255) null
);
create table h_perm_admin
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    adminType    varchar2(40)  null,
    dataManage   number(1, 0)  null,
    dataQuery    number(1, 0)  null,
    userId       varchar2(40)  null
);
create table h_perm_app_package
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    appCode      varchar2(40)  null,
    departments  CLOB          null,
    roles        CLOB          null,
    visibleType  varchar2(40)  null
);
create table h_perm_apppackage_scope
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    adminId      varchar2(40)  null,
    code         varchar2(40)  null,
    name         varchar2(50)  null
);
create table h_perm_biz_function
(
    id                 varchar2(120) not null
        primary key,
    creater            varchar2(120) null,
    createdTime        timestamp          null,
    deleted            number(1, 0)  null,
    modifier           varchar2(120) null,
    modifiedTime       timestamp          null,
    remarks            varchar2(200) null,
    creatable          number(1, 0)  null,
    dataPermissionType varchar2(40)  null,
    deletable          number(1, 0)  null,
    editable           number(1, 0)  null,
    exportable         number(1, 0)  null,
    filterType         varchar2(40)  null,
    functionCode       varchar2(40)  null,
    importable         number(1, 0)  null,
    permissionGroupId  varchar2(40)  null,
    schemaCode         varchar2(40)  null,
    visible            number(1, 0)  null,
    nodeType           varchar2(40)  null
);
create table h_perm_department_scope
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    adminId      varchar2(40)  null,
    name         varchar2(50)  null,
    queryCode    varchar2(128) null,
    unitId       varchar2(40)  null,
    unitType     varchar2(10)  null
);
create table h_perm_function_condition
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    operatorType varchar2(40)  null,
    propertyCode varchar2(40)  null,
    schemaCode   varchar2(40)  null,
    value        CLOB  null,
    functionId   varchar2(40)  null
);
create table h_perm_group
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    appCode      varchar2(40)  null,
    departments  CLOB          null,
    name         varchar2(50)  null,
    roles        CLOB          null
);
create table h_system_pair
(
    id        varchar2(120) not null
        primary key,
    paramCode varchar2(200) null,
    pairValue CLOB          null,
    constraint UK_h_system_pair_paramCode
        unique (paramCode)
)
;
create table h_system_sequence_no
(
    id        varchar2(120) not null
        primary key,
    code      varchar2(40)  null,
    maxLength int           null,
    resetDate timestamp          null,
    resetType int           null,
    serialNo  int           null
);
create table h_system_setting
(
    id             varchar2(120) not null
        primary key,
    paramCode      varchar2(40)  null,
    paramValue     varchar2(200) null,
    settingType    varchar2(20)  null,
    checked        number(1, 0)  null,
    fileUploadType varchar2(20)  null,
    constraint UK_h_system_setting_paramCode
        unique (paramCode)
)
;
create table h_system_setting_copy
(
    id          varchar2(120) not null
        primary key,
    paramCode   varchar2(40)  null,
    paramValue  varchar2(200) null,
    settingType varchar2(20)  null,
    constraint UK_h_ssc_paramCode
        unique (paramCode)
);
create table h_timer_job
(
    id             varchar2(120) not null
        primary key,
    jobName        varchar2(100) null,
    beanName       varchar2(100) null,
    methodName     varchar2(100) null,
    methodParams   varchar2(255) null,
    year           int           null,
    cronExpression varchar2(80)  null,
    status         int           null,
    jobRunType     varchar2(20)  null,
    remark         varchar2(100) null,
    createTime     timestamp          null,
    updateTime     timestamp          null
)
;
create table h_user_comment
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    content      varchar2(600) null,
    sortKey      int           null,
    userId       varchar2(36)  null
);
create table h_user_favorites
(
    id            varchar2(120) not null
        primary key,
    creater       varchar2(120) null,
    createdTime   timestamp          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  timestamp          null,
    remarks       varchar2(200) null,
    bizObjectKey  varchar2(40)  null,
    bizObjectType varchar2(20)  null,
    userId        varchar2(36)  null,
    appCode       varchar2(40)  null
);
create table h_user_guide
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    display      number(1, 0)  null,
    pageType     varchar2(20)  not null,
    userId       varchar2(40)  not null
);

create table h_workflow_header
(
    id              varchar2(120)  not null
        primary key,
    creater         varchar2(120)  null,
    createdTime     timestamp           null,
    deleted         number(1, 0)   null,
    modifier        varchar2(120)  null,
    modifiedTime    timestamp           null,
    remarks         varchar2(200)  null,
    icon            varchar2(50)   null,
    mobileOriginate number(1, 0)   null,
    pcOriginate     number(1, 0)   null,
    published       number(1, 0)   null,
    schemaCode      varchar2(40)   null,
    sortKey         int            null,
    workflowCode    varchar2(40)   null,
    workflowName    varchar2(200)  null,
    name_i18n       varchar2(1000) null,
    constraint UK_hwh_wfc
        unique (workflowCode)
);
create table h_workflow_permission
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  timestamp          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime timestamp          null,
    remarks      varchar2(200) null,
    unitId       varchar2(36)  null,
    unitType     varchar2(10)  null,
    workflowCode varchar2(40)  null
);
create table h_workflow_relative_event
(
    id            varchar2(120) not null
        primary key,
    creater       varchar2(120) null,
    createdTime   timestamp          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  timestamp          null,
    remarks       varchar2(200) null,
    schemaCode    varchar2(40)  null,
    workflowCode  varchar2(40)  null,
    bizMethodCode varchar2(40)  null
)
;
create table h_workflow_relative_object
(
    id              varchar2(120) not null
        primary key,
    relativeCode    varchar2(40)  null,
    relativeType    varchar2(40)  null,
    workflowCode    varchar2(40)  null,
    workflowVersion int           null
);
create table h_workflow_template
(
    id                   varchar2(120) not null
        primary key,
    creater              varchar2(120) null,
    createdTime          timestamp          null,
    deleted              number(1, 0)  null,
    modifier             varchar2(120) null,
    modifiedTime         timestamp          null,
    remarks              varchar2(200) null,
    content              CLOB          null,
    templateType         varchar2(10)  null,
    workflowCode         varchar2(40)  null,
    workflowVersion      int           null
);

ALTER TABLE h_biz_sheet ADD (pdfAble VARCHAR(40) DEFAULT NULL);

create index idx_biz_circulateitem_i_a_w_p on biz_circulateitem (instanceId, activityCode, workflowTokenId, participant);
create index idx_bc_participant on biz_circulateitem (participant);
create index idx_biz_circulateitem_s_w on biz_circulateitem (sourceId, workItemType);
create index idx_bc_startTime on biz_circulateitem (startTime);
create index idx_bc_workflowTokenId on biz_circulateitem (workflowTokenId);
create index idx_bcf_finishTime on biz_circulateitem_finished (finishTime);
create index idx_bcf_i_a_w_p on biz_circulateitem_finished (instanceId, activityCode, workflowTokenId, participant);
create index idx_bcf_participant on biz_circulateitem_finished (participant);
create index idx_bcf_s_w on biz_circulateitem_finished (sourceId, workItemType);
create index idx_bcf_workflowTokenId on biz_circulateitem_finished (workflowTokenId);
create index idx_biz_work_record_recordId on biz_work_record (recordId);
create index idx_bwrh_recordId on biz_work_record_history (recordId);
create index idx_bwi_originator on biz_workflow_instance (originator);
create index idx_bwi_o_s_s on biz_workflow_instance (originator, state, startTime);
create index idx_bwi_startTime on biz_workflow_instance (startTime);
create index idx_bwi_workflowCode on biz_workflow_instance (workflowCode);
create index idx_bwi_state on biz_workflow_instance (state);
create index idx_bwt_instanceId on biz_workflow_token (instanceId);
create index idx_biz_workitem_i_a_w_p on biz_workitem (instanceId, activityCode, workflowTokenId, participant);
create index idx_biz_workitem_participant on biz_workitem (participant);
create index idx_biz_workitem_s_w on biz_workitem (sourceId, workItemType);
create index idx_biz_workitem_startTime on biz_workitem (startTime);
create index idx_biz_workitem_w on biz_workitem (workflowTokenId);
create index idx_bwf_finishTime on biz_workitem_finished (finishTime);
create index idx_bwf_i_a_w_p on biz_workitem_finished (instanceId, activityCode, workflowTokenId, participant);
create index idx_bwf_participant on biz_workitem_finished (participant);
create index idx_bwf_s_w on biz_workitem_finished (sourceId, workItemType);
create index idx_bwf_workflowTokenId on biz_workitem_finished (workflowTokenId);
create index idx_fsh_success on flyway_schema_history (success);
create index idx_h_biz_attachment_s_b_b_c on h_biz_attachment (schemaCode, bizObjectId, bizPropertyCode, createdTime);
create index idx_h_biz_comment_w_a on h_biz_comment (workItemId, actionType);
create index idx_h_biz_comment_w_c on h_biz_comment (workflowInstanceId, createdTime);
create index idx_h_im_urge_task_i_u on h_im_urge_task (instanceId, userId);
create index idx_hiuw_workitemId_userId on h_im_urge_workitem (workitemId, userId);
create index idx_h_im_work_record_recordId on h_im_work_record (recordId);
create index idx_hiwrh_recordId on h_im_work_record_history (recordId);
create index idx_h_org_department_name on h_org_department (name);
create index idx_h_org_department_parentId on h_org_department (parentId);
create index idx_h_org_dept_user_deptId on h_org_dept_user (deptId);
create index idx_h_org_dept_user_userId on h_org_dept_user (userId);
create index idx_h_org_role_code on h_org_role (code);
create index idx_h_org_role_name on h_org_role (name);
-- create index idx_h_org_role_id on h_org_role (id);
-- create index idx_h_org_role_group_code on h_org_role_group (code);
-- create index idx_h_org_role_group_id on h_org_role_group (id);
create index idx_h_org_role_user_userId on h_org_role_user (userId);
create index idx_h_org_user_username on h_org_user (username);


INSERT INTO base_security_client (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5,
                                  modifiedTime, modifier, remarks, accessTokenValiditySeconds,
                                  additionInformation, authorities, authorizedGrantTypes, autoApproveScopes,
                                  clientId, clientSecret, refreshTokenValiditySeconds, registeredRedirectUris,
                                  resourceIds, scopes, type)
VALUES ('8a5da52ed126447d359e70c05721a8aa', NULL, NULL, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL,
        '28800',
        'API',
        'api',
        'authorization_code,implicit,password,refresh_token',
        'read,write',
        'api',
        '{noop}c31b32364ce19ca8fcd150a417ecce58',
        '28800',
        'http://127.0.0.1/admin,http://127.0.0.1/admin#/oauth,http://127.0.0.1/oauth',
        'api',
        'read,write',
        'APP');


INSERT INTO h_org_user (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5,
                        modifiedTime, modifier, remarks, active, admin, appellation, birthday, boss,
                        departmentId, departureDate, dingtalkId, email, employeeNo, employeeRank, entryDate,
                        gender, identityNo, imgUrl, leader, managerId, mobile, name, officePhone, password,
                        username, privacyLevel, secretaryId, sortKey, sourceId, status, userId)
VALUES ('2ccf3b346706a6d3016706dc51c0022b',
        NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, 1, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL,
        NULL,
        'xuser', NULL,
        '{bcrypt}$2a$10$NvgvcocBqMn050z4nC0I6OeAhO5ERjM74pvMtSGLghPhWI5ed5myG',
        'xuser', NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO h_org_department (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5,
                              modifiedTime, modifier, remarks, calendarId, employees, leaf, managerId, name,
                              parentId, sortKey, sourceId, queryCode)
VALUES ('06ef8c9a3f3b6669a34036a3001e6340',
        NULL, NULL, 0,
        '',
        '', NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, 0,
        '',
        '外部', NULL,
        '0', NULL, '');

UPDATE h_org_user
SET departmentId='06ef8c9a3f3b6669a34036a3001e6340'
WHERE id = '2ccf3b346706a6d3016706dc51c0022b';


INSERT INTO h_org_dept_user (id, createdTime, creater, deleted, modifiedTime, modifier, remarks, deptId, main,
                             userId)
VALUES ('07df8b34e4469a00169a36a336450cf3',
        NULL, NULL, 0,
        NULL, NULL, NULL,
        '06ef8c9a3f3b6669a34036a3001e6340', NULL,
        '2ccf3b346706a6d3016706dc51c0022b');

UPDATE h_org_department
SET parentId='06ef8c9a3f3b6669a34036a3001e63401'
WHERE id = '06ef8c9a3f3b6669a34036a3001e6340';



INSERT INTO base_security_client (id, deleted, accessTokenValiditySeconds, additionInformation, authorities,
                                  authorizedGrantTypes, autoApproveScopes, clientId, clientSecret,
                                  refreshTokenValiditySeconds, registeredRedirectUris, resourceIds, scopes, type)
VALUES ('52ed17238a5da59e71a8aa26447d0c05', 0, '3600', 'API', 'openapi', 'client_credentials', 'read,write', 'xclient',
        '{noop}0a417ecce58c31b32364ce19ca8fcd15', '3600', '', 'api', 'read,write', 'APP');

UPDATE h_org_user
SET name='外部用户'
WHERE id = '2ccf3b346706a6d3016706dc51c0022b';


INSERT INTO h_org_department (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5,
                              modifiedTime, modifier, remarks, calendarId, employees, leaf, managerId, name, parentId,
                              sortKey, sourceId, queryCode)
VALUES ('1803c80ed28a3e25871d58808019816e', NULL, NULL, 0, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0,
        '', '管理部门', 'fc57a56529ef4e089b5b23162f063ca9', 0, NULL, '');

UPDATE h_org_user
SET departmentId='1803c80ed28a3e25871d58808019816e'
WHERE id = '2c9280a26706a73a016706a93ccf002b';


INSERT INTO h_org_dept_user (id, createdTime, creater, deleted, modifiedTime, modifier, remarks, deptId, main, userId)
VALUES ('a92a7856f16132c6a1884b08c3233236', NULL, NULL, 0, NULL, NULL, NULL, '1803c80ed28a3e25871d58808019816e', NULL,
        '2c9280a26706a73a016706a93ccf002b');


INSERT INTO h_org_user (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5,
                        modifiedTime, modifier, remarks, active, admin, appellation, birthday, boss,
                        departmentId, departureDate, dingtalkId, email, employeeNo, employeeRank, entryDate,
                        gender, identityNo, imgUrl, leader, managerId, mobile, name, officePhone, password,
                        username, privacyLevel, secretaryId, sortKey, sourceId, status, userId)
VALUES ('2c9280a26706a73a016706a93ccf002b', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL,
        'admin', NULL,
        '{bcrypt}$2a$10$NvgvcocBqMn050z4nC0I6OeAhO5ERjM74pvMtSGLghPhWI5ed5myG',
        'admin', NULL, NULL, NULL, NULL, NULL, NULL);


commit;