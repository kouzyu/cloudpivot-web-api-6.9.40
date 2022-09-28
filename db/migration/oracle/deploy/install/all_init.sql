--初始化 1.3版本
create table base_security_client
(
    id                          varchar2(120)  not null
        primary key,
    createdTime                 date           null,
    creater                     varchar2(120)  null,
    deleted                     number(1, 0)   null,
    extend1                     varchar2(255)  null,
    extend2                     varchar2(255)  null,
    extend3                     varchar2(255)  null,
    extend4                     int            null,
    extend5                     int            null,
    modifiedTime                date           null,
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
    finishTime        date          null,
    receiveTime       date          null,
    startTime         date          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       date          null,
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
    timeoutWarn1      date          null,
    timeoutWarn2      date          null,
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
    finishTime        date          null,
    receiveTime       date          null,
    startTime         date          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       date          null,
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
    timeoutWarn1      date          null,
    timeoutWarn2      date          null,
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
    receiveTime      date          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      date          null,
    modifiedTime     date          null
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
    receiveTime      date          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      date          null,
    modifiedTime     date          null
)
;
create table biz_workflow_instance
(
    id               varchar2(36)  not null
        primary key,
    finishTime       date          null,
    receiveTime      date          null,
    startTime        date          null,
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
    finishTime         date          null,
    receiveTime        date          null,
    startTime          date          null,
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
    finishTime        date          null,
    receiveTime       date          null,
    startTime         date          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       date          null,
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
    timeoutWarn1      date          null,
    timeoutWarn2      date          null,
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
    finishTime        date          null,
    receiveTime       date          null,
    startTime         date          null,
    activityCode      varchar2(200) null,
    activityName      varchar2(200) null,
    allowedTime       date          null,
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
    timeoutWarn1      date          null,
    timeoutWarn2      date          null,
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
    installed_on   date default sysdate not null,
    execution_time int                  not null,
    success        number(1, 0)         not null
);
create table h_app_function
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime       date          null,
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
    createdTime        date           null,
    creater            varchar2(36)   null,
    modifiedTime       date           null,
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
    createdTime   date          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  date          null,
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
    createdTime        date          null,
    deleted            number(1, 0)  null,
    modifier           varchar2(120) null,
    modifiedTime       date          null,
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
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime     date           null,
    deleted         number(1, 0)   null,
    modifier        varchar2(120)  null,
    modifiedTime    date           null,
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
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime     date           null,
    deleted         number(1, 0)   null,
    modifier        varchar2(120)  null,
    modifiedTime    date           null,
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
    createdTime   date           null,
    deleted       number(1, 0)   null,
    modifier      varchar2(120)  null,
    modifiedTime  date           null,
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
    createdTime       date           null,
    deleted           number(1, 0)   null,
    modifier          varchar2(120)  null,
    modifiedTime      date           null,
    remarks           varchar2(200)  null,
    choiceType        varchar2(10)   null,
    dataStatus        varchar2(40)   null,
    defaultState      int            null,
    defaultValue      varchar2(500)  null,
    displayType       varchar2(10)   null,
    endValue          varchar2(50)   null,
    isSystem          number(1, 0)   null,
    name              varchar2(50)   null,
    options           CLOB  null,
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
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime     date          null,
    deleted         number(1, 0)  null,
    modifier        varchar2(120) null,
    modifiedTime    date          null,
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
    createdTime          date          null,
    deleted              number(1, 0)  null,
    modifier             varchar2(120) null,
    modifiedTime         date          null,
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
create table h_biz_rule_effect
(
    id                 varchar2(120) not null
        primary key,
    creater            varchar2(120) null,
    createdTime        date          null,
    deleted            number(1, 0)  null,
    modifier           varchar2(120) null,
    modifiedTime       date          null,
    remarks            varchar2(200) null,
    actionType         varchar2(40)  null,
    actionValue        varchar2(255) null,
    lastValue          CLOB          null,
    setValue           CLOB          null,
    targetObjectId     varchar2(100) null,
    targetPropertyCode varchar2(40)  null,
    targetSchemaCode   varchar2(40)  null,
    triggerActionType  varchar2(40)  null,
    triggerId          varchar2(100) null,
    triggerObjectId    varchar2(100) null,
    triggerSchemaCode  varchar2(40)  null
)
;
create table h_biz_rule_trigger
(
    id                   varchar2(120) not null
        primary key,
    creater              varchar2(120) null,
    createdTime          date          null,
    deleted              number(1, 0)  null,
    modifier             varchar2(120) null,
    modifiedTime         date          null,
    remarks              varchar2(200) null,
    conditionJoinType    varchar2(40)  null,
    ruleId               varchar2(100) null,
    ruleName             varchar2(100) null,
    targetSchemaCode     varchar2(40)  null,
    triggerActionType    varchar2(40)  null,
    triggerConditionType varchar2(40)  null,
    triggerObjectId      varchar2(100) null,
    triggerSchemaCode    varchar2(40)  null
)
;
create table h_biz_schema
(
    id           varchar2(120)  not null
        primary key,
    creater      varchar2(120)  null,
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime       date           null,
    deleted           number(1, 0)   null,
    modifier          varchar2(120)  null,
    modifiedTime      date           null,
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
    createdTime  date          null,
    modifiedTime date          null,
    name         varchar2(50)  null
);
create table h_biz_service_method
(
    id                   varchar2(120)  not null
        primary key,
    creater              varchar2(120)  null,
    createdTime          date           null,
    deleted              number(1, 0)   null,
    modifier             varchar2(120)  null,
    modifiedTime         date           null,
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
    createdTime             date                   null,
    deleted                 number(1, 0)           null,
    modifier                varchar2(120)          null,
    modifiedTime            date                   null,
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
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
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
    createdTime   date          null,
    failRetry     number(1, 0)  null,
    failUserRetry number(1, 0)  null,
    messageType   varchar2(40)  null,
    modifiedTime  date          null,
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
    createdTime     date          null,
    failRetry       number(1, 0)  null,
    failUserRetry   number(1, 0)  null,
    messageType     varchar2(40)  null,
    modifiedTime    date          null,
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
    opTime     date default sysdate not null,
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
    createTime date default sysdate not null,
    modifyTime date default sysdate not null,
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
    content          varchar2(3000) default '',
    url              varchar2(500) null,
    receiveTime      date          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      date          null,
    modifiedTime     date          null,
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
    receiveTime      date          null,
    tryTimes         int           null,
    failRetry        varchar2(200) null,
    messageType      varchar2(200) null,
    failUserRetry    number(1, 0)  null,
    WorkRecordStatus varchar2(40)  not null,
    bizParams        CLOB          null,
    createdTime      date          null,
    modifiedTime     date          null,
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
    createTime     date          null,
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
    time               date          null,
    username           varchar2(100) null,
    workflowInstanceId varchar2(120) null
);
create table h_log_biz_service
(
    id               varchar2(120)  not null
        primary key,
    bizServiceStatus varchar2(20)   null,
    code             varchar2(40)   null,
    createdTime      date           null,
    endTime          date           null,
    exception        CLOB           null,
    methodName       varchar2(120)  null,
    options          CLOB           null,
    params           varchar2(2000) null,
    result           CLOB           null,
    server           varchar2(200)  null,
    startTime        date           null,
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
    loginTime       date          null,
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
    operateTime date          null,
    operateType int           null,
    operator    varchar2(120) null
);
create table h_log_workflow_exception
(
    id                   varchar2(120)  not null
        primary key,
    createdTime          date           null,
    creater              varchar2(120)  not null,
    createrName          varchar2(200)  null,
    detail               CLOB           null,
    extData              varchar2(1000) null,
    fixNotes             varchar2(1000) null,
    fixedTime            date           null,
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
    createdTime    date           null,
    deleted        number(1, 0)   null,
    modifier       varchar2(120)  null,
    modifiedTime   date           null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime  date           null,
    deleted      number(1, 0)   null,
    modifier     varchar2(120)  null,
    modifiedTime date           null,
    remarks      varchar2(200)  null,
    ouScope      varchar2(4000) null,
    roleId       varchar2(36)   null,
    userId       varchar2(36)   null
);
create table h_org_user
(
    id             varchar2(120) not null
        primary key,
    createdTime    date          null,
    creater        varchar2(120) null,
    deleted        number(1, 0)  null,
    extend1        varchar2(255) null,
    extend2        varchar2(255) null,
    extend3        varchar2(255) null,
    extend4        int           null,
    extend5        int           null,
    modifiedTime   date          null,
    modifier       varchar2(120) null,
    remarks        varchar2(200) null,
    active         number(1, 0)  null,
    admin          number(1, 0)  null,
    appellation    varchar2(40)  null,
    birthday       date          null,
    boss           number(1, 0)  null,
    departmentId   varchar2(255) null,
    departureDate  date          null,
    dingtalkId     varchar2(100) null,
    email          varchar2(40)  null,
    employeeNo     varchar2(40)  null,
    employeeRank   int           null,
    entryDate      date          null,
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
    sortKey        int           null,
    sourceId       varchar2(50)  null,
    status         varchar2(40)  null,
    userId         varchar2(255) null
);
create table h_perm_admin
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime        date          null,
    deleted            number(1, 0)  null,
    modifier           varchar2(120) null,
    modifiedTime       date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    resetDate date          null,
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
    createTime     date          null,
    updateTime     date          null
)
;
create table h_user_comment
(
    id           varchar2(120) not null
        primary key,
    creater      varchar2(120) null,
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime   date          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  date          null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime     date           null,
    deleted         number(1, 0)   null,
    modifier        varchar2(120)  null,
    modifiedTime    date           null,
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
    createdTime  date          null,
    deleted      number(1, 0)  null,
    modifier     varchar2(120) null,
    modifiedTime date          null,
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
    createdTime   date          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  date          null,
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
    createdTime          date          null,
    deleted              number(1, 0)  null,
    modifier             varchar2(120) null,
    modifiedTime         date          null,
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



ALTER TABLE h_perm_biz_function ADD (printAble number(1, 0) DEFAULT null);

update h_biz_property t set t.propertyType = 'SHORT_TEXT' where t.code = 'id' and t.propertyType = 'WORK_SHEET';

ALTER TABLE h_timer_job ADD (taskId varchar2(120) DEFAULT null);
comment on column h_timer_job.taskId is '任务id';

ALTER TABLE h_job_result ADD (taskId varchar2(120) DEFAULT null);
comment on column h_job_result.taskId is '任务id';




CREATE TABLE h_org_department_history (
  id varchar2(120)  NOT NULL 
    primary key,
  creater varchar2(120)  DEFAULT NULL,
  createdTime date DEFAULT NULL,
  deleted number(1, 0) DEFAULT NULL,
  modifier varchar2(120)  DEFAULT NULL,
  modifiedTime date DEFAULT NULL,
  remarks varchar2(200)  DEFAULT NULL,
  extend1 varchar2(255)  DEFAULT NULL,
  extend2 varchar2(255)  DEFAULT NULL,
  extend3 varchar2(255)  DEFAULT NULL,
  extend4 int DEFAULT NULL,
  extend5 int DEFAULT NULL,
  calendarId varchar2(36)  DEFAULT NULL,
  employees int DEFAULT NULL,
  leaf number(1, 0) DEFAULT NULL,
  managerId varchar2(2000)  DEFAULT NULL,
  name varchar2(200)  DEFAULT NULL,
  parentId varchar2(36)  DEFAULT NULL,
  queryCode varchar2(512)  DEFAULT NULL,
  sortKey int DEFAULT NULL,
  sourceId varchar2(40)  DEFAULT NULL,
  targetParentId varchar2(36)  DEFAULT NULL,
  targetQueryCode varchar2(512)  DEFAULT NULL,
  changeTime date DEFAULT NULL,
  version int DEFAULT NULL,
  changeAction varchar2(20)  DEFAULT NULL
);

create index idx_hist_source_id on h_org_department_history (sourceId);

--1.4版本

ALTER TABLE h_biz_rule ADD (dataConditionJoinType VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.dataConditionJoinType is '触发数据条件连接类型';

ALTER TABLE h_biz_rule ADD (dataConditionJson CLOB);
comment on column h_biz_rule.dataConditionJson is '数据条件json';

ALTER TABLE h_perm_group ADD (authorType varchar2(40) DEFAULT null);

ALTER TABLE h_org_user ADD (pinYin VARCHAR(250) DEFAULT null);
comment on column h_org_user.pinYin is '姓名拼音';

ALTER TABLE h_org_user ADD (shortPinYin VARCHAR(250) DEFAULT null);
comment on column h_org_user.shortPinYin is '姓名简拼';

ALTER TABLE h_app_package ADD (appNameSpace varchar2(40) DEFAULT NULL);

-- ALTER TABLE h_perm_function_condition MODIFY (value CLOB);

create table h_open_api_event
(
  id varchar2(120) not null
    primary key,
  callback varchar2(400) null,
  clientId varchar2(30) null,
  eventTarget varchar2(300) null,
  eventTargetType varchar2(255) null,
  eventType varchar2(255) null
);

update h_biz_query_column set name = '拥有者' where propertyCode = 'owner';
update h_biz_query_column set name = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_query_condition set name = '拥有者' where propertyCode = 'owner';
update h_biz_query_condition set name = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_property set name = '拥有者' where code = 'owner';
update h_biz_property set name = '拥有者部门' where code = 'ownerDeptId';

CREATE TABLE h_access_token (
                              id varchar2(40)  NOT NULL PRIMARY KEY,
                              userId varchar2(40)  DEFAULT NULL,
                              leastUse int DEFAULT NULL,
                              accessToken varchar2(2000)  DEFAULT NULL,
                              createTime date DEFAULT NULL
);

create index idx_access_token_userId on h_access_token (userId);

ALTER TABLE h_biz_rule ADD (targetTableCode VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.targetTableCode is '目标对象编码';

ALTER TABLE h_biz_rule ADD (ruleScopeChildJson CLOB);
comment on column h_biz_rule.ruleScopeChildJson is '子表查找范围json';

ALTER TABLE h_biz_rule ADD (ruleActionMainScopeJson CLOB);
comment on column h_biz_rule.ruleActionMainScopeJson is '执行动作中主表筛选条件json';


ALTER TABLE h_biz_rule ADD (insertConditionJoinType VARCHAR(40) DEFAULT null);
comment on column h_biz_rule.insertConditionJoinType is '条件连接类型';



DELETE FROM h_perm_admin WHERE id='2c928a4c6c043e48016c04c108300a90';

INSERT INTO h_perm_admin (id, creater, createdTime, deleted, modifier, modifiedTime, remarks, adminType, dataManage, dataQuery, userId)
VALUES ('2c928a4c6c043e48016c04c108300a90', '2c928e4c6a4d1d87016a4d1f2f760048', sysdate, 0, NULL, sysdate, NULL, 'ADMIN', 1, 1, '2c9280a26706a73a016706a93ccf002b');

-- 刪除审批意见类型数据项
DELETE FROM h_biz_property WHERE propertyType='COMMENT';

CREATE TABLE h_report_page
(
    id           varchar2(120) NOT NULL PRIMARY KEY,
    creater      varchar2(120),
    createdTime  date,
    deleted      number(1, 0),
    modifier     varchar2(120),
    modifiedTime date,
    remarks      varchar2(200),
    code         varchar2(40),
    icon         varchar2(50),
    pcAble       number(1, 0),
    name         varchar2(50),
    mobileAble   number(1, 0),
    appCode      varchar2(40),
    name_i18n    varchar2(1000)
);

-- 数据规则触发记录表
ALTER TABLE h_biz_rule_trigger
    ADD ( triggerMainObjectId varchar2(100));
ALTER TABLE h_biz_rule_trigger
    ADD ( triggerMainObjectName varchar2(200));
ALTER TABLE h_biz_rule_trigger
    ADD ( triggerTableType varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceAppCode varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceAppName varchar2(50));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceSchemaCode varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceSchemaName varchar2(50));
ALTER TABLE h_biz_rule_trigger
    ADD ( targetSchemaName varchar2(50));
ALTER TABLE h_biz_rule_trigger
    ADD ( targetTableCode varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( success number(1, 0));
ALTER TABLE h_biz_rule_trigger
    ADD ( failLog CLOB);
ALTER TABLE h_biz_rule_trigger
    ADD ( effect number(1, 0));

-- 数据规则影响数据表
ALTER TABLE h_biz_rule_effect
    ADD ( targetTableType varchar2(40));
ALTER TABLE h_biz_rule_effect
    ADD ( targetTableCode varchar2(40));
ALTER TABLE h_biz_rule_effect
    ADD ( targetMainObjectId varchar2(100));
ALTER TABLE h_biz_rule_effect
    ADD ( targetMainObjectName varchar2(200));
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertyLastValue CLOB);
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertySetValue CLOB);
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertyName varchar2(50));
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertyType varchar2(40));


ALTER TABLE h_report_page
    ADD ( reportObjectId varchar2(40));
    
    
CREATE TABLE h_biz_query_present (
  id varchar2(120)  NOT NULL primary key,
  creater varchar2(120)  DEFAULT NULL,
  createdTime date DEFAULT NULL,
  deleted number(1, 0) DEFAULT NULL,
  modifier varchar2(120)  DEFAULT NULL,
  modifiedTime date DEFAULT NULL,
  remarks varchar2(200)  DEFAULT NULL,
  queryId varchar2(36) DEFAULT NULL,
  schemaCode varchar2(40) DEFAULT NULL,
  clientType varchar2(40)  DEFAULT NULL,
  htmlJson clob  DEFAULT NULL,
  actionsJson clob  DEFAULT NULL,
  columnsJson clob  DEFAULT NULL
);

comment on column h_biz_query_present.clientType is 'PC或者MOBILE端';
comment on column h_biz_query_present.htmlJson is '列表htmlJson数据';
comment on column h_biz_query_present.actionsJson is '列表action操作JSON数据';
comment on column h_biz_query_present.columnsJson is '列表展示字段columnJSON数据';

ALTER TABLE h_biz_query ADD (queryPresentationType VARCHAR(40) DEFAULT 'LIST');
comment on column h_biz_query.queryPresentationType is '列表视图类型';

ALTER TABLE h_biz_query ADD (showOnPc number(1, 0) DEFAULT NULL);
comment on column h_biz_query.showOnPc is 'PC是否可见';

ALTER TABLE h_biz_query ADD (showOnMobile number(1, 0) DEFAULT NULL);
comment on column h_biz_query.showOnMobile is '移动端是否可见';

ALTER TABLE h_biz_query ADD (publish number(1, 0) DEFAULT NULL);
comment on column h_biz_query.publish is '发布状态';


ALTER TABLE h_biz_query_column ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_column.clientType is 'PC或者MOBILE端';


ALTER TABLE h_biz_query_condition ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_condition.clientType is 'PC或者MOBILE端';

ALTER TABLE h_biz_query_sorter ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_sorter.clientType is 'PC或者MOBILE端';


ALTER TABLE h_biz_query_action ADD (clientType VARCHAR(40) DEFAULT 'PC');
comment on column h_biz_query_action.clientType is 'PC或者MOBILE端';

ALTER TABLE h_org_department ADD (dingDeptManagerId VARCHAR(255) DEFAULT null);
comment on column h_org_department.dingDeptManagerId is '钉钉部门主管id集合';


ALTER TABLE h_org_role_user ADD (userSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_role_user.userSourceId is '钉钉用户id非unionId';
ALTER TABLE h_org_role_user ADD (roleSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_role_user.roleSourceId is '钉钉角色id';

-- 更新数据
-- update h_org_role_user,h_org_role set h_org_role_user.roleSourceId = h_org_role.sourceId WHERE h_org_role_user.roleId = h_org_role.id;
--
-- update h_org_role_user,h_org_user set h_org_role_user.userSourceId = h_org_user.userId WHERE h_org_role_user.userId = h_org_user.id;


ALTER TABLE h_org_dept_user ADD (userSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_dept_user.userSourceId is '钉钉用户id非unionId';
ALTER TABLE h_org_dept_user ADD (deptSourceId VARCHAR(255) DEFAULT null);
comment on column h_org_dept_user.deptSourceId is '钉钉部门id';

-- 更新数据
-- update h_org_dept_user,h_org_department set h_org_dept_user.deptSourceId = h_org_department.sourceId WHERE h_org_dept_user.deptId = h_org_department.id;

-- update h_org_dept_user,h_org_user set h_org_dept_user.userSourceId = h_org_user.userId WHERE h_org_dept_user.userId = h_org_user.id;

-- 角色用户关联表联合索引
CREATE INDEX idx_role_user_sourceid ON h_org_role_user(userSourceId,roleSourceId);

-- 部门用户关联表联合索引
CREATE INDEX idx_dept_user_composeid ON h_org_dept_user(userId,deptId);


ALTER TABLE h_app_function ADD (pcAble number(1,0) DEFAULT 1);

ALTER TABLE h_app_function ADD (mobileAble number(1,0) DEFAULT 1);

UPDATE h_app_function SET pcAble=0 WHERE type='Report' AND code IN (SELECT code FROM h_report_page WHERE pcAble=0);

UPDATE h_app_function SET mobileAble=0 WHERE type='Report' AND code IN (SELECT code FROM h_report_page WHERE mobileAble=0);

CREATE TABLE d_process_instance
(
    id                varchar(42)  NOT NULL,
    processCode       varchar(120) NOT NULL,
    originator        varchar(64)  NOT NULL,
    title             varchar(64) DEFAULT NULL,
    url               varchar(255) NOT NULL,
    processInstanceId varchar(64)  NOT NULL,
    wfInstanceId      varchar(64)  NOT NULL,
    formComponents    clob,
    status            varchar(42) DEFAULT NULL,
    result            varchar(42) DEFAULT NULL,
    createTime        date        DEFAULT NULL,
    requestId         varchar(42) DEFAULT NULL,
    wfWorkItemId      varchar(64) DEFAULT NULL,
    bizProcessStatus  varchar(64) DEFAULT NULL,
    PRIMARY KEY (id)
    -- UNIQUE KEY IDX_UNIQUE_WFIID (wfInstanceId)
);

CREATE TABLE d_process_task
(
    id                varchar(42) NOT NULL,
    processInstanceId varchar(64) NOT NULL,
    taskId            int         NOT NULL,
    userId            varchar(64) NOT NULL,
    url               varchar(255) DEFAULT NULL,
    wfWorkItemId      varchar(42) NOT NULL,
    wfInstanceId      varchar(42) NOT NULL,
    status            varchar(64)  DEFAULT NULL,
    result            varchar(64)  DEFAULT NULL,
    createTime        date         DEFAULT NULL,
    requestId         varchar(42)  DEFAULT NULL,
    bizProcessStatus  varchar(64)  DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE d_process_template
(
    id               varchar(42)    NOT NULL,
    tempCode         varchar(64)    NOT NULL,
    processCode      varchar(120)   NOT NULL,
    processName      varchar(64)    NOT NULL,
    agentId          decimal(10, 0) NOT NULL,
    formField        clob,
    createTime       date        DEFAULT NULL,
    requestId        varchar(42) DEFAULT NULL,
    bizProcessStatus varchar(64) DEFAULT NULL,
    wfWorkItemId     varchar(64) DEFAULT NULL,
    PRIMARY KEY (id)
);

create index idx_d_process_template_tc on d_process_template (tempCode);

--1.5版本

ALTER TABLE h_biz_sheet ADD (tempAuthSchemaCodes VARCHAR(350) DEFAULT null);
comment on column h_biz_sheet.tempAuthSchemaCodes is '临时授权的SchemaCode 以,分割';

ALTER TABLE h_biz_sheet ADD (borderMode VARCHAR(10) DEFAULT null);
comment on column h_biz_sheet.borderMode is '表单是否支持边框模式,close或open';
ALTER TABLE h_biz_sheet ADD (layout VARCHAR(20) DEFAULT null);
comment on column h_biz_sheet.layout is '表单边框布局,horizontal-左右布局,vertical-上下布局';

ALTER TABLE h_biz_sheet rename column layout to layoutType;

CREATE TABLE h_perm_license
(
    id                varchar(42) NOT NULL,
    bizId             varchar(42) NOT NULL,
    bizType           varchar(42) NOT NULL,
    createdTime       date        NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE H_BIZ_SCHEMA MODIFY  (remarks VARCHAR(2000));

ALTER TABLE h_org_department ADD (isShow number(1,0) DEFAULT 1);
comment on column h_org_department.isShow is '部门是否可见';

ALTER TABLE h_org_department ADD (deptType VARCHAR(40) DEFAULT 'DEPT');
comment on column h_org_department.deptType is '部门类型';

ALTER TABLE h_org_role_group ADD (roleType VARCHAR(40) DEFAULT 'SYS');
comment on column h_org_role_group.roleType is '角色类型';

ALTER TABLE h_org_role ADD (roleType VARCHAR(40) DEFAULT 'SYS');
comment on column h_org_role.roleType is '角色类型';

ALTER TABLE h_org_role_user ADD (unitType VARCHAR(40) DEFAULT 'USER');
comment on column h_org_role_user.unitType is '角色关联类型';

ALTER TABLE h_org_role_user ADD (deptId VARCHAR(40) );
comment on column h_org_role_user.deptId is '角色关联部门ID';

UPDATE h_org_role_group SET roleType = 'DINGTALK' WHERE  sourceId is not null;

UPDATE h_org_role SET roleType = 'DINGTALK' WHERE  sourceId is not null;

ALTER TABLE d_process_template RENAME COLUMN wfWorkItemId TO queryId;
ALTER TABLE d_process_template MODIFY (queryId VARCHAR(42));
comment on column d_process_template.queryId is '列表ID';

INSERT INTO h_system_setting(id, paramCode, paramValue, settingType, checked, fileUploadType)
VALUES ('2c928e636f3fe9b5016f3feb81c70000', 'dingtalk.isSynEdu', 'false', 'DINGTALK_BASE', 0, NULL);

-- DROP index UK_h_system_pair_paramCode;
alter table h_system_pair drop constraint UK_h_system_pair_paramCode;

ALTER TABLE h_biz_perm_group ADD (departments clob DEFAULT null);
comment on column h_biz_perm_group.departments is '部门范围';

ALTER TABLE h_biz_perm_group ADD (authorType VARCHAR(40) DEFAULT null);
comment on column h_biz_perm_group.authorType is '授权类型';

ALTER TABLE h_biz_rule ADD (triggerSchemaCodeIsGroup number(1, 0) DEFAULT null);
comment on column h_biz_rule.triggerSchemaCodeIsGroup is '主表加子表数据项';

ALTER TABLE biz_workflow_instance ADD (sequenceNo VARCHAR(200) DEFAULT null);
comment on column biz_workflow_instance.sequenceNo is '单据号';

ALTER TABLE h_org_user ADD (imgUrlId VARCHAR(40) DEFAULT null);
comment on column h_org_user.imgUrlId is '头像id';

ALTER TABLE h_biz_query_condition ADD (dateType VARCHAR(40) DEFAULT null);
comment on column h_biz_query_condition.dateType is '日期快捷方式';

--1.6版本

CREATE TABLE qrtz_job_details
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    JOB_NAME  VARCHAR2(200) NOT NULL,
    JOB_GROUP VARCHAR2(200) NOT NULL,
    DESCRIPTION VARCHAR2(250) NULL,
    JOB_CLASS_NAME   VARCHAR2(250) NOT NULL,
    IS_DURABLE VARCHAR2(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR2(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR2(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR2(1) NOT NULL,
    JOB_DATA BLOB NULL,
    CONSTRAINT QRTZ_JOB_DETAILS_PK PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);
CREATE TABLE qrtz_triggers
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    JOB_NAME  VARCHAR2(200) NOT NULL,
    JOB_GROUP VARCHAR2(200) NOT NULL,
    DESCRIPTION VARCHAR2(250) NULL,
    NEXT_FIRE_TIME NUMBER(13) NULL,
    PREV_FIRE_TIME NUMBER(13) NULL,
    PRIORITY NUMBER(13) NULL,
    TRIGGER_STATE VARCHAR2(16) NOT NULL,
    TRIGGER_TYPE VARCHAR2(8) NOT NULL,
    START_TIME NUMBER(13) NOT NULL,
    END_TIME NUMBER(13) NULL,
    CALENDAR_NAME VARCHAR2(200) NULL,
    MISFIRE_INSTR NUMBER(2) NULL,
    JOB_DATA BLOB NULL,
    CONSTRAINT QRTZ_TRIGGERS_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    CONSTRAINT QRTZ_TRIGGER_TO_JOBS_FK FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);
CREATE TABLE qrtz_simple_triggers
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    REPEAT_COUNT NUMBER(7) NOT NULL,
    REPEAT_INTERVAL NUMBER(12) NOT NULL,
    TIMES_TRIGGERED NUMBER(10) NOT NULL,
    CONSTRAINT QRTZ_SIMPLE_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    CONSTRAINT QRTZ_SIMPLE_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_cron_triggers
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    CRON_EXPRESSION VARCHAR2(120) NOT NULL,
    TIME_ZONE_ID VARCHAR2(80),
    CONSTRAINT QRTZ_CRON_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    CONSTRAINT QRTZ_CRON_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_simprop_triggers
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    STR_PROP_1 VARCHAR2(512) NULL,
    STR_PROP_2 VARCHAR2(512) NULL,
    STR_PROP_3 VARCHAR2(512) NULL,
    INT_PROP_1 NUMBER(10) NULL,
    INT_PROP_2 NUMBER(10) NULL,
    LONG_PROP_1 NUMBER(13) NULL,
    LONG_PROP_2 NUMBER(13) NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR2(1) NULL,
    BOOL_PROP_2 VARCHAR2(1) NULL,
    CONSTRAINT QRTZ_SIMPROP_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    CONSTRAINT QRTZ_SIMPROP_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_blob_triggers
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    CONSTRAINT QRTZ_BLOB_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    CONSTRAINT QRTZ_BLOB_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_calendars
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    CALENDAR_NAME  VARCHAR2(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    CONSTRAINT QRTZ_CALENDARS_PK PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);
CREATE TABLE qrtz_paused_trigger_grps
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR2(200) NOT NULL,
    CONSTRAINT QRTZ_PAUSED_TRIG_GRPS_PK PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);
CREATE TABLE qrtz_fired_triggers
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    ENTRY_ID VARCHAR2(95) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    INSTANCE_NAME VARCHAR2(200) NOT NULL,
    FIRED_TIME NUMBER(13) NOT NULL,
    SCHED_TIME NUMBER(13) NOT NULL,
    PRIORITY NUMBER(13) NOT NULL,
    STATE VARCHAR2(16) NOT NULL,
    JOB_NAME VARCHAR2(200) NULL,
    JOB_GROUP VARCHAR2(200) NULL,
    IS_NONCONCURRENT VARCHAR2(1) NULL,
    REQUESTS_RECOVERY VARCHAR2(1) NULL,
    CONSTRAINT QRTZ_FIRED_TRIGGER_PK PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);
CREATE TABLE qrtz_scheduler_state
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    INSTANCE_NAME VARCHAR2(200) NOT NULL,
    LAST_CHECKIN_TIME NUMBER(13) NOT NULL,
    CHECKIN_INTERVAL NUMBER(13) NOT NULL,
    CONSTRAINT QRTZ_SCHEDULER_STATE_PK PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);
CREATE TABLE qrtz_locks
(
    SCHED_NAME VARCHAR2(120) NOT NULL,
    LOCK_NAME  VARCHAR2(40) NOT NULL,
    CONSTRAINT QRTZ_LOCKS_PK PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);

create index idx_qrtz_j_req_recovery on qrtz_job_details(SCHED_NAME,REQUESTS_RECOVERY);
create index idx_qrtz_j_grp on qrtz_job_details(SCHED_NAME,JOB_GROUP);

create index idx_qrtz_t_j on qrtz_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);
create index idx_qrtz_t_jg on qrtz_triggers(SCHED_NAME,JOB_GROUP);
create index idx_qrtz_t_c on qrtz_triggers(SCHED_NAME,CALENDAR_NAME);
create index idx_qrtz_t_g on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP);
create index idx_qrtz_t_state on qrtz_triggers(SCHED_NAME,TRIGGER_STATE);
create index idx_qrtz_t_n_state on qrtz_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
create index idx_qrtz_t_n_g_state on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
create index idx_qrtz_t_next_fire_time on qrtz_triggers(SCHED_NAME,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_st on qrtz_triggers(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
create index idx_qrtz_t_nft_st_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
create index idx_qrtz_t_nft_st_misfire_grp on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

create index idx_qrtz_ft_trig_inst_name on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME);
create index idx_qrtz_ft_inst_job_req_rcvry on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
create index idx_qrtz_ft_j_g on qrtz_fired_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);
create index idx_qrtz_ft_jg on qrtz_fired_triggers(SCHED_NAME,JOB_GROUP);
create index idx_qrtz_ft_t_g on qrtz_fired_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
create index idx_qrtz_ft_tg on qrtz_fired_triggers(SCHED_NAME,TRIGGER_GROUP);


create table h_form_comment
(
    id              varchar(42)                    not null
        primary key,
    content         varchar2(3000)                 null,
    commentator     varchar2(42)                   not null,
    commentatorName varchar2(80)                   not null,
    departmentId    varchar2(42)                   null,
    schemaCode      varchar2(42)                   not null,
    bizObjectId     varchar2(42)                   not null,
    replyCommentId  varchar2(42)                   null,
    replyUserId     varchar2(42)                   null,
    replyUserName   varchar2(80)                   null,
    originCommentId varchar2(42)                   null,
    floor           int          default 0         not null,
    state           varchar2(20) default 'ENABLED' not null,
    deleted         number(1, 0) default 0         not null,
    attachmentNum   int          default 0         not null,
    modifier        varchar2(42)                   null,
    createdTime     date         default sysdate   not null,
    modifiedTime    date                           null,
    text            varchar2(4000)                 null
);

create index IDX_FORM_OBJ_ID on h_form_comment (bizObjectId);

ALTER TABLE h_biz_property ADD (relativePropertyCode VARCHAR2(80) DEFAULT null);
comment on column h_biz_property.relativePropertyCode is '关联表单显示字段';

create index idx_h_biz_attachment_boi on h_biz_attachment (bizObjectId);
alter table H_BIZ_ATTACHMENT modify PARENTBIZOBJECTID default '';
create index idx_h_biz_attachment_pboi on h_biz_attachment (parentBizObjectId);

-- create index idx_h_org_role_code on h_org_role (code);

-- 這里有问题
alter table H_IM_WORK_RECORD_HISTORY modify CONTENT VARCHAR2(3000);

-- ALTER TABLE h_im_work_record MODIFY content varchar2(3000) default '';

-- ALTER TABLE h_form_comment ADD  (text varchar2(4000));
-- comment on column h_form_comment.text is '评论内容html格式';

create table h_from_comment_attachment
(
    id            varchar2(42)               not null
        primary key,
    bizObjectId   varchar2(42)               not null,
    schemaCode    varchar2(42)               not null,
    commentId     varchar2(42)               not null,
    fileExtension varchar2(30)               null,
    fileSize      int       default 0       not null,
    mimeType      varchar2(50)               not null,
    name          varchar2(255)              not null,
    refId         varchar2(80)               not null,
    createdTime   date default sysdate not null,
    creater       varchar2(42)               not null
);

create index IDX_F_C_A_COMM_ID on h_from_comment_attachment (commentId);
create index IDX_F_C_A_REF_ID on h_from_comment_attachment (refId);


ALTER TABLE h_org_user ADD (dingUserJson CLOB DEFAULT null);
comment on column h_org_user.dingUserJson is '钉钉同步过来的json数据记录';


CREATE TABLE h_related_corp_setting (
                                        id varchar2(120)  NOT NULL   primary key,
                                        creater varchar2(120)  DEFAULT NULL,
                                        createdTime date DEFAULT NULL,
                                        deleted number(1, 0) DEFAULT NULL,
                                        modifier varchar2(120)  DEFAULT NULL,
                                        modifiedTime date DEFAULT NULL,
                                        remarks varchar2(200)  DEFAULT NULL,
                                        agentId varchar2(120)  DEFAULT NULL,
                                        appSecret varchar2(120)  DEFAULT NULL,
                                        appkey varchar2(120)  DEFAULT NULL,
                                        corpId varchar2(120)  DEFAULT NULL,
                                        corpSecret varchar2(120)  DEFAULT NULL,
                                        exportHost varchar2(36)  DEFAULT NULL,
                                        extend1 varchar2(120)  DEFAULT NULL,
                                        extend2 varchar2(120)  DEFAULT NULL,
                                        extend3 varchar2(120)  DEFAULT NULL,
                                        extend4 varchar2(120)  DEFAULT NULL,
                                        extend5 varchar2(120)  DEFAULT NULL,
                                        headerNum int DEFAULT NULL,
                                        name varchar2(240)  DEFAULT NULL,
                                        orgType varchar2(12)  DEFAULT NULL,
                                        relatedType varchar2(12)  DEFAULT NULL,
                                        scanAppId varchar2(120)  DEFAULT NULL,
                                        scanAppSecret varchar2(200)  DEFAULT NULL,
                                        redirectUri varchar2(200)  DEFAULT NULL,
                                        synRedirectUri varchar2(120)  DEFAULT NULL,
                                        pcServerUrl varchar2(120)  DEFAULT NULL,
                                        mobileServerUrl varchar2(120)  DEFAULT NULL,
                                        syncType varchar2(12)  DEFAULT NULL
);

ALTER TABLE h_org_department ADD (corpId VARCHAR2(256) DEFAULT null);
ALTER TABLE h_org_department_history ADD (corpId VARCHAR2(256) DEFAULT null);

ALTER TABLE h_org_user ADD (corpId VARCHAR2(256) DEFAULT null);
comment on column h_org_user.corpId is '用户新增组织外键关联';

ALTER TABLE h_org_role_group ADD (corpId VARCHAR2(256) DEFAULT null);
comment on column h_org_role_group.corpId is '角色组新增组织外键关联';

ALTER TABLE h_org_role ADD (corpId VARCHAR(256) DEFAULT null);
comment on column h_org_role.corpId is '角色新增组织外键关联';

CREATE TABLE h_org_synchronize_log (
                                       id varchar2(120)  NOT NULL   primary key,
                                       targetType varchar2(30)  DEFAULT NULL,
                                       trackId varchar2(60)  DEFAULT NULL,
                                       targetId varchar2(120)  DEFAULT NULL,
                                       errorType varchar2(1000)  DEFAULT NULL
);

ALTER TABLE h_biz_sheet ADD (formComment number(1,0) DEFAULT 0);
comment on column h_biz_sheet.formComment is '是否开启表单评论';


ALTER TABLE H_ORG_DEPARTMENT DROP CONSTRAINT UK_h_org_department_sourceId;

ALTER TABLE H_ORG_ROLE DROP CONSTRAINT UK_h_org_role_sourceId;

create table h_biz_export_task
(
    id                     varchar2(36) not null
        primary key,
    createdTime             date            null,
    creater                 varchar2(120)   null,
    deleted                 number(1, 0)    null,
    modifiedTime            date            null,
    modifier                varchar2(120)   null,
    remarks                 varchar2(200)   null,
    startTime             date          null ,
    endTime             date          null ,
    message                 varchar2(4000)  null,
    taskStatus              varchar2(50)    null,
    exportResultStatus      varchar2(50)     null,
    userId                  varchar2(36)     null,
    path                     varchar2(120)   null
);

-- 删除部门用户关联重复项 保留最旧的记录
delete from h_org_dept_user where id in(
    select a.id from (
                         select hodu.id from h_org_dept_user hodu where hodu.id in(
                             select a.id from h_org_dept_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) as num,a.deptId,a.userId,MIN(a.createdTime) from h_org_dept_user a GROUP BY a.deptId,a.userId having count(a.userId) > 1
                                              ) b on a.deptId = b.deptId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_dept_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.deptId,a.userId,MIN(a.createdTime) minTime from h_org_dept_user a GROUP BY a.deptId,a.userId having count(a.userId) > 1
                                               ) b on a.deptId = b.deptId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);
-- 建立部门用户联合唯一索引
DROP INDEX idx_dept_user_composeid;

alter table h_org_dept_user add constraint idx_dept_user_composeid unique(userId,deptId);

-- 删除角色用户关联重复项 保留最旧的记录
delete from h_org_role_user where id in(
    select a.id from (
                         select hodu.id from h_org_role_user hodu where hodu.id in(
                             select a.id from h_org_role_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) from h_org_role_user a GROUP BY a.roleId,a.userId having count(a.userId) > 1
                                              ) b on a.roleId = b.roleId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_role_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) minTime from h_org_role_user a GROUP BY a.roleId,a.userId having count(a.userId) > 1
                                               ) b on a.roleId = b.roleId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);

-- 建立角色用户联合唯一索引
alter table h_org_role_user add constraint idx_role_user_composeid unique(userId,roleId);



update d_process_task hpt set hpt.userId = (select hou.id from h_org_user hou where hpt.userId = hou.userId)
where exists (select userId from h_org_user hou where hou.userId = hpt.userId);

update d_process_instance hpi set hpi.originator = (select hou.id from h_org_user hou where hpi.originator = hou.userId)
where exists (select hou.userId from h_org_user hou where hou.userId = hpi.originator);


-- ALTER TABLE h_biz_sheet MODIFY COLUMN tempAuthSchemaCodes varchar2(3500) DEFAULT NULL;

ALTER TABLE h_biz_sheet MODIFY  (tempAuthSchemaCodes varchar2(3500));

--1.7版本

ALTER TABLE h_perm_biz_function ADD (editOwnerAble number(1, 0) DEFAULT null);
create table h_biz_database_pool
(
    id            varchar2(120) not null
        primary key,
    creater       varchar2(120) null,
    createdTime   date          null,
    deleted       number(1, 0)  null,
    modifier      varchar2(120) null,
    modifiedTime  date          null,
    remarks       varchar2(200) null,
    code          varchar2(40)  null,
    name          varchar2(50)  null,
    description   CLOB          null,
    databaseType  varchar2(15)  null,
    jdbcUrl       varchar2(200) null,
    username      varchar2(40)  null,
    password      varchar2(300)  null
);
ALTER TABLE h_org_user ADD (position varchar2(80) DEFAULT null);
comment on column h_org_user.position is '职位';


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


CREATE TABLE h_log_synchro (
                               id varchar2(42) primary key,
                               trackId varchar2(60) NOT NULL,
                               creater varchar2(42) NULL,
                               createdTime date,
                               startTime date,
                               endTime date,
                               fixer varchar2(42)  NULL,
                               fixedTime date,
                               fixedCount INTEGER NOT NULL,
                               fixNotes varchar2(1000) NOT NULL,
                               fixedStatus varchar2(40)  NULL ,
                               executeStatus varchar2(40)  NULL
);

ALTER TABLE h_org_synchronize_log ADD (corpId varchar2(120) DEFAULT null);
comment on column h_org_synchronize_log.corpId is '组织corpId';

ALTER TABLE h_org_synchronize_log ADD (status varchar2(40) DEFAULT null);
comment on column h_org_synchronize_log.status is '状态';
create index Idx_bizproperty_schemaCode on h_biz_property(schemaCode);
create index idx_bizschema_schemaCode on h_biz_schema(code);

create table h_business_rule
(
    id varchar2(120) not null primary key,
    createdTime date null,
    creater       varchar2(120) null,
    deleted       number(1, 0)  null,
    modifiedTime  date          null,
    modifier      varchar2(120) null,
    node CLOB          null,
    route CLOB          null,
    schedulerSetting CLOB          null,
    bizRuleType varchar2(120) null,
    defaultRule number(1, 0)  null,
    code varchar2(120) null,
    name varchar2(300) null,
    schemaCode varchar2(120) null,
    remarks varchar2(600) null
);

create table h_log_business_rule_header (
                                            id varchar2(120) not null primary key,
                                            businessRuleCode varchar2(120) null,
                                            businessRuleName varchar2(600) null,
                                            endTime date          null,
                                            flowInstanceId varchar2(400) null,
                                            originator varchar2(120) null,
                                            schemaCode varchar2(120) null,
                                            startTime date          null,
                                            success number(1, 0)  null
);

create table h_log_business_rule_content (
                                             id varchar2(120) not null primary key,
                                             exceptionContent CLOB          null,
                                             exceptionNodeCode varchar2(400) null,
                                             exceptionNodeName varchar2(600) null,
                                             flowInstanceId varchar2(400) null,
                                             triggerCoreData CLOB          null
);


create table h_log_business_rule_node (
                                          id varchar2(120) not null primary key,
                                          endTime date          null,
                                          flowInstanceId varchar2(400) null,
                                          nodeCode varchar2(400) null,
                                          nodeInstanceId varchar2(400) null,
                                          nodeName varchar2(600) null,
                                          nodeSequence INTEGER NULL,
                                          startTime date          null
);

create table h_log_business_rule_data_trace (
                                                id varchar2(120) not null primary key,
                                                flowInstanceId varchar2(400) null,
                                                nodeCode varchar2(400) null,
                                                nodeInstanceId varchar2(400) null,
                                                nodeName varchar2(600) null,
                                                ruleTriggerActionType varchar2(400) null,
                                                targetObjectId varchar2(400) null,
                                                targetSchemaCode varchar2(400) null,
                                                traceLastData CLOB          null,
                                                traceSetData CLOB          null,
                                                traceUpdateDetail CLOB          null
);


ALTER TABLE h_im_message ADD (externalLink number(1, 0)  null);
comment on column h_im_message.externalLink is '是否是外部链接';

ALTER TABLE h_im_message_history ADD (externalLink number(1, 0)  null);
comment on column h_im_message_history.externalLink is '是否是外部链接';

ALTER TABLE h_workflow_header ADD (externalLinkEnable number(1, 0)  null);
comment on column h_workflow_header.externalLinkEnable is '是否是外部链接';
ALTER TABLE h_workflow_header ADD (shortCode varchar2(50)  null);
comment on column h_workflow_header.shortCode is '是否是短链接';


ALTER TABLE h_biz_schema ADD (businessRuleEnable number(1, 0)  DEFAULT 0);
comment on column h_biz_schema.businessRuleEnable is '是否启用业务规则';


create index Idx_h_log_b_r_hr_flowId on h_log_business_rule_header(flowInstanceId);
create index Idx_h_log_b_r_ct_flowId on h_log_business_rule_content(flowInstanceId);
create index Idx_h_log_b_r_n_flowId on h_log_business_rule_node(flowInstanceId);
create index Idx_h_log_b_r_d_t_flowId on h_log_business_rule_data_trace(flowInstanceId);

ALTER TABLE h_perm_admin ADD (parentId varchar2(120));
comment on column h_perm_admin.parentId is '基于哪个创建的';

ALTER TABLE h_perm_department_scope MODIFY (name varchar2(200));

ALTER TABLE biz_workflow_instance ADD (schemaCode varchar2(40) DEFAULT null);
comment on column biz_workflow_instance.schemaCode is '模型编码';

-- 冗余schemaCode
update biz_workflow_instance w set w.schemaCode = (select t.schemaCode from h_workflow_header t where w.workflowCode = t.workflowCode);

UPDATE h_biz_schema SET businessRuleEnable=1;

ALTER TABLE h_log_business_rule_header ADD (sourceFlowInstanceId varchar2(360) null);

ALTER TABLE h_log_business_rule_header ADD (repair number(1, 0) null);

ALTER TABLE h_log_business_rule_header ADD (extend varchar2(765) null);

--1.8版本
ALTER TABLE h_org_department MODIFY (queryCode varchar2 (765));

ALTER TABLE biz_workitem ADD (batchOperate number(1, 0) DEFAULT null);
ALTER TABLE biz_workitem_finished ADD (batchOperate number(1, 0) DEFAULT null);
comment on column biz_workitem.batchOperate is '是否允许批量处理，0：否；1：是';
comment on column biz_workitem_finished.batchOperate is '是否允许批量处理，0：否；1：是';

ALTER TABLE h_workflow_header ADD (visibleType varchar2(40) DEFAULT 'PART_VISIABLE' NOT NULL);
comment on column h_workflow_header.visibleType is '流程可见范围类型，ALL_VISIABLE: 全部人员可见， PART_VISIABLE：部分可见';

ALTER TABLE h_biz_database_pool ADD (driverClassName varchar2(150) DEFAULT null);

ALTER TABLE h_biz_service ADD (shared number(1, 0) DEFAULT null);
ALTER TABLE h_biz_service ADD (userIds clob DEFAULT null);
comment on column h_biz_service.shared is '是否共享，0-私有，1共享';
comment on column h_biz_service.userIds is '用戶id，多個用戶用逗號隔開';

ALTER TABLE biz_workflow_instance ADD (dataType varchar2(20) DEFAULT 'NORMAL' NOT NULL);
comment on column biz_workflow_instance.dataType is '数据类型，正常：NORMAL；模拟：SIMULATIVE';
ALTER TABLE biz_workflow_instance ADD (runMode varchar2(20) DEFAULT 'MANUAL' NOT NULL);
comment on column biz_workflow_instance.runMode is '运行模式，自动：AUTO；手动：MANUAL';

ALTER TABLE biz_workflow_token ADD (isSkipped number(1, 0) DEFAULT NULL);
comment on column biz_workflow_token.isSkipped is '是否直接跳过';

ALTER TABLE h_biz_property ADD (relativeQuoteCode clob DEFAULT NULL);
comment on column h_biz_property.relativeQuoteCode is '关联表单引用属性';


alter table h_biz_property modify name varchar2(600);

CREATE TABLE biz_workflow_instance_bak (
  id                        varchar2(42) not null primary key,
  finishTime                date,
  receiveTime               date,
  startTime                 date,
  backupTime                date,
  appCode                   varchar2(200) NULL,
  bizObjectId               varchar2(36) NULL,
  departmentId              varchar2(200) NULL,
  departmentName            varchar2(200) NULL,
  instanceName              varchar2(200) NULL,
  originator                varchar2(200) NULL,
  originatorName            varchar2(200) NULL,
  parentId                  varchar2(36) NULL,
  remark                    varchar2(200) NULL,
  state                     varchar2(20) NULL,
  stateValue                number(11) NULL,
  usedTime                  number(20) NULL,
  waitTime                  number(20) NULL,
  workflowCode              varchar2(200) NULL,
  workflowTokenId           varchar2(36) NULL,
  workflowVersion           number(11) NULL,
  sheetBizObjectId          varchar2(36) NULL,
  sheetSchemaCode           varchar2(64) NULL,
  sequenceNo                varchar2(200) NULL,
  trustee                   varchar2(42) NULL,
  trusteeName               varchar2(80) NULL,
  trustType                 varchar2(20) NULL,
  schemaCode                varchar2(40) NULL,
  dataType                  varchar2(20) NULL,
  runMode                   varchar2(20) NULL
);

CREATE TABLE h_workflow_template_bak (
  id                        varchar2(42) not null primary key,
  creater                   varchar2(120) NULL,
  createdTime               date NULL,
  backupTime                date NULL,
  deleted                   number(1, 0) DEFAULT NULL,
  modifier                  varchar2(120)  NULL,
  modifiedTime              date NULL,
  remarks                   varchar2(200)  NULL,
  activateEventHandler      CLOB NULL,
  cancelEventHandler        CLOB NULL,
  content                   CLOB NULL,
  endEventHandler           CLOB NULL,
  startEventHandler         CLOB NULL,
  templateType              varchar2(10) NULL,
  workflowCode              varchar2(40) NULL,
  workflowVersion           number(11) NULL
);


alter table h_biz_perm_property modify name varchar2(600);

alter table h_biz_query_column modify name varchar2(600);

alter table h_biz_query_condition modify name varchar2(600);

alter table h_biz_query_sorter modify name varchar2(600);

alter table h_biz_property modify defaultValue varchar2(4000);

ALTER TABLE biz_workitem ADD (rootTaskId varchar2(42) DEFAULT NULL);
ALTER TABLE biz_workitem ADD (sourceTaskId varchar2(42) DEFAULT NULL);

ALTER TABLE biz_workitem_finished ADD (rootTaskId varchar2(42) DEFAULT NULL);
ALTER TABLE biz_workitem_finished ADD (sourceTaskId varchar2(42) DEFAULT NULL);

ALTER TABLE h_org_role_user ADD (usScope clob DEFAULT NULL);
comment on column h_org_role_user.usScope is '管理范围（人员）';

--1.9版本

CREATE TABLE h_biz_object_relation (
  id                varchar2(42) not null primary key,
  srcSc             varchar2(42) NULL,
  srcId             varchar2(42) NULL,
  srcParentSc       varchar2(42) NULL,
  srcParentId       varchar2(42) NULL,
  targetSc          varchar2(42) NULL,
  targetId          varchar2(42) NULL,
  targetParentSc    varchar2(42) NULL,
  targetParentId    varchar2(42) NULL,
  createTime        date NULL,
  sortBy            number(20) NULL
);

ALTER TABLE biz_workitem ADD (sortKey number(20) DEFAULT NULL);
ALTER TABLE biz_workitem_finished ADD (sortKey number(20) DEFAULT NULL);
ALTER TABLE biz_circulateitem ADD (sortKey number(20) DEFAULT NULL);
ALTER TABLE biz_circulateitem_finished ADD (sortKey number(20) DEFAULT NULL);

ALTER TABLE h_biz_property ADD (repeated number(1, 0) DEFAULT 0);
comment on column h_biz_property.repeated is '去重属性：1开启0不开启';


-- v6.0.0
ALTER TABLE h_biz_property ADD (selectionJson CLOB DEFAULT NULL);
comment on column h_biz_property.selectionJson is '下拉框附属';
create index idx_trigger_id on h_biz_rule_effect(triggerId);

ALTER TABLE h_perm_biz_function ADD (batchPrintAble number(1,0) DEFAULT 0);
comment on column h_perm_biz_function.batchPrintAble is '批量打印';

ALTER TABLE h_org_synchronize_log ADD (isSyncRoleScope int DEFAULT NULL);

ALTER TABLE h_biz_attachment ADD (base64ImageStr CLOB DEFAULT NULL);
comment on column h_biz_attachment.base64ImageStr is 'base64图片';

ALTER TABLE h_from_comment_attachment ADD (base64ImageStr CLOB DEFAULT NULL);
comment on column h_from_comment_attachment.base64ImageStr is 'base64图片';

-- v6.1
create table h_biz_datasource_category
(
	id varchar(128) default '' not null
		constraint H_BIZ_DATASOURCE_CATEGORY_PK
			primary key,
	createdTime timestamp default current_timestamp,
	modifiedTime timestamp default current_timestamp,
	name varchar(128) default '' not null
);


comment on table h_biz_datasource_category is '第三方数据源目录';


comment on column h_biz_datasource_category.id is '主键';


comment on column h_biz_datasource_category.createdTime is '创建时间';


comment on column h_biz_datasource_category.modifiedTime is '修改时间';


comment on column h_biz_datasource_category.name is '目录名称';


create table h_biz_datasource_method
(
	id varchar(128) default '' not null
		constraint H_BIZ_DATASOURCE_METHOD_PK
			primary key,
	createdTime timestamp default current_timestamp,
	creater varchar(128),
	modifier varchar(128),
	modifiedTime timestamp default current_timestamp,
	deleted number(1),
	remarks varchar(256),
	code varchar(64) default '' not null,
	name varchar(256) default '' not null,
	sqlConfig varchar(512) default '',
	datasourceCategoryId varchar(128) default '' not null,
	dataBaseConnectId varchar(128) default '' not null,
	reportObjectId varchar(32) not null,
	reportTableName varchar(32) default '' not null
);


comment on table h_biz_datasource_method is '第三方数据源方法';


comment on column h_biz_datasource_method.id is '主键';


comment on column h_biz_datasource_method.createdTime is '创建时间';


comment on column h_biz_datasource_method.creater is '创建者';


comment on column h_biz_datasource_method.modifier is '修改者';


comment on column h_biz_datasource_method.deleted is '删除标志';


comment on column h_biz_datasource_method.remarks is '备注';


comment on column h_biz_datasource_method.code is '编码';


comment on column h_biz_datasource_method.name is '名称';


comment on column h_biz_datasource_method.sqlConfig is 'sql执行语句';


comment on column h_biz_datasource_method.datasourceCategoryId is '集成目录ID';


comment on column h_biz_datasource_method.dataBaseConnectId is '数据源Id';


comment on column h_biz_datasource_method.reportObjectId is '自定义SQL高级数据源的唯一标志';


comment on column h_biz_datasource_method.reportTableName is '报表数据源表别名';


create unique index UQ_CODE_DATASOURCE_METHOD
	on h_biz_datasource_method (code);

-- auto-generated definition
create table h_org_user_extend_attr
(
    id           varchar(120)               not null ,
    name         varchar(255) default ''    null,
    code         varchar(120) default ''    null,
    mapKey       varchar(120) default ''    null,
    enable       number(1)   default 0      null,
    belong       varchar(120) default ''    null,
    corpId       varchar(128) default 'ALL' null,
    deleted      number(1)   default 1      null,
    createdBy    varchar(120) default ''    null,
    createdTime  date                       null,
    modifiedBy   varchar(120)               null,
    modifiedTime date                       null,
    constraint UK_code_corpId
        unique (code, corpId)
);

comment on column h_org_user_extend_attr.id is '主键ID';
comment on column h_org_user_extend_attr.name is '扩展字段名称';
comment on column h_org_user_extend_attr.code is '编码code';
comment on column h_org_user_extend_attr.mapKey is '映射key';
comment on column h_org_user_extend_attr.enable is '是否启用 0：否  1：是';
comment on column h_org_user_extend_attr.belong is '所属分组';
comment on column h_org_user_extend_attr.corpId is '组织ID';
comment on column h_org_user_extend_attr.deleted is '是否删除  0：否  1：是';
comment on column h_org_user_extend_attr.createdBy is '创建者';
comment on column h_org_user_extend_attr.createdTime is '创建时间';
comment on column h_org_user_extend_attr.modifiedBy is '修改者';
comment on column h_org_user_extend_attr.modifiedTime is '修改时间';

create index IDX_corpId
    on h_org_user_extend_attr (corpId);

-- auto-generated definition
create table h_org_user_union_extend_attr
(
    id           varchar(120)             not null,
    userId       varchar(120) default ''  null,
    extendAttrId varchar(120) default ''  null,
    mapVal       varchar(500) default '0' null,
    deleted      number(1)   default 1    null,
    createdBy    varchar(128) default ''  null,
    createdTime  date                     null,
    modifiedBy   varchar(128)             null,
    modifiedTime date                     null,
    constraint UK_userId_attrId
        unique (userId, extendAttrId)
);

comment on column h_org_user_union_extend_attr.id is '主键ID';
comment on column h_org_user_union_extend_attr.userId is '用户主键ID';
comment on column h_org_user_union_extend_attr.extendAttrId is '扩展属性ID';
comment on column h_org_user_union_extend_attr.mapVal is '映射值';
comment on column h_org_user_union_extend_attr.deleted is '是否删除  0：否  1：是';
comment on column h_org_user_union_extend_attr.createdBy is '创建者';
comment on column h_org_user_union_extend_attr.createdTime is '创建时间';
comment on column h_org_user_union_extend_attr.modifiedBy is '修改者';
comment on column h_org_user_union_extend_attr.modifiedTime is '修改时间';

create index IDX_extendAttrId
    on h_org_user_union_extend_attr (extendAttrId);

create index IDX_userId
    on h_org_user_union_extend_attr (userId);


/*==============================================================*/
/* Table: create firstPinyin function                              */
/*==============================================================*/
create or replace function FIRSTPINYIN(
    P_NAME in varchar2)
return varchar2
as
V_COMPARE varchar2(100);
V_RETURN varchar2(4000);
function F_NLSSORT(P_WORD in varchar2) return varchar2 as
begin
return nlssort(P_WORD, 'NLS_SORT=SCHINESE_PINYIN_M');
end;
begin

  V_COMPARE := F_NLSSORT(substr(NVL(P_NAME,0), 0, 1));
  if V_COMPARE >= F_NLSSORT(' 吖 ') and V_COMPARE <= F_NLSSORT('驁 ') then
  V_RETURN := V_RETURN || 'a';
  elsif V_COMPARE >= F_NLSSORT('八 ') and V_COMPARE <= F_NLSSORT('簿 ') then
  V_RETURN := V_RETURN || 'b';
  elsif V_COMPARE >= F_NLSSORT('嚓 ') and V_COMPARE <= F_NLSSORT('錯 ') then
  V_RETURN := V_RETURN || 'c';
  elsif V_COMPARE >= F_NLSSORT('咑 ') and V_COMPARE <= F_NLSSORT('鵽 ') then
  V_RETURN := V_RETURN || 'd';
  elsif V_COMPARE >= F_NLSSORT('妸 ') and V_COMPARE <= F_NLSSORT('樲 ') then
  V_RETURN := V_RETURN || 'e';
  elsif V_COMPARE >= F_NLSSORT('发 ') and V_COMPARE <= F_NLSSORT('猤 ') then
  V_RETURN := V_RETURN || 'f';
  elsif V_COMPARE >= F_NLSSORT('旮 ') and V_COMPARE <= F_NLSSORT('腂 ') then
  V_RETURN := V_RETURN || 'g';
  elsif V_COMPARE >= F_NLSSORT('妎 ') and V_COMPARE <= F_NLSSORT('夻 ') then
  V_RETURN := V_RETURN || 'h';
  elsif V_COMPARE >= F_NLSSORT('丌 ') and V_COMPARE <= F_NLSSORT('攈 ') then
  V_RETURN := V_RETURN || 'j';
  elsif V_COMPARE >= F_NLSSORT('咔 ') and V_COMPARE <= F_NLSSORT('穒 ') then
  V_RETURN := V_RETURN || 'k';
  elsif V_COMPARE >= F_NLSSORT('垃 ') and V_COMPARE <= F_NLSSORT('擽 ') then
  V_RETURN := V_RETURN || 'l';
  elsif V_COMPARE >= F_NLSSORT('嘸 ') and V_COMPARE <= F_NLSSORT('椧 ') then
  V_RETURN := V_RETURN || 'm';
  elsif V_COMPARE >= F_NLSSORT('拏 ') and V_COMPARE <= F_NLSSORT('瘧 ') then
  V_RETURN := V_RETURN || 'n';
  elsif V_COMPARE >= F_NLSSORT('筽 ') and V_COMPARE <= F_NLSSORT('漚 ') then
  V_RETURN := V_RETURN || 'o';
  elsif V_COMPARE >= F_NLSSORT('妑 ') and V_COMPARE <= F_NLSSORT('曝 ') then
  V_RETURN := V_RETURN || 'p';
  elsif V_COMPARE >= F_NLSSORT('七 ') and V_COMPARE <= F_NLSSORT('裠 ') then
  V_RETURN := V_RETURN || 'q';
  elsif V_COMPARE >= F_NLSSORT('亽 ') and V_COMPARE <= F_NLSSORT('鶸 ') then
  V_RETURN := V_RETURN || 'r';
  elsif V_COMPARE >= F_NLSSORT('仨 ') and V_COMPARE <= F_NLSSORT('蜶 ') then
  V_RETURN := V_RETURN || 's';
  elsif V_COMPARE >= F_NLSSORT('侤 ') and V_COMPARE <= F_NLSSORT('籜 ') then
  V_RETURN := V_RETURN || 't';
  elsif V_COMPARE >= F_NLSSORT('屲 ') and V_COMPARE <= F_NLSSORT('鶩 ') then
  V_RETURN := V_RETURN || 'w';
  elsif V_COMPARE >= F_NLSSORT('夕 ') and V_COMPARE <= F_NLSSORT('鑂 ') then
  V_RETURN := V_RETURN || 'x';
  elsif V_COMPARE >= F_NLSSORT('丫 ') and V_COMPARE <= F_NLSSORT('韻 ') then
  V_RETURN := V_RETURN || 'y';
  elsif V_COMPARE >= F_NLSSORT('帀 ') and V_COMPARE <= F_NLSSORT('咗 ') then
  V_RETURN := V_RETURN || 'z';
  else
    V_RETURN := V_RETURN ||substr(P_NAME, 0, 1);
end if;


return V_RETURN;

end;
/
UPDATE h_org_role SET corpId='main' WHERE roleType='SYS';

create unique index UQ_SCHEMACODE_CODE on h_biz_property (schemaCode, code);

alter table H_PERM_ADMIN add APPMANAGE NUMBER;

comment on column H_PERM_ADMIN.APPMANAGE is '是有拥有创建应用的权限';

alter table H_RELATED_CORP_SETTING add ENABLED NUMBER;

comment on column H_RELATED_CORP_SETTING.ENABLED is '是否禁用';

alter table H_ORG_USER add ENABLED NUMBER;

comment on column H_ORG_USER.ENABLED is '是否禁用';

alter table H_ORG_DEPARTMENT add ENABLED NUMBER;

comment on column H_ORG_DEPARTMENT.ENABLED is '是否禁用';

UPDATE H_RELATED_CORP_SETTING SET ENABLED = 1 WHERE ID != '';
UPDATE H_ORG_USER SET ENABLED = 1 WHERE ID != '';
UPDATE H_ORG_DEPARTMENT SET ENABLED = 1 WHERE ID != '';

create table h_biz_sheet_history(
    id                      varchar2(120)          not null
    primary key,
    createdTime             date                   null,
    creater                 varchar2(120)          null,
    deleted                 number(1, 0)           null,
    modifiedTime            date                   null,
    modifier                varchar2(120)          null,
    remarks                 varchar2(200)          null,
    code                    varchar2(40)           null,
    draftAttributesJson     CLOB                   null,
    draftViewJson           CLOB                   null,
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
    sheetType               varchar2(50)           null,
    sortKey                 int                    null,
    serialCode              varchar2(255)          null,
    serialResetType         varchar2(40)           null,
    externalLinkAble        number(1, 0) default 0 null,
    name_i18n               varchar2(1000)         null,
    draftHtmlJson           CLOB                   null,
    publishedHtmlJson       CLOB                   null,
    draftActionsJson        CLOB                   null,
    publishedActionsJson    CLOB                   null,
    shortCode               varchar2(50)           null,
    printTemplateJson       varchar2(1000)         null,
    qrCodeAble              varchar2(40)           null,
    tempAuthSchemaCodes     varchar2(3500)         null,
    borderMode              varchar2(10)           null,
    layoutType              varchar2(20)           null,
    formComment             number(1,0)            null,
    pdfAble                 varchar2(40)            null,
    publishBy               varchar2(120)           null,
    version                 number(20, 0) default 1 null
);

ALTER table h_biz_query_action add extend1 varchar(100) default null;

-- auto-generated definition
create table h_perm_selection_scope
(
    id varchar(128) default '' not null
        constraint H_PERM_SELECTION_SCOPE_PK
            primary key,
    createdTime date,
    creater varchar2(120),
    deleted number,
    modifiedTime date,
    modifier varchar2(120),
    remarks varchar2(200),
    departmentId varchar2(120),
    deptVisibleType varchar2(40),
    deptVisibleScope clob,
    staffVisibleType varchar2(40),
    staffVisibleScope clob
);


alter table H_ORG_ROLE_GROUP add parentId varchar(120);

comment on column H_ORG_ROLE_GROUP.parentId is '上一级角色组id';

/*==============================================================*/
/* Table: h_org_inc_sync_record                                 */
/*==============================================================*/
create table H_ORG_INC_SYNC_RECORD
(
    id varchar(128) default '' not null
        constraint H_ORG_INC_SYNC_RECORD_PK
            primary key,
    syncSourceType       char(10) default 'DINGTALK',
    createTime           date default CURRENT_TIMESTAMP,
    updateTime           date default CURRENT_TIMESTAMP ,
    corpId               varchar(120) default NULL ,
    eventType            varchar(50) default NULL ,
    eventInfo            CLOB ,
    handleStatus         varchar(20) default NULL ,
    retryCount           int default NULL
);
comment on table H_ORG_INC_SYNC_RECORD is '增量同步记录表';
comment on column H_ORG_INC_SYNC_RECORD.id is '主键';
comment on column H_ORG_INC_SYNC_RECORD.syncSourceType is '同步源类型，钉钉|企业微信 等 默认为钉钉';
comment on column H_ORG_INC_SYNC_RECORD.createTime is '创建时间';
comment on column H_ORG_INC_SYNC_RECORD.updateTime is '修改时间';
comment on column H_ORG_INC_SYNC_RECORD.corpId is '组织corpId';
comment on column H_ORG_INC_SYNC_RECORD.eventType is '钉钉回调事件类型';
comment on column H_ORG_INC_SYNC_RECORD.eventInfo is '事件数据';
comment on column H_ORG_INC_SYNC_RECORD.handleStatus is '处理状态';
comment on column H_ORG_INC_SYNC_RECORD.retryCount is '重试次数';


ALTER TABLE H_BUSINESS_RULE ADD ENABLED NUMBER(1);
ALTER TABLE H_BUSINESS_RULE ADD QUOTEPROPERTY CLOB;

comment on column H_BUSINESS_RULE.ENABLED is '是否生效';
comment on column H_BUSINESS_RULE.QUOTEPROPERTY is '引用编码 数据模型编码.数据项编码 ,分割';

update h_business_rule set enabled = 1 where enabled is null;


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
)
;

comment on column h_business_rule_runmap.id is '主键'
;

comment on column h_business_rule_runmap.ruleCode is '规则编码'
;

comment on column h_business_rule_runmap.ruleName is '规则名称'
;

comment on column h_business_rule_runmap.ruleType is '规则类型'
;

comment on column h_business_rule_runmap.nodeCode is '节点编码'
;

comment on column h_business_rule_runmap.nodeName is '节点名称'
;

comment on column h_business_rule_runmap.nodeType is '节点类型'
;

comment on column h_business_rule_runmap.targetSchemaCode is '目标对象模型编码'
;

comment on column h_business_rule_runmap.triggerSchemaCode is '触发对象模型编码'
;

alter table h_biz_service_category add createdBy varchar(120);
alter table h_biz_service_category add modifiedBy varchar(120);
alter table h_biz_datasource_category add createdBy varchar(120);
alter table h_biz_datasource_category add modifiedBy varchar(120);

alter table H_BIZ_PERM_PROPERTY add ENCRYPTVISIBLE NUMBER;

comment on column H_BIZ_PERM_PROPERTY.ENCRYPTVISIBLE is '是否可见加密';

UPDATE H_BIZ_PERM_PROPERTY SET ENCRYPTVISIBLE = 0 WHERE ID != '';

alter table H_BIZ_PROPERTY add ENCRYPTOPTION VARCHAR(40);

comment on column H_BIZ_PROPERTY.ENCRYPTOPTION is '加密类型';

alter table H_APP_PACKAGE
    add groupId varchar(120) ;

comment on column H_APP_PACKAGE.groupId is '应用分组id' ;

create table h_app_group (
  id varchar(120)
		constraint h_app_group_pk
			primary key,
  creater varchar2(120 byte) null ,
  createdtime date null ,
  deleted number(1) null ,
  modifier varchar2(120 byte) null ,
  modifiedtime date null ,
  remarks varchar2(200 byte) null ,
  code varchar2(40 byte) null ,
  disabled number(1) null ,
  name varchar2(50 byte) null ,
  sortkey number null ,
  name_i18n varchar2(1000 byte) null
);


INSERT INTO h_app_group (
 id, creater, createdtime, deleted, modifier, modifiedtime, remarks, code, disabled, name, sortkey, name_i18n
)
VALUES
	(
	'2c928fe6785dbfbb01785dc6277a0d0',
	NULL,
	TO_DATE( '2021-04-16 15:48:25', 'SYYYY-MM-DD HH24:MI:SS' ),
	'0',
	NULL,
	TO_DATE( '2021-04-16 15:48:36', 'SYYYY-MM-DD HH24:MI:SS' ),
	NULL,
	'default',
	NULL,
	'默认',
	'1',
NULL
	);

INSERT INTO h_app_group (
 id, creater, createdtime, deleted, modifier, modifiedtime, remarks, code, disabled, name, sortkey, name_i18n
)
VALUES
	(
	'2c928fe6785dbfbb01785dc6277a0d1',
	NULL,
	TO_DATE( '2021-04-26 15:48:25', 'SYYYY-MM-DD HH24:MI:SS' ),
	'0',
	NULL,
	TO_DATE( '2021-04-26 15:48:36', 'SYYYY-MM-DD HH24:MI:SS' ),
	NULL,
	'all',
	NULL,
	'全部',
	'0',
NULL
	);

update h_app_package set groupId='2c928fe6785dbfbb01785dc6277a0000' where groupId is null or groupId='';

-- auto-generated definition
create table H_ORG_DIRECT_MANAGER
(
    ID             VARCHAR2(120) not null
        constraint H_ORG_DIRECT_MANAGER_PK
            primary key,
    createdTime  DATE default current_timestamp,
    CREATER        VARCHAR2(120),
    modifiedTime DATE,
    MODIFIER       VARCHAR2(120),
    REMARKS        VARCHAR2(200),
    userId       VARCHAR2(36)  not null,
    deptId       VARCHAR2(36)  not null,
    managerId    VARCHAR2(36)  not null
)
;

comment on table H_ORG_DIRECT_MANAGER is '直属主管配置表'
;

comment on column H_ORG_DIRECT_MANAGER.createdTime is '创建时间'
;

comment on column H_ORG_DIRECT_MANAGER.CREATER is '创建人'
;

comment on column H_ORG_DIRECT_MANAGER.modifiedTime is '修改时间'
;

comment on column H_ORG_DIRECT_MANAGER.MODIFIER is '修改人'
;

comment on column H_ORG_DIRECT_MANAGER.REMARKS is '备注'
;

comment on column H_ORG_DIRECT_MANAGER.userId is '用户编号'
;

comment on column H_ORG_DIRECT_MANAGER.deptId is '部门编号'
;

comment on column H_ORG_DIRECT_MANAGER.managerId is '直属主管编号'
;

create unique index UQ_DIRECT_USER_DEPT
    on H_ORG_DIRECT_MANAGER (userId, deptId)
;

ALTER TABLE H_BIZ_SHEET ADD printJson CLOB;

comment on column H_BIZ_SHEET.printJson is '打印模板json' ;


alter table h_biz_property add options clob;

comment on column h_biz_property.options is '数据项属性' ;

create table h_biz_data_rule (
  id varchar(120)
		constraint h_biz_data_rule_pk
			primary key,
  creater varchar2(120)  ,
  createdtime date  ,
  deleted number(1)  ,
  modifier varchar2(120)  ,
  modifiedtime date  ,
  remarks varchar2(200)  ,
  schemaCode varchar2(40)  ,
  propertyCode varchar2(40)  ,
  options CLOB  ,
  dataRuleType varchar2(40)  ,
  checkType number(1)
);

alter table h_biz_export_task add refId varchar(200);

comment on column h_biz_export_task.refId is '附件id';

alter table h_biz_export_task add schemaCode varchar(200);

comment on column h_biz_export_task.schemaCode is '数据模型编码';

alter table h_biz_export_task add expireTime date;

comment on column h_biz_export_task.expireTime is '过期时间';

ALTER TABLE H_BIZ_SHEET ADD formTrack NUMBER(1);

comment on column H_BIZ_SHEET.formTrack is '是否开启表单留痕' ;

ALTER TABLE H_BIZ_SHEET ADD trackDataCodes CLOB;

comment on column H_BIZ_SHEET.trackDataCodes is '需要留痕的表单数据项code,用 ; 号分割' ;

update H_BIZ_SHEET set formTrack = 0 where formTrack is null or formTrack = '';

ALTER TABLE H_BIZ_SHEET_HISTORY ADD formTrack NUMBER(1);

comment on column H_BIZ_SHEET_HISTORY.formTrack is '是否开启表单留痕' ;

ALTER TABLE H_BIZ_SHEET_HISTORY ADD trackDataCodes CLOB;

comment on column H_BIZ_SHEET_HISTORY.trackDataCodes is '需要留痕的表单数据项code,用 ; 号分割' ;

update H_BIZ_SHEET_HISTORY set formTrack = 0 where formTrack is null or formTrack = '';

ALTER TABLE H_PERM_ADMIN ADD dataDictionaryManage NUMBER(1);

comment on column H_PERM_ADMIN.dataDictionaryManage is '是否有数据字典管理权限' ;

update H_PERM_ADMIN set dataDictionaryManage = 0 where dataDictionaryManage is null or dataDictionaryManage ='';

create table h_data_dictionary (
  id varchar2(120)
        constraint h_data_dictionary_pk
			primary key,
  createdTime date,
  creater varchar2(120),
  deleted number(1) ,
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
  name varchar2(50),
  code varchar2(50),
  dictionaryType varchar2(40) ,
  sortKey number(11) ,
  status number(1),
  classificationId varchar2(120)
) ;

create table h_dictionary_class (
  id varchar2(120)
        constraint h_dictionary_class_pk
			primary key,
  createdTime date,
  creater varchar2(120),
  deleted number(1) ,
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
  name varchar2(50),
  sortKey number(11)
);

CREATE TABLE h_dictionary_record (
  id varchar2(120)
          constraint h_dictionary_record_pk
			primary key,
  createdTime date,
  creater varchar2(120) ,
  deleted number(1) ,
  modifiedTime date ,
  modifier varchar2(120) ,
  remarks varchar2(200) ,
  name varchar2(50) ,
  code varchar2(50) ,
  dictionaryId varchar2(120) ,
  sortKey number(11) ,
  parentId varchar2(120) ,
  status number(1),
  initialUsed number(1)
);

create table h_biz_data_track (
  id varchar2(120)
          constraint h_biz_data_track_pk
			primary key,
  createdTime date,
  creater varchar2(120),
  deleted number(1),
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
  title varchar2(200),
  bizObjectId varchar2(120),
  departmentId varchar2(120),
  departmentName varchar2(50),
  creatorName varchar2(50),
  schemaCode varchar2(40),
  sheetCode varchar2(40)
);

create table h_biz_data_track_detail (
  id varchar2(120)
          constraint h_biz_data_track_detail_pk
			primary key,
  createdTime date ,
  creater varchar2(120) ,
  deleted number(1) ,
  modifiedTime date ,
  modifier varchar2(120) ,
  remarks varchar2(200) ,
  trackId varchar2(120) ,
  bizObjectId varchar2(120) ,
  name varchar2(50) ,
  beforeValue CLOB ,
  afterValue CLOB ,
  type varchar2(40),
  departmentName varchar2(50),
  creatorName varchar2(50)
);



ALTER TABLE H_BIZ_SHEET ADD formSystemVersion varchar2(32);

comment on column H_BIZ_SHEET.formSystemVersion is '系统版本号' ;

ALTER TABLE H_BIZ_SHEET ADD draftSchemaOptionsJson CLOB;


alter table H_BIZ_PERM_GROUP add appPermGroupId varchar2(120) ;

comment on column H_BIZ_PERM_GROUP.appPermGroupId is '关联的应用管理权限组ID';

create table h_perm_admin_group (
  id varchar(120)
		constraint h_perm_admin_group_pk
			primary key,
  creater varchar2(120 byte)  ,
  createdtime date  ,
  deleted number(1)  ,
  modifier varchar2(120 byte)  ,
  modifiedtime date  ,
  remarks varchar2(200 byte)  ,
  departmentsJson CLOB  ,
  appPackagesJson CLOB  ,
  name varchar2(50 byte)  ,
  adminId varchar(120)
  );

  ALTER TABLE h_perm_admin ADD roleManage NUMBER(1);
  comment ON COLUMN h_perm_admin.roleManage IS '角色管理权限';
  UPDATE h_perm_admin SET roleManage = 1 WHERE adminType IN ('SYS_MNG', 'ADMIN');

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


create table h_report_datasource_permission
(
	id varchar(36) primary key,
   creater              varchar2(120),
   createdTime          date,
   modifier             varchar2(120) ,
   modifiedTime         date,
   remarks              varchar2(256),
   objectId             varchar2(64),
   userScope            CLOB,
   ownerId              varchar2(32),
   nodeType             number(1)
);

create unique index uq_object_id
	on h_report_datasource_permission (objectId);


ALTER TABLE h_biz_datasource_method ADD  shared NUMBER(1) ;
ALTER TABLE h_biz_datasource_method ADD  userIds CLOB;

-- 6.6
create table h_user_common_comment (
  id varchar(36) primary key,
  createdTime date,
  creater varchar2(120),
  deleted NUMBER(1),
  modifiedTime date,
  modifier varchar2(120),
  remarks varchar2(200),
	content CLOB,
	sortKey number(11),
  userId varchar2(36)
  );

  -- 6.7
  CREATE TABLE h_system_notify_setting (
  id varchar(36) primary key,
  corpId varchar2(120),
  unitType varchar2(20),
  msgChannelType varchar2(20)
);

-- 批量向模型表中添加version字段
-- 1.创建
create  or replace procedure addVersionParam(vUser in varchar2) as
begin
    declare
        cursor csr is select  table_name from all_tables where owner = upper(vUser) and lower(table_name) like 'i%';
        vSchemaCode VARCHAR(200);
        nCount4 number;
        nCount3 number;
        nCount number;
        v_sql varchar2(1000);
    begin
        for row_table_name in csr loop
--                dbms_output.put_line('table_name ---> '||row_table_name.table_name);
                vSchemaCode := SUBSTR(row_table_name.table_name, INSTR(row_table_name.table_name, '_',1,1) + 1,LENGTH(row_table_name.table_name)) ;
                -- 判断是否为模型相关表
--                dbms_output.put_line('schemaCode by spit ---> '||vSchemaCode);
                SELECT count(*) into nCount4 FROM h_biz_schema where LOWER(code) = LOWER(vSchemaCode);
                if nCount4>0 then
                    SELECT count(*) into nCount3 FROM ALL_TAB_COLUMNS WHERE owner = UPPER(vUser) and TABLE_NAME = row_table_name.table_name  and column_name = 'version';
                    SELECT code into vSchemaCode FROM h_biz_schema where LOWER(code) = LOWER(vSchemaCode);
--					dbms_output.put_line('schemaCode in table ---> '||vSchemaCode);
					if nCount3=0 then
--                        dbms_output.put_line('version not exist');
                        v_sql := 'ALTER TABLE "'||vUser||'"."'||row_table_name.table_name||'" ADD ("version" NUMBER(20,8) DEFAULT 0)';
--                        dbms_output.put_line('exec sql start--->'||v_sql);
                        execute immediate v_sql;
                        v_sql :='COMMENT ON COLUMN "'||vUser||'"."'||row_table_name.table_name||'"."version" is ''版本号''';
--                        dbms_output.put_line('exec sql start--->'||v_sql);
                        execute immediate v_sql;
                    end if;
                    select count(*) into nCount from h_biz_property where schemaCode = vSchemaCode and code = 'version';
                    if nCount=0 then
                        v_sql := 'INSERT INTO h_biz_property (id, createdTime, creater, deleted, modifiedTime, code,
                                                      defaultProperty, defaultValue, name, propertyEmpty,
                                                      propertyIndex, propertyLength, propertyType, published,
                                                      relativeCode, schemaCode, repeated)
                        VALUES (LOWER(sys_guid()), sysdate, NULL, 0,sysdate,'||'''version'', 1, 0, ''版本号'', 0,
                                0, 12, ''NUMERICAL'', 1, NULL,'''||vSchemaCode||''', 0)';
--                        dbms_output.put_line('exec sql start--->'||v_sql);
                        execute immediate v_sql;

                    end if;
--                    dbms_output.put_line('exec sql end <---');
                end if;
            end loop;
    end;
end addVersionParam;
/

-- 2.执行!!!!!!输入库所属用户名 （获取当前用户 select username from user_users）
call addVersionParam('TEST');

-- 3.删除
drop procedure  addVersionParam;

ALTER TABLE h_biz_database_pool ADD datasourceType varchar2(40);
UPDATE h_biz_database_pool SET datasourceType = 'DATABASE';
ALTER TABLE h_biz_database_pool ADD externInfo CLOB;

ALTER TABLE h_related_corp_setting ADD syncConfig varchar2(2048) null;

ALTER TABLE h_related_corp_setting ADD customizeRelateType varchar2(64) null;

ALTER TABLE h_related_corp_setting ADD mailListConfig varchar2(2048) null;

ALTER TABLE h_report_datasource_permission ADD parentObjectId varchar2(64) null;

create index idx_type_ac on h_app_function (type, appCode);

CREATE INDEX idx_h_biz_attachment_refid ON h_biz_attachment ( refid );

CREATE INDEX idx_workflow_template_c_v ON h_workflow_template ( workflowCode, workflowVersion );

CREATE INDEX idx_biz_query_column_q_s ON h_biz_query_column ( queryId, sortKey );

CREATE INDEX idx_biz_query_condition_q_s ON h_biz_query_condition ( queryId, sortKey );

CREATE INDEX idx_org_user_username_corpid ON h_org_user ( username, corpId );

alter table h_user_favorites modify bizObjectType varchar2(40);

alter table h_user_favorites modify appCode varchar2(512);

alter table h_perm_admin_group ADD externalLinkVisible NUMBER(1,0) DEFAULT (1) NOT NULL ;
comment ON COLUMN h_perm_admin_group.externalLinkVisible IS '是否可查看外链';

ALTER TABLE H_APP_PACKAGE ADD FROMAPPMARKET NUMBER(1,0);
comment ON COLUMN H_APP_PACKAGE.FROMAPPMARKET IS '是否来自应用市场';

-- 视图多模型查询
ALTER TABLE h_biz_query_present ADD (queryViewDataSource CLOB DEFAULT NULL);
comment on column h_biz_query_present.queryViewDataSource is '视图属性-数据源';
ALTER TABLE h_biz_query_present ADD (schemaRelations CLOB DEFAULT NULL);
comment on column h_biz_query_present.schemaRelations is '视图多模型查询，关联关系';

ALTER TABLE h_biz_query_column ADD (schemaAlias VARCHAR2(100 BYTE) DEFAULT NULL);
comment on column h_biz_query_column.schemaAlias is '模型编码别名';
ALTER TABLE h_biz_query_column ADD (propertyAlias VARCHAR2(100 BYTE) DEFAULT NULL);
comment on column h_biz_query_column.propertyAlias is '数据项编码别名';
ALTER TABLE h_biz_query_column ADD (queryLevel NUMBER);
comment on column h_biz_query_column.queryLevel is '查询批次 1-主表 2-子表';

update h_biz_query_column set schemaAlias = schemaCode where schemaAlias is null ;
update h_biz_query_column set propertyAlias = propertyCode where propertyAlias is null;

alter table h_open_api_event add options clob;
comment on column h_open_api_event.options is '扩展参数';

alter table h_biz_datasource_method add inputParamConfig clob;

alter table BIZ_WORKFLOW_INSTANCE add source varchar2(255);
comment on column BIZ_WORKFLOW_INSTANCE.source is '来源';

alter table BIZ_WORKFLOW_INSTANCE_BAK add source varchar2(255);
comment on column BIZ_WORKFLOW_INSTANCE_BAK.source is '来源';

-- 6.1版本遗漏了
alter table H_BIZ_METHOD_MAPPING	add businessRuleId varchar(40);
comment on column H_BIZ_METHOD_MAPPING.businessRuleId is '关联的业务规则id';
alter table H_BIZ_METHOD_MAPPING	add nodeCode varchar(40);
comment on column H_BIZ_METHOD_MAPPING.nodeCode is '关联的业务规则节点';

create table H_WORKFLOW_ADMIN
(
  ID           VARCHAR2(120) not null,
  CREATER      VARCHAR2(120),
  CREATEDTIME  DATE,
  DELETED      NUMBER(1),
  MODIFIER     VARCHAR2(120),
  MODIFIEDTIME DATE,
  REMARKS      VARCHAR2(200),
  ADMINTYPE    VARCHAR2(120),
  WORKFLOWCODE VARCHAR2(200),
  MANAGESCOPE  VARCHAR2(512),
  OPTIONS      CLOB
);
create index IDX_WORKFLOW_ADMIN_CODE on H_WORKFLOW_ADMIN (WORKFLOWCODE);

create table H_WORKFLOW_ADMIN_SCOPE
(
  ID           VARCHAR2(120) not null,
  CREATER      VARCHAR2(120),
  CREATEDTIME  DATE,
  DELETED      NUMBER(1),
  MODIFIER     VARCHAR2(120),
  MODIFIEDTIME DATE,
  REMARKS      VARCHAR2(200),
  ADMINID      VARCHAR2(120),
  UNITTYPE     VARCHAR2(120),
  UNITID       VARCHAR2(36)
);
create index IDX_WORKFLOW_ADMINID on H_WORKFLOW_ADMIN_SCOPE (ADMINID);

alter table BIZ_WORKITEM add WORKITEMSOURCE varchar2(120);
comment on column BIZ_WORKITEM.WORKITEMSOURCE is '任务来源';

alter table BIZ_WORKITEM_FINISHED add WORKITEMSOURCE varchar2(120);
comment on column BIZ_WORKITEM_FINISHED.WORKITEMSOURCE is '任务来源';

alter table H_BIZ_SCHEMA add MODELTYPE varchar2(120);
comment on column H_BIZ_SCHEMA.MODELTYPE is '模型类型 LIST/TREE';

CREATE TABLE h_system_sms_template (
    id varchar2(120) NOT NULL primary key,
    type varchar2(20) NOT NULL,
    code varchar2(20) NOT NULL,
    name varchar2(40) NOT NULL,
    content CLOB NOT NULL,
    params CLOB DEFAULT NULL,
    enabled NUMBER(1) DEFAULT NULL,
    defaults NUMBER(1) DEFAULT NULL,
    remarks varchar2(200) DEFAULT NULL,
    deleted NUMBER(1) DEFAULT NULL,
    creater varchar2(120) DEFAULT NULL,
    createdTime date DEFAULT NULL,
    modifier varchar2(120) DEFAULT NULL,
    modifiedTime date DEFAULT NULL
);

INSERT INTO h_system_sms_template VALUES ('2c928ff67de11137017de119dec601c2', 'TODO', 'Todo', '默认待办通知', '您有新的流程待处理，流程标题：${name}，请及时处理！', '[{\"key\":\"name\",\"value\":\"\"}]', 1, 1, NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO h_system_sms_template VALUES ('2c928ff67de11137017de11d5b3001c4', 'URGE', 'Remind', '默认催办通知', '您的流程任务被人催办，流程标题：${name}，催办人${creater}，请及时处理！', '[{\"key\":\"name\",\"value\":\"流程的标题\"},{\"key\":\"creater\",\"value\":\"流程发起人\"}]', 1, 1, NULL, 0, NULL, NULL, NULL, NULL);

INSERT INTO h_system_setting VALUES ('c82a2b8d5d5c11ecb2370242ac110005', 'sms.todo.switch', 'false', 'SMS_CONF', 1, null);
INSERT INTO h_system_setting VALUES ('c82d39a85d5c11ecb2370242ac110006', 'sms.urge.switch', 'false', 'SMS_CONF', 1, null);

ALTER TABLE h_im_message ADD (smsParams CLOB null);
ALTER TABLE h_im_message ADD (smsCode varchar2(50) null);

ALTER TABLE h_im_message_history ADD (smsParams CLOB null);
ALTER TABLE h_im_message_history ADD (smsCode varchar2(50) null);

ALTER TABLE h_biz_export_task ADD (fileSize int NULL);


alter table h_system_pair add objectId varchar2(120);
comment on column h_system_pair.objectId is '数据id';

alter table h_system_pair add schemaCode varchar2(40);
comment on column h_system_pair.schemaCode is '模型编码';

alter table h_system_pair add formCode varchar2(40);
comment on column h_system_pair.formCode is '表单编码';

alter table h_system_pair add workflowInstanceId varchar2(120);
comment on column h_system_pair.workflowInstanceId is '流程实例ID';

CREATE INDEX "idx_bid_fcode" ON  H_SYSTEM_PAIR (OBJECTID, FORMCODE);

