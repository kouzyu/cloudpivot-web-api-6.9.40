create table base_security_client
(
    id                          nvarchar(120) not null
        primary key,
    createdTime                 datetime,
    creater                     nvarchar(120),
    deleted                     bit,
    extend1                     nvarchar(255),
    extend2                     nvarchar(255),
    extend3                     nvarchar(255),
    extend4                     int,
    extend5                     int,
    modifiedTime                datetime,
    modifier                    nvarchar(120),
    remarks                     nvarchar(200),
    accessTokenValiditySeconds  int           not null,
    additionInformation         nvarchar(255),
    authorities                 nvarchar(255),
    authorizedGrantTypes        nvarchar(255),
    autoApproveScopes           nvarchar(255),
    clientId                    nvarchar(100),
    clientSecret                nvarchar(100),
    refreshTokenValiditySeconds int           not null,
    registeredRedirectUris      nvarchar(2000),
    resourceIds                 nvarchar(255),
    scopes                      nvarchar(255),
    type                        nvarchar(10)
)
go

create table biz_circulateitem
(
    id                nvarchar(36)     not null
        primary key,
    finishTime        datetime,
    receiveTime       datetime,
    startTime         datetime,
    state             nvarchar(20),
    activityCode      nvarchar(200),
    activityCodeName  nvarchar(200),
    instanceId        nvarchar(36),
    instanceName      nvarchar(200),
    originator        nvarchar(200),
    originatorName    nvarchar(200),
    participant       nvarchar(200),
    participantName   nvarchar(200),
    sheetCode         nvarchar(200),
    sourceId          nvarchar(200),
    sourceName        nvarchar(200),
    workflowCode      nvarchar(36),
    workflowVersion   int,
    activityName      nvarchar(200),
    departmentId      nvarchar(200),
    departmentName    nvarchar(200),
    workItemType      nvarchar(20),
    workflowTokenId   nvarchar(200),
    stateValue        int,
    workItemTypeValue int,
    expireTime1       datetime,
    expireTime2       datetime,
    appCode           nvarchar(200),
    allowedTime       datetime,
    timeoutWarn1      datetime,
    timeoutWarn2      datetime,
    timeoutStrategy   nvarchar(20),
    usedtime          bigint,
    sortKey           bigint default 0 not null
)
go

create index idx_multi
    on biz_circulateitem (instanceId, activityCode, workflowTokenId, participant)
go

create index idx_participant
    on biz_circulateitem (participant)
go

create index idx_sourceIdAndType
    on biz_circulateitem (sourceId, workItemType)
go

create index idx_startTime
    on biz_circulateitem (startTime)
go

create index idx_workflowTokenId
    on biz_circulateitem (workflowTokenId)
go

create table biz_circulateitem_finished
(
    finishTime        datetime,
    receiveTime       datetime,
    startTime         datetime,
    state             nvarchar(20),
    activityCode      nvarchar(200),
    delegant          nvarchar(200),
    instanceId        nvarchar(36),
    originator        nvarchar(200),
    participant       nvarchar(200),
    sheetCode         nvarchar(200),
    sourceWorkItemId  nvarchar(200),
    workflowCode      nvarchar(36),
    workflowVersion   int,
    id                nvarchar(36)     not null,
    activityName      nvarchar(200),
    departmentId      nvarchar(200),
    departmentName    nvarchar(200),
    instanceName      nvarchar(200),
    originatorName    nvarchar(200),
    participantName   nvarchar(200),
    sourceId          nvarchar(200),
    sourceName        nvarchar(200),
    workItemType      nvarchar(20),
    workflowTokenId   nvarchar(200),
    stateValue        int,
    workItemTypeValue int,
    expireTime1       datetime,
    expireTime2       datetime,
    appCode           nvarchar(200),
    allowedTime       datetime,
    timeoutWarn1      datetime,
    timeoutWarn2      datetime,
    timeoutStrategy   nvarchar(20),
    usedtime          bigint,
    sortKey           bigint default 0 not null
)
go

create index idx_finishTime
    on biz_circulateitem_finished (finishTime)
go

create index idx_multi
    on biz_circulateitem_finished (instanceId, activityCode, workflowTokenId, participant)
go

create index idx_participant
    on biz_circulateitem_finished (participant)
go

create index idx_sourceIdAndType
    on biz_circulateitem_finished (sourceId, workItemType)
go

create index idx_workflowTokenId
    on biz_circulateitem_finished (workflowTokenId)
go

create table biz_workflow_instance
(
    id               nvarchar(36)                  not null
        primary key,
    bizObjectId      nvarchar(36),
    instanceName     nvarchar(200),
    workflowCode     nvarchar(200),
    workflowVersion  int,
    originator       nvarchar(200),
    departmentId     nvarchar(200),
    participant      nvarchar(200),
    state            nvarchar(200),
    receiveTime      datetime,
    startTime        datetime,
    finishTime       datetime,
    usedTime         bigint,
    waitTime         bigint,
    remark           nvarchar(200),
    departmentName   nvarchar(200),
    originatorName   nvarchar(200),
    parentId         nvarchar(36),
    stateValue       int,
    workflowTokenId  nvarchar(36),
    appCode          nvarchar(200),
    sheetBizObjectId nvarchar(36),
    sheetSchemaCode  nvarchar(64),
    sequenceNo       nvarchar(200),
    trustee          nvarchar(42),
    trusteeName      nvarchar(80),
    trustType        nvarchar(20),
    schemaCode       nvarchar(40),
    dataType         nvarchar(20) default 'NORMAL' not null,
    runMode          nvarchar(20) default 'MANUAL' not null
)
go

create index idx_bwi_originator
    on biz_workflow_instance (originator)
go

create index idx_bwi_originator_state_starttime
    on biz_workflow_instance (originator, state, startTime)
go

create index idx_bwi_startTime
    on biz_workflow_instance (startTime)
go

create index idx_bwi_workflowCode
    on biz_workflow_instance (workflowCode)
go

create index idx_state
    on biz_workflow_instance (state)
go

create table biz_workflow_instance_bak
(
    id               varchar(36) not null
        primary key,
    finishTime       datetime,
    receiveTime      datetime,
    startTime        datetime,
    appCode          varchar(200),
    bizObjectId      varchar(36),
    dataType         varchar(20),
    departmentId     varchar(200),
    departmentName   varchar(200),
    instanceName     varchar(200),
    originator       varchar(200),
    originatorName   varchar(200),
    parentId         varchar(36),
    remark           varchar(200),
    runMode          varchar(20),
    schemaCode       varchar(40),
    sequenceNo       varchar(200),
    sheetBizObjectId varchar(36),
    sheetSchemaCode  varchar(64),
    state            varchar(20),
    trustType        varchar(20),
    trustee          varchar(42),
    trusteeName      varchar(80),
    usedTime         numeric(19),
    waitTime         numeric(19),
    workflowCode     varchar(200),
    workflowTokenId  varchar(36),
    workflowVersion  int,
    backupTime       datetime
)
go

create index idx_state
    on biz_workflow_instance_bak (state)
go

create index idx_bwi_startTime
    on biz_workflow_instance_bak (startTime)
go

create index idx_bwi_originator
    on biz_workflow_instance_bak (originator)
go

create index idx_bwi_workflowCode
    on biz_workflow_instance_bak (workflowCode)
go

create index idx_bwi_originator_state_starttime
    on biz_workflow_instance_bak (originator, state, startTime)
go

create table biz_workflow_token
(
    id                 nvarchar(36)      not null
        primary key,
    finishTime         datetime,
    receiveTime        datetime,
    startTime          datetime,
    state              nvarchar(20),
    activityCode       nvarchar(200),
    approvalCount      int,
    disapprovalCount   int,
    exceptional        nvarchar(20),
    instanceId         nvarchar(36),
    itemCount          int,
    tokenId            int,
    usedtime           bigint,
    sourceActivityCode nvarchar(200),
    isRetrievable      int,
    stateValue         int,
    parentId           nvarchar(36),
    isRejectBack       nvarchar(10),
    activityType       nvarchar(20),
    instanceState      nvarchar(20),
    approvalExit       nvarchar(20),
    isSkipped          tinyint default 0 not null
)
go

create index idx_instanceId
    on biz_workflow_token (instanceId)
go

create table biz_workitem
(
    id                nvarchar(36)            not null
        primary key,
    workflowCode      nvarchar(200),
    workflowVersion   int,
    originator        nvarchar(200),
    participant       nvarchar(200),
    approval          nvarchar(200),
    sheetCode         nvarchar(200),
    instanceId        nvarchar(36),
    startTime         datetime,
    finishTime        datetime,
    state             nvarchar(36),
    receiveTime       datetime,
    activityCode      nvarchar(200),
    usedTime          bigint,
    remark            nvarchar(200),
    ownerId           nvarchar(200) default '',
    activityName      nvarchar(200),
    departmentId      nvarchar(200),
    departmentName    nvarchar(200),
    instanceName      nvarchar(200),
    originatorName    nvarchar(200),
    participantName   nvarchar(200),
    sourceId          nvarchar(200),
    sourceName        nvarchar(200),
    workItemType      nvarchar(20),
    workflowTokenId   nvarchar(200),
    stateValue        int,
    workItemTypeValue int,
    approvalValue     int,
    expireTime1       datetime,
    expireTime2       datetime,
    appCode           nvarchar(200),
    allowedTime       datetime,
    timeoutWarn1      datetime,
    timeoutWarn2      datetime,
    timeoutStrategy   nvarchar(20),
    isTrust           tinyint       default 0 not null,
    trustor           nvarchar(42),
    trustorName       nvarchar(80),
    batchOperate      tinyint       default 0 not null,
    rootTaskId        nvarchar(42),
    sourceTaskId      nvarchar(42),
    sortKey           bigint        default 0 not null
)
go

create index I_ReceiveTime
    on biz_workitem (receiveTime)
go

create index idx_multi
    on biz_workitem (instanceId, activityCode, workflowTokenId, participant)
go

create index idx_participant
    on biz_workitem (participant)
go

create index idx_sourceIdAndType
    on biz_workitem (sourceId, workItemType)
go

create index idx_startTime
    on biz_workitem (startTime)
go

create index idx_workflowTokenId
    on biz_workitem (workflowTokenId)
go

create table biz_workitem_finished
(
    id                nvarchar(36)            not null
        primary key,
    workflowCode      nvarchar(200),
    workflowVersion   int,
    originator        nvarchar(200),
    participant       nvarchar(200),
    approval          nvarchar(200),
    sheetCode         nvarchar(200),
    instanceId        nvarchar(36),
    startTime         datetime,
    finishTime        datetime,
    state             nvarchar(36),
    receiveTime       datetime,
    activityCode      nvarchar(200),
    usedTime          bigint,
    remark            nvarchar(200),
    ownerId           nvarchar(200) default '',
    activityName      nvarchar(200),
    departmentId      nvarchar(200),
    departmentName    nvarchar(200),
    instanceName      nvarchar(200),
    originatorName    nvarchar(200),
    participantName   nvarchar(200),
    sourceId          nvarchar(200),
    sourceName        nvarchar(200),
    workItemType      nvarchar(20),
    workflowTokenId   nvarchar(200),
    stateValue        int,
    workItemTypeValue int,
    approvalValue     int,
    expireTime1       datetime,
    expireTime2       datetime,
    appCode           nvarchar(200),
    allowedTime       datetime,
    timeoutWarn1      datetime,
    timeoutWarn2      datetime,
    timeoutStrategy   nvarchar(20),
    isTrust           tinyint       default 0 not null,
    trustor           nvarchar(42),
    trustorName       nvarchar(80),
    batchOperate      tinyint       default 0 not null,
    rootTaskId        nvarchar(42),
    sourceTaskId      nvarchar(42),
    sortKey           bigint        default 0 not null
)
go

create index I_ReceiveTime
    on biz_workitem_finished (receiveTime)
go

create index idx_finishTime
    on biz_workitem_finished (finishTime)
go

create index idx_multi
    on biz_workitem_finished (instanceId, activityCode, workflowTokenId, participant)
go

create index idx_participant
    on biz_workitem_finished (participant)
go

create index idx_sourceIdAndType
    on biz_workitem_finished (sourceId, workItemType)
go

create index idx_workflowTokenId
    on biz_workitem_finished (workflowTokenId)
go

create table d_process_instance
(
    id                nvarchar(42)  not null
        primary key,
    processCode       nvarchar(120) not null,
    originator        nvarchar(64)  not null,
    title             nvarchar(64),
    url               nvarchar(255) not null,
    processInstanceId nvarchar(64)  not null,
    wfInstanceId      nvarchar(64)  not null,
    formComponents    ntext,
    status            nvarchar(42),
    result            nvarchar(42),
    createTime        datetime,
    requestId         nvarchar(42),
    wfWorkItemId      nvarchar(64),
    bizProcessStatus  nvarchar(64)
)
go

create table d_process_task
(
    id                nvarchar(42) not null
        primary key,
    processInstanceId nvarchar(64) not null,
    taskId            bigint       not null,
    userId            nvarchar(64) not null,
    url               nvarchar(255),
    wfWorkItemId      nvarchar(42) not null,
    wfInstanceId      nvarchar(42) not null,
    status            nvarchar(64),
    result            nvarchar(64),
    createTime        datetime,
    requestId         nvarchar(42),
    bizProcessStatus  nvarchar(64)
)
go

create table d_process_template
(
    id               nvarchar(42)  not null
        primary key,
    tempCode         nvarchar(64)  not null
        constraint IDX_UNIQUE_TEMP_CODE
            unique,
    processCode      nvarchar(120) not null,
    processName      nvarchar(64)  not null,
    agentId          decimal(18)   not null,
    formField        ntext,
    createTime       datetime,
    requestId        nvarchar(42),
    bizProcessStatus nvarchar(64),
    queryId          nvarchar(42)
)
go

create table h_access_token
(
    id          nvarchar(40) not null
        primary key,
    userId      nvarchar(40),
    leastUse    tinyint,
    accessToken nvarchar(2000),
    createTime  datetime
)
go

create index idx_access_token_userId
    on h_access_token (userId)
go

create table h_app_function
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    appCode      nvarchar(40),
    code         nvarchar(40)
        constraint UK_hs5vdc0sdojwxfkv685ch9bqb
            unique,
    icon         nvarchar(50),
    name         nvarchar(50),
    parentId     nvarchar(36),
    sortKey      int,
    type         nvarchar(40),
    name_i18n    nvarchar(1000),
    pcAble       bit default 1,
    mobileAble   bit default 1
)
go

create table h_app_package
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    code         nvarchar(40),
    disabled     bit,
    logoUrlId    nvarchar(36),
    name         nvarchar(50),
    sortKey      int,
    published    bit,
    agentId      nvarchar(40),
    logoUrl      nvarchar(200),
    appKey       nvarchar(200),
    appSecret    nvarchar(200),
    enabled      bit,
    name_i18n    nvarchar(1000),
    appNameSpace nvarchar(40)
)
go

create table h_biz_attachment
(
    id                nvarchar(120) not null
        primary key,
    bizObjectId       nvarchar(36)  not null,
    bizPropertyCode   nvarchar(40)  not null,
    createdTime       datetime,
    creater           nvarchar(36),
    fileExtension     nvarchar(30),
    fileSize          int,
    base64ImageStr    ntext,
    mimeType          nvarchar(50),
    name              nvarchar(200),
    parentBizObjectId nvarchar(36) default '',
    parentSchemaCode  nvarchar(36),
    refId             nvarchar(500) not null,
    schemaCode        nvarchar(36)  not null
)
go

create index idx_biz_attachment_schema_object_property
    on h_biz_attachment (schemaCode, bizObjectId, bizPropertyCode, createdTime)
go

create index idx_h_biz_attachment_bizObjectId
    on h_biz_attachment (bizObjectId)
go

create index idx_h_biz_attachment_parentBizObjectId
    on h_biz_attachment (parentBizObjectId)
go

create table h_biz_comment
(
    id                 nvarchar(120) not null
        primary key,
    actionType         nvarchar(40)  not null,
    activityCode       nvarchar(40),
    activityName       nvarchar(40),
    bizObjectId        nvarchar(36)  not null,
    bizPropertyCode    nvarchar(40),
    content            nvarchar(4000),
    createdTime        datetime,
    creater            nvarchar(36),
    modifiedTime       datetime,
    modifier           nvarchar(36),
    relUsers           nvarchar(2000),
    result             nvarchar(40),
    schemaCode         nvarchar(40)  not null,
    workItemId         nvarchar(36)  not null,
    workflowInstanceId nvarchar(36)  not null,
    workflowTokenId    nvarchar(36)  not null,
    tokenId            int
)
go

create index idx_biz_comment_workItemId_actionType
    on h_biz_comment (workItemId, actionType)
go

create index idx_biz_comment_workflowInstanceId
    on h_biz_comment (workflowInstanceId)
go

create table h_biz_database_pool
(
    id              nvarchar(120) not null
        primary key,
    creater         nvarchar(120),
    createdTime     datetime,
    deleted         bit,
    modifier        nvarchar(120),
    modifiedTime    datetime,
    remarks         nvarchar(200),
    code            nvarchar(40)  not null,
    name            nvarchar(50)  not null,
    description     nvarchar(2000),
    databaseType    nvarchar(15)  not null,
    driverClassName nvarchar(50),
    jdbcUrl         nvarchar(200),
    username        nvarchar(40),
    password        nvarchar(300)
)
go

create table h_biz_datasource_category
(
    id           nvarchar(128)            not null
        primary key,
    createdTime  datetime,
    modifiedTime datetime,
    name         nvarchar(128) default '' not null,
    createdBy    varchar(120),
    modifiedBy   varchar(120)
)
go

create table h_biz_datasource_method
(
    id                   nvarchar(128)            not null
        primary key,
    createdTime          datetime,
    creater              nvarchar(128),
    modifier             nvarchar(128),
    modifiedTime         datetime,
    deleted              bit,
    remarks              nvarchar(256),
    code                 nvarchar(32)  default '' not null
        constraint uk_code
            unique,
    name                 nvarchar(256) default '' not null,
    sqlConfig            nvarchar(512) default '' not null,
    datasourceCategoryId nvarchar(128) default '' not null,
    dataBaseConnectId    nvarchar(128) default '' not null,
    reportObjectId       nvarchar(32)  default '' not null,
    reportTableName      nvarchar(32)  default '' not null
)
go

create table h_biz_export_task
(
    id                 nvarchar(36) not null
        primary key,
    startTime          datetime,
    endTime            datetime,
    message            nvarchar(4000),
    taskStatus         nvarchar(50),
    exportResultStatus nvarchar(50),
    userId             nvarchar(36),
    createdTime        datetime,
    creater            nvarchar(120),
    deleted            bit,
    modifiedTime       datetime,
    modifier           nvarchar(120),
    remarks            nvarchar(200),
    path               nvarchar(120)
)
go

create table h_biz_method
(
    id            nvarchar(120) not null
        primary key,
    creater       nvarchar(120),
    createdTime   datetime,
    deleted       bit,
    modifier      nvarchar(120),
    modifiedTime  datetime,
    remarks       nvarchar(200),
    code          nvarchar(40),
    defaultMethod bit,
    description   ntext,
    methodType    nvarchar(40),
    name          nvarchar(100),
    schemaCode    nvarchar(40),
    constraint UKg46npf8nbrgemj8p3xfnjemn4
        unique (schemaCode, code)
)
go

create table h_biz_method_mapping
(
    id                 nvarchar(120) not null
        primary key,
    createdTime        datetime,
    creater            nvarchar(120),
    deleted            bit,
    modifiedTime       datetime,
    modifier           nvarchar(120),
    remarks            nvarchar(200),
    bizMethodId        nvarchar(40),
    inputMappingsJson  ntext,
    methodCode         nvarchar(40),
    outputMappingsJson ntext,
    schemaCode         nvarchar(40),
    serviceCode        nvarchar(40),
    serviceMethodCode  nvarchar(40),
    businessRuleId     varchar(40),
    nodeCode           varchar(40)
)
go

create table h_biz_object_relation
(
    id             nvarchar(42) not null
        primary key,
    srcSc          nvarchar(42) not null,
    srcId          nvarchar(42) not null,
    srcParentSc    nvarchar(42),
    srcParentId    nvarchar(42),
    targetSc       nvarchar(42) not null,
    targetId       nvarchar(42) not null,
    targetParentSc nvarchar(42),
    targetParentId nvarchar(42),
    createTime     datetime     not null,
    sortBy         bigint
)
go

create index idx_sc_id
    on h_biz_object_relation (targetSc, targetId)
go

create table h_biz_perm_group
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    enabled      bit,
    name         nvarchar(50),
    name_i18n    nvarchar(1000),
    roles        ntext,
    schemaCode   nvarchar(40),
    departments  ntext,
    authorType   nvarchar(40)
)
go

create table h_biz_perm_property
(
    id             nvarchar(120) not null
        primary key,
    creater        nvarchar(120),
    createdTime    datetime,
    deleted        bit,
    modifier       nvarchar(120),
    modifiedTime   datetime,
    remarks        nvarchar(200),
    bizPermType    nvarchar(40),
    groupId        nvarchar(40),
    name           nvarchar(200),
    name_i18n      nvarchar(1000),
    propertyCode   nvarchar(40),
    propertyType   nvarchar(40),
    required       bit,
    visible        bit,
    writeAble      bit,
    schemaCode     nvarchar(40),
    encryptVisible bit
)
go

create table h_biz_property
(
    id                   nvarchar(120) not null
        primary key,
    createdTime          datetime,
    creater              nvarchar(120),
    deleted              bit,
    modifiedTime         datetime,
    modifier             nvarchar(120),
    remarks              nvarchar(200),
    code                 nvarchar(40),
    defaultProperty      bit,
    defaultValue         nvarchar(1300),
    name                 nvarchar(200),
    propertyEmpty        bit,
    propertyIndex        bit,
    propertyLength       int,
    propertyType         nvarchar(40),
    published            bit,
    relativeCode         nvarchar(40),
    schemaCode           nvarchar(40),
    name_i18n            nvarchar(1000),
    sortKey              int,
    relativePropertyCode nvarchar(40),
    relativeQuoteCode    ntext,
    repeated             int default 0,
    selectionJson        ntext
)
go

create index Idx_schemaCode
    on h_biz_property (schemaCode)
go

create table h_biz_query
(
    id                    nvarchar(120) not null
        primary key,
    createdTime           datetime,
    creater               nvarchar(120),
    deleted               bit,
    modifiedTime          datetime,
    modifier              nvarchar(120),
    remarks               nvarchar(200),
    code                  nvarchar(40),
    icon                  nvarchar(50),
    name                  nvarchar(50),
    schemaCode            nvarchar(40),
    sortKey               int,
    name_i18n             nvarchar(1000),
    queryPresentationType nvarchar(40) default 'LIST',
    showOnPc              bit,
    showOnMobile          bit,
    publish               bit
)
go

create table h_biz_query_action
(
    id              nvarchar(120) not null
        primary key,
    createdTime     datetime,
    creater         nvarchar(120),
    deleted         bit,
    modifiedTime    datetime,
    modifier        nvarchar(120),
    remarks         nvarchar(200),
    actionCode      nvarchar(40),
    associationCode nvarchar(40),
    associationType nvarchar(40),
    customService   bit,
    icon            nvarchar(50),
    name            nvarchar(50),
    queryActionType nvarchar(50),
    queryId         nvarchar(36),
    schemaCode      nvarchar(40),
    serviceCode     nvarchar(40),
    serviceMethod   nvarchar(40),
    sortKey         int,
    systemAction    bit,
    name_i18n       nvarchar(1000),
    clientType      nvarchar(40) default 'PC',
    extend1         varchar(255)
)
go

create table h_biz_query_column
(
    id            nvarchar(120) not null
        primary key,
    createdTime   datetime,
    creater       nvarchar(120),
    deleted       bit,
    modifiedTime  datetime,
    modifier      nvarchar(120),
    remarks       nvarchar(200),
    isSystem      bit,
    name          nvarchar(200),
    propertyCode  nvarchar(40),
    propertyType  nvarchar(40),
    queryId       nvarchar(36),
    schemaCode    nvarchar(40),
    sortKey       int,
    sumType       nvarchar(40),
    unit          int,
    width         nvarchar(50),
    displayFormat int,
    name_i18n     nvarchar(1000),
    clientType    nvarchar(40) default 'PC'
)
go

create table h_biz_query_condition
(
    id                nvarchar(120) not null
        primary key,
    createdTime       datetime,
    creater           nvarchar(120),
    deleted           bit,
    modifiedTime      datetime,
    modifier          nvarchar(120),
    remarks           nvarchar(200),
    choiceType        nvarchar(10),
    dataStatus        nvarchar(40),
    defaultState      int,
    defaultValue      nvarchar(500),
    displayType       nvarchar(10),
    endValue          nvarchar(50),
    isSystem          bit,
    name              nvarchar(200),
    options           nvarchar(500),
    propertyCode      nvarchar(40),
    propertyType      nvarchar(40),
    queryId           nvarchar(36),
    schemaCode        nvarchar(40),
    sortKey           int,
    startValue        nvarchar(50),
    userOptionType    nvarchar(10),
    visible           bit,
    relativeQueryCode nvarchar(40),
    accurateSearch    bit,
    displayFormat     nvarchar(40),
    name_i18n         nvarchar(1000),
    clientType        nvarchar(40) default 'PC',
    dateType          nvarchar(40)
)
go

create table h_biz_query_present
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    queryId      nvarchar(36),
    schemaCode   nvarchar(40),
    clientType   nvarchar(40),
    htmlJson     ntext,
    actionsJson  ntext,
    columnsJson  ntext
)
go

create table h_biz_query_sorter
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    direction    nvarchar(40),
    isSystem     bit,
    name         nvarchar(200),
    propertyCode nvarchar(40),
    propertyType nvarchar(40),
    queryId      nvarchar(36),
    schemaCode   nvarchar(40),
    sortKey      int,
    name_i18n    nvarchar(1000),
    clientType   nvarchar(40) default 'PC'
)
go

create table h_biz_remind
(
    id              nvarchar(120) not null
        primary key,
    creater         nvarchar(120),
    createdTime     datetime,
    deleted         bit,
    modifier        nvarchar(120),
    modifiedTime    datetime,
    remarks         nvarchar(200),
    conditionType   nvarchar(20),
    dateOption      nvarchar(300),
    dateType        nvarchar(20),
    depIds          ntext,
    enabled         bit,
    filterType      nvarchar(20),
    intervalTime    int,
    msgTemplate     ntext,
    remindType      nvarchar(20),
    roleCondition   ntext,
    roleIds         ntext,
    schemaCode      nvarchar(100),
    sheetCode       nvarchar(100),
    userDataOptions ntext,
    userIds         ntext
)
go

create table h_biz_rule
(
    id                       nvarchar(120) not null
        primary key,
    creater                  nvarchar(120),
    createdTime              datetime,
    deleted                  bit,
    modifier                 nvarchar(120),
    modifiedTime             datetime,
    remarks                  nvarchar(200),
    conditionJoinType        nvarchar(40),
    enabled                  bit,
    name                     nvarchar(100),
    ruleActionJson           ntext,
    ruleScopeJson            ntext,
    sourceSchemaCode         nvarchar(40),
    targetSchemaCode         nvarchar(40),
    triggerActionType        nvarchar(40),
    triggerConditionType     nvarchar(40),
    triggerSchemaCode        nvarchar(40),
    chooseAction             nvarchar(100),
    dataConditionJoinType    nvarchar(40),
    dataConditionJson        ntext,
    targetTableCode          nvarchar(40),
    ruleScopeChildJson       ntext,
    ruleActionMainScopeJson  ntext,
    insertConditionJoinType  nvarchar(40),
    triggerSchemaCodeIsGroup bit default 0
)
go

create table h_biz_rule_effect
(
    id                      nvarchar(120) not null
        primary key,
    creater                 nvarchar(120),
    createdTime             datetime,
    deleted                 bit,
    modifier                nvarchar(120),
    modifiedTime            datetime,
    remarks                 nvarchar(200),
    actionType              nvarchar(40),
    actionValue             nvarchar(255),
    lastValue               ntext,
    setValue                ntext,
    targetObjectId          nvarchar(100),
    targetPropertyCode      nvarchar(40),
    targetSchemaCode        nvarchar(40),
    triggerActionType       nvarchar(40),
    triggerId               nvarchar(100),
    triggerObjectId         nvarchar(100),
    triggerSchemaCode       nvarchar(40),
    targetTableType         nvarchar(40),
    targetTableCode         nvarchar(40),
    targetMainObjectId      nvarchar(100),
    targetMainObjectName    nvarchar(200) default '',
    targetPropertyLastValue ntext,
    targetPropertySetValue  ntext,
    targetPropertyName      nvarchar(50),
    targetPropertyType      nvarchar(40)
)
go

create table h_biz_rule_trigger
(
    id                    nvarchar(120) not null
        primary key,
    creater               nvarchar(120),
    createdTime           datetime,
    deleted               bit,
    modifier              nvarchar(120),
    modifiedTime          datetime,
    remarks               nvarchar(200),
    conditionJoinType     nvarchar(40),
    ruleId                nvarchar(100),
    ruleName              nvarchar(100),
    targetSchemaCode      nvarchar(40),
    triggerActionType     nvarchar(40),
    triggerConditionType  nvarchar(40),
    triggerObjectId       nvarchar(100),
    triggerSchemaCode     nvarchar(40),
    triggerMainObjectId   nvarchar(100),
    triggerMainObjectName nvarchar(200) default '',
    triggerTableType      nvarchar(40),
    sourceAppCode         nvarchar(40),
    sourceAppName         nvarchar(50),
    sourceSchemaCode      nvarchar(40),
    sourceSchemaName      nvarchar(50),
    targetSchemaName      nvarchar(50),
    targetTableCode       nvarchar(40),
    success               bit,
    failLog               ntext,
    effect                bit
)
go

create table h_biz_schema
(
    id                 nvarchar(120) not null
        primary key,
    createdTime        datetime,
    creater            nvarchar(120),
    deleted            bit,
    modifiedTime       datetime,
    modifier           nvarchar(120),
    remarks            nvarchar(2000),
    code               nvarchar(40)
        constraint idx_schemaCode
            unique,
    icon               nvarchar(50),
    name               nvarchar(50),
    published          bit,
    summary            nvarchar(2000),
    name_i18n          nvarchar(1000),
    businessRuleEnable bit default 0
)
go

create table h_biz_service
(
    id                nvarchar(120) not null
        primary key,
    createdTime       datetime,
    creater           nvarchar(120),
    deleted           bit,
    modifiedTime      datetime,
    modifier          nvarchar(120),
    remarks           nvarchar(200),
    code              nvarchar(40),
    configJSON        ntext,
    description       nvarchar(2000),
    name              nvarchar(50),
    serviceCategoryId nvarchar(40),
    shared            bit,
    userIds           ntext,
    adapterCode       nvarchar(40)
)
go

create table h_biz_service_category
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    modifiedTime datetime,
    name         nvarchar(50),
    createdBy    varchar(120),
    modifiedBy   varchar(120)
)
go

create table h_biz_service_method
(
    id                   nvarchar(120) not null
        primary key,
    createdTime          datetime,
    creater              nvarchar(120),
    deleted              bit,
    modifiedTime         datetime,
    modifier             nvarchar(120),
    remarks              nvarchar(200),
    code                 nvarchar(40),
    configJSON           ntext,
    description          nvarchar(2000),
    inputParametersJson  ntext,
    name                 nvarchar(50),
    outputParametersJson ntext,
    protocolAdapterType  nvarchar(40),
    serviceCode          nvarchar(40)
)
go

create table h_biz_sheet
(
    id                      nvarchar(120) not null
        primary key,
    createdTime             datetime,
    creater                 nvarchar(120),
    deleted                 bit,
    modifiedTime            datetime,
    modifier                nvarchar(120),
    remarks                 nvarchar(200),
    code                    nvarchar(40),
    draftAttributesJson     ntext,
    draftViewJson           ntext,
    icon                    nvarchar(50),
    mobileIsPc              bit,
    mobileUrl               nvarchar(500),
    name                    nvarchar(50),
    pcUrl                   nvarchar(500),
    printIsPc               bit,
    printUrl                nvarchar(500),
    published               bit,
    publishedAttributesJson ntext,
    publishedViewJson       ntext,
    schemaCode              nvarchar(40),
    sheetType               nvarchar(50),
    sortKey                 int,
    serialCode              nvarchar(255),
    serialResetType         nvarchar(40),
    externalLinkAble        bit default 0,
    name_i18n               nvarchar(1000),
    draftHtmlJson           ntext,
    publishedHtmlJson       ntext,
    draftActionsJson        ntext,
    publishedActionsJson    ntext,
    shortCode               nvarchar(50),
    printTemplateJson       nvarchar(1000),
    qrCodeAble              nvarchar(40),
    pdfAble                 nvarchar(40),
    tempAuthSchemaCodes     nvarchar(3500),
    borderMode              nvarchar(10),
    layoutType              nvarchar(20),
    formComment             bit default 0
)
go

create table h_biz_sheet_history
(
    id                      varchar(120) not null
        primary key,
    creater                 varchar(120),
    createdTime             datetime,
    deleted                 bit,
    modifier                varchar(120),
    modifiedTime            datetime,
    remarks                 varchar(200),
    borderMode              varchar(10),
    code                    varchar(40),
    draftActionsJson        text,
    draftAttributesJson     text,
    draftHtmlJson           text,
    draftViewJson           text,
    externalLinkAble        bit,
    formComment             bit,
    sheetType               varchar(50),
    icon                    varchar(50),
    layoutType              varchar(20),
    mobileIsPc              bit,
    mobileUrl               varchar(500),
    name                    varchar(50),
    name_i18n               varchar(1000),
    pcUrl                   varchar(500),
    pdfAble                 varchar(40),
    printIsPc               bit,
    printTemplateJson       varchar(1000),
    printUrl                varchar(500),
    publishBy               varchar(120),
    published               bit,
    publishedActionsJson    text,
    publishedAttributesJson text,
    publishedHtmlJson       text,
    publishedViewJson       text,
    qrCodeAble              varchar(40),
    schemaCode              varchar(40),
    serialCode              varchar(255),
    serialResetType         varchar(40),
    shortCode               varchar(50),
    sortKey                 int,
    tempAuthSchemaCodes     varchar(350),
    version                 int
)
go

create table h_business_rule
(
    id               nvarchar(120) not null
        primary key,
    createdTime      datetime,
    creater          nvarchar(120),
    deleted          bit,
    modifiedTime     datetime,
    modifier         nvarchar(120),
    node             ntext,
    route            ntext,
    schedulerSetting ntext,
    bizRuleType      nvarchar(15),
    defaultRule      bit,
    code             nvarchar(40),
    name             nvarchar(100),
    schemaCode       nvarchar(40),
    remarks          nvarchar(200),
    enabled          bit,
    quoteProperty    text
)
go

create table h_business_rule_runmap
(
    id                varchar(120) not null
        primary key,
    nodeCode          varchar(40),
    nodeName          varchar(100),
    nodeType          varchar(15),
    ruleCode          varchar(40),
    ruleName          varchar(100),
    ruleType          varchar(15),
    targetSchemaCode  varchar(40),
    triggerSchemaCode varchar(40)
)
go

create table h_business_rule_test
(
    code       nvarchar(40) not null,
    name       nvarchar(100),
    schemaCode nvarchar(40),
    remarks    nvarchar(200)
)
go

create table h_custom_page
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    code         nvarchar(40),
    icon         nvarchar(50),
    mobileUrl    nvarchar(500),
    name         nvarchar(50),
    openMode     nvarchar(40),
    pcUrl        nvarchar(500),
    appCode      nvarchar(40),
    name_i18n    nvarchar(1000)
)
go

create table h_form_comment
(
    id              nvarchar(42)                   not null
        primary key,
    content         nvarchar(3000),
    commentator     nvarchar(42)                   not null,
    commentatorName nvarchar(80)                   not null,
    departmentId    nvarchar(42),
    schemaCode      nvarchar(42)                   not null,
    bizObjectId     nvarchar(42)                   not null,
    replyCommentId  nvarchar(42),
    replyUserId     nvarchar(42),
    replyUserName   nvarchar(80),
    originCommentId nvarchar(42),
    floor           int          default 0         not null,
    state           nvarchar(20) default 'ENABLED' not null,
    deleted         tinyint      default 0         not null,
    attachmentNum   int          default 0         not null,
    modifier        nvarchar(42),
    createdTime     datetime                       not null,
    modifiedTime    datetime,
    text            nvarchar(4000)
)
go

create index IDX_FORM_OBJ_ID
    on h_form_comment (bizObjectId)
go

create table h_from_comment_attachment
(
    id             nvarchar(42)  not null
        primary key,
    bizObjectId    nvarchar(42)  not null,
    schemaCode     nvarchar(42)  not null,
    commentId      nvarchar(42)  not null,
    fileExtension  nvarchar(30),
    fileSize       int default 0 not null,
    base64ImageStr ntext,
    mimeType       nvarchar(50)  not null,
    name           nvarchar(255) not null,
    refId          nvarchar(80)  not null,
    createdTime    datetime      not null,
    creater        nvarchar(42)  not null
)
go

create index IDX_F_C_A_COMM_ID
    on h_from_comment_attachment (commentId)
go

create index IDX_F_C_A_REF_ID
    on h_from_comment_attachment (refId)
go

create table h_im_message
(
    id            nvarchar(36) not null
        primary key,
    bizParams     ntext,
    channel       nvarchar(40),
    content       ntext,
    createdTime   datetime,
    failRetry     bit,
    failUserRetry bit,
    messageType   nvarchar(40),
    modifiedTime  datetime,
    receivers     ntext,
    title         nvarchar(100),
    tryTimes      int,
    url           nvarchar(500),
    externalLink  bit
)
go

create table h_im_message_history
(
    id              nvarchar(36) not null
        primary key,
    bizParams       ntext,
    channel         nvarchar(40),
    content         ntext,
    createdTime     datetime,
    failRetry       bit,
    failUserRetry   bit,
    messageType     nvarchar(40),
    modifiedTime    datetime,
    receivers       ntext,
    title           nvarchar(100),
    tryTimes        int,
    url             nvarchar(500),
    sendFailUserIds ntext,
    status          nvarchar(40),
    taskId          nvarchar(40),
    externalLink    bit
)
go

create index idx_message_history_status
    on h_im_message_history (status)
go

create table h_im_urge_task
(
    id         nvarchar(64)  not null
        primary key,
    instanceId nvarchar(120) not null,
    text       nvarchar(255) not null,
    userId     nvarchar(80)  not null,
    opTime     datetime      not null,
    urgeType   int default 0 not null,
    messageId  nvarchar(120)
)
go

create index IDX_HASTEN_INST_USERID
    on h_im_urge_task (instanceId, userId)
go

create table h_im_urge_workitem
(
    id         nvarchar(64)  not null
        primary key,
    workitemId nvarchar(120) not null,
    userId     nvarchar(80)  not null,
    createTime datetime      not null,
    modifyTime datetime      not null,
    urgeCount  int default 1 not null
)
go

create index IDX_URGE_ITEMID_USERID
    on h_im_urge_workitem (workitemId, userId)
go

create table h_im_work_record
(
    id               nvarchar(42) not null
        primary key,
    workitemId       nvarchar(64),
    recordId         nvarchar(80),
    requestId        nvarchar(80),
    receivers        ntext,
    title            nvarchar(100),
    content          nvarchar(3000) default '',
    url              nvarchar(500),
    receiveTime      datetime,
    tryTimes         int,
    failRetry        nvarchar(200),
    messageType      nvarchar(200),
    failUserRetry    bit,
    WorkRecordStatus nvarchar(40) not null,
    channel          nvarchar(40),
    bizParams        ntext,
    createdTime      datetime,
    modifiedTime     datetime
)
go

create index I_RecordId
    on h_im_work_record (recordId)
go

create table h_im_work_record_history
(
    id               nvarchar(42) not null
        primary key,
    workitemId       nvarchar(64),
    recordId         nvarchar(80),
    requestId        nvarchar(80),
    receivers        ntext,
    title            nvarchar(100),
    content          nvarchar(3000) default '',
    url              nvarchar(500),
    receiveTime      datetime,
    tryTimes         int,
    failRetry        nvarchar(200),
    messageType      nvarchar(200),
    failUserRetry    bit,
    WorkRecordStatus nvarchar(40) not null,
    status           nvarchar(40),
    channel          nvarchar(40),
    bizParams        ntext,
    createdTime      datetime,
    modifiedTime     datetime,
    taskId           nvarchar(42)
)
go

create index I_RecordId
    on h_im_work_record_history (recordId)
go

create table h_job_result
(
    id             nvarchar(120) not null
        primary key,
    jobName        nvarchar(100),
    beanName       nvarchar(100),
    methodName     nvarchar(100),
    methodParams   nvarchar(255),
    year           int,
    cronExpression nvarchar(80),
    jobRunType     nvarchar(20),
    createTime     datetime,
    executeStatus  nvarchar(20),
    taskId         nvarchar(120)
)
go

create table h_log_biz_object
(
    id                 nvarchar(120) not null
        primary key,
    client             ntext,
    detail             ntext,
    ip                 nvarchar(500),
    operateNode        nvarchar(100),
    operationType      nvarchar(50),
    time               datetime,
    username           nvarchar(100),
    workflowInstanceId nvarchar(120)
)
go

create table h_log_biz_service
(
    id               nvarchar(120) not null
        primary key,
    bizServiceStatus nvarchar(20),
    code             nvarchar(40),
    createdTime      datetime,
    endTime          datetime,
    exception        ntext,
    methodName       nvarchar(120),
    options          ntext,
    params           nvarchar(2000),
    result           ntext,
    server           nvarchar(200),
    startTime        datetime,
    usedTime         bigint,
    schemaCode       nvarchar(40),
    bizObjectId      nvarchar(200)
)
go

create table h_log_business_rule_content
(
    id                nvarchar(120) not null
        primary key,
    exceptionContent  ntext,
    exceptionNodeCode nvarchar(120),
    exceptionNodeName nvarchar(200),
    flowInstanceId    nvarchar(120),
    triggerCoreData   ntext
)
go

create index idx_h_log_business_rule_content_flowInstanceId
    on h_log_business_rule_content (flowInstanceId)
go

create table h_log_business_rule_data_trace
(
    id                    nvarchar(120) not null
        primary key,
    flowInstanceId        nvarchar(120),
    nodeCode              nvarchar(120),
    nodeInstanceId        nvarchar(120),
    nodeName              nvarchar(200),
    ruleTriggerActionType nvarchar(40),
    targetObjectId        nvarchar(120),
    targetSchemaCode      nvarchar(40),
    traceLastData         ntext,
    traceSetData          ntext,
    traceUpdateDetail     ntext
)
go

create index idx_h_log_business_rule_data_trace_flowInstanceId
    on h_log_business_rule_data_trace (flowInstanceId)
go

create table h_log_business_rule_header
(
    id                   nvarchar(120) not null
        primary key,
    businessRuleCode     nvarchar(40),
    businessRuleName     nvarchar(200),
    endTime              datetime,
    flowInstanceId       nvarchar(120),
    originator           nvarchar(40),
    schemaCode           nvarchar(40),
    startTime            datetime,
    success              bit,
    sourceFlowInstanceId nvarchar(120),
    repair               bit,
    extend               nvarchar(255)
)
go

create index idx_h_log_business_rule_header_flowInstanceId
    on h_log_business_rule_header (flowInstanceId)
go

create table h_log_business_rule_node
(
    id             nvarchar(120) not null
        primary key,
    endTime        datetime,
    flowInstanceId nvarchar(120),
    nodeCode       nvarchar(120),
    nodeInstanceId nvarchar(120),
    nodeName       nvarchar(200),
    nodeSequence   int,
    startTime      datetime
)
go

create index idx_h_log_business_rule_node_flowInstanceId
    on h_log_business_rule_node (flowInstanceId)
go

create table h_log_login
(
    id              nvarchar(120) not null
        primary key,
    browser         nvarchar(50),
    clientAgent     nvarchar(500),
    ipAddress       nvarchar(20),
    loginSourceType nvarchar(40),
    loginTime       datetime,
    name            nvarchar(40),
    userId          nvarchar(40),
    username        nvarchar(40)
)
go

create table h_log_metadata
(
    id          nvarchar(120) not null
        primary key,
    bizKey      nvarchar(120),
    metaData    ntext,
    moduleName  nvarchar(60),
    objId       nvarchar(120),
    operateTime datetime,
    operateType int,
    operator    nvarchar(120)
)
go

create table h_log_synchro
(
    id            nvarchar(42)   not null
        primary key,
    trackId       nvarchar(60)   not null,
    creater       nvarchar(42),
    createdTime   datetime       not null,
    startTime     datetime       not null,
    endTime       datetime       not null,
    fixer         nvarchar(42),
    fixedTime     datetime       not null,
    fixedCount    int default 0  not null,
    fixNotes      nvarchar(1000) not null,
    fixedStatus   nvarchar(40),
    executeStatus nvarchar(40)
)
go

create table h_log_workflow_exception
(
    id                   nvarchar(120) not null
        primary key,
    creater              nvarchar(120) not null,
    createrName          nvarchar(200),
    detail               text,
    extData              nvarchar(1000),
    fixNotes             nvarchar(1000),
    fixedTime            datetime,
    fixer                nvarchar(120),
    fixerName            nvarchar(200),
    status               nvarchar(40)  not null,
    summary              nvarchar(500) not null,
    workflowCode         nvarchar(40)  not null,
    workflowInstanceId   nvarchar(120) not null,
    workflowInstanceName nvarchar(200),
    workflowName         nvarchar(200),
    workflowVersion      int           not null,
    createdTime          datetime
)
go

create table h_open_api_event
(
    id              nvarchar(120) not null
        primary key,
    callback        nvarchar(400),
    clientId        nvarchar(30),
    eventTarget     nvarchar(300),
    eventTargetType nvarchar(255),
    eventType       nvarchar(255)
)
go

create table h_org_department
(
    id                nvarchar(120) not null
        primary key,
    createdTime       datetime,
    creater           nvarchar(120),
    deleted           bit,
    extend1           nvarchar(255),
    extend2           nvarchar(255),
    extend3           nvarchar(255),
    extend4           int,
    extend5           int,
    modifiedTime      datetime,
    modifier          nvarchar(120),
    remarks           nvarchar(200),
    calendarId        nvarchar(36),
    employees         int,
    leaf              bit,
    managerId         nvarchar(36),
    name              nvarchar(180),
    parentId          nvarchar(36),
    sortKey           bigint,
    sourceId          nvarchar(40),
    queryCode         nvarchar(255),
    dingDeptManagerId nvarchar(255),
    isShow            bit          default 1,
    deptType          nvarchar(40) default 'DEPT',
    corpId            nvarchar(256),
    enabled           bit
)
go

create index idx_org_name
    on h_org_department (name)
go

create index idx_parent_id
    on h_org_department (parentId)
go

create table h_org_department_history
(
    id              nvarchar(120) not null
        primary key,
    creater         nvarchar(120),
    createdTime     datetime,
    deleted         bit,
    modifier        nvarchar(120),
    modifiedTime    datetime,
    remarks         nvarchar(200),
    extend1         nvarchar(255),
    extend2         nvarchar(255),
    extend3         nvarchar(255),
    extend4         int,
    extend5         int,
    calendarId      nvarchar(36),
    employees       int,
    leaf            bit,
    managerId       nvarchar(2000),
    name            nvarchar(200),
    parentId        nvarchar(36),
    queryCode       nvarchar(512),
    sortKey         bigint,
    sourceId        nvarchar(40),
    targetParentId  nvarchar(36),
    targetQueryCode nvarchar(512),
    changeTime      datetime,
    version         int,
    changeAction    nvarchar(20),
    corpId          nvarchar(256)
)
go

create index idx_hist_source_id
    on h_org_department_history (sourceId)
go

create table h_org_dept_user
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    extend1      nvarchar(255),
    extend2      nvarchar(255),
    extend3      nvarchar(255),
    extend4      int,
    extend5      int,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    deptId       nvarchar(36),
    main         bit,
    userId       nvarchar(36),
    sortKey      nvarchar(200),
    leader       bit,
    userSourceId nvarchar(255),
    deptSourceId nvarchar(255),
    constraint idx_dept_user_composeid
        unique (userId, deptId)
)
go

create index idx_du_user_id
    on h_org_dept_user (userId)
go

create table h_org_inc_sync_record
(
    id             varchar(120) not null
        primary key,
    corpId         varchar(255),
    createTime     datetime,
    eventInfo      text,
    eventType      varchar(255),
    handleStatus   varchar(255),
    retryCount     int,
    syncSourceType int,
    updateTime     datetime
)
go

create table h_org_incremental_sync_log
(
    id           nvarchar(32) not null
        primary key,
    createTime   datetime,
    updateTime   datetime,
    eventType    nvarchar(50),
    corpId       nvarchar(64),
    eventInfo    nvarchar(4000),
    handleStatus nvarchar(20),
    retryCount   int
)
go

create table h_org_role
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    extend1      nvarchar(255),
    extend2      nvarchar(255),
    extend3      nvarchar(255),
    extend4      int,
    extend5      int,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    code         nvarchar(180),
    groupId      nvarchar(36),
    name         nvarchar(180),
    sortKey      int,
    sourceId     nvarchar(40),
    roleType     nvarchar(40) default 'SYS',
    corpId       nvarchar(256)
)
go

create index idx_rolde_code
    on h_org_role (code)
go

create index idx_rolde_name
    on h_org_role (name)
go

create index idx_role_id
    on h_org_role (id)
go

create table h_org_role_group
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    extend1      nvarchar(255),
    extend2      nvarchar(255),
    extend3      nvarchar(255),
    extend4      int,
    extend5      int,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    code         nvarchar(180),
    defaultGroup bit,
    name         nvarchar(256),
    roleId       nvarchar(36),
    sortKey      int,
    sourceId     nvarchar(40),
    roleType     nvarchar(40) default 'SYS',
    corpId       nvarchar(256),
    parentId     varchar(120)
)
go

create index idx_role_group_code
    on h_org_role_group (code)
go

create index idx_role_group_id
    on h_org_role_group (id)
go

create table h_org_role_user
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    extend1      nvarchar(255),
    extend2      nvarchar(255),
    extend3      nvarchar(255),
    extend4      int,
    extend5      int,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    ouScope      ntext,
    roleId       nvarchar(36),
    userId       nvarchar(36),
    userSourceId nvarchar(255),
    roleSourceId nvarchar(255),
    unitType     nvarchar(40) default 'USER',
    deptId       nvarchar(40),
    usScope      ntext,
    constraint idx_role_user_composeid
        unique (userId, roleId)
)
go

create index idx_role_user_id
    on h_org_role_user (id)
go

create index idx_role_user_sourceid
    on h_org_role_user (userSourceId, roleSourceId)
go

create table h_org_synchronize_log
(
    id              nvarchar(120) not null
        primary key,
    targetType      nvarchar(30),
    trackId         nvarchar(60),
    targetId        nvarchar(120),
    errorType       nvarchar(1000),
    corpId          nvarchar(120),
    status          nvarchar(40),
    isSyncRoleScope tinyint default 0
)
go

create table h_org_synchronize_task
(
    id         varchar(120) not null
        primary key,
    endTime    datetime,
    message    varchar(255),
    startTime  datetime,
    syncResult varchar(255),
    taskStatus varchar(255),
    userId     varchar(255)
)
go

create table h_org_user
(
    id            nvarchar(120) not null
        primary key,
    createdTime   datetime,
    creater       nvarchar(120),
    deleted       bit,
    extend1       nvarchar(255),
    extend2       nvarchar(255),
    extend3       nvarchar(255),
    extend4       int,
    extend5       int,
    modifiedTime  datetime,
    modifier      nvarchar(120),
    remarks       nvarchar(200),
    active        bit,
    admin         bit,
    appellation   nvarchar(40),
    birthday      datetime,
    boss          bit,
    departmentId  nvarchar(255),
    departureDate datetime,
    dingtalkId    nvarchar(100),
    email         nvarchar(40),
    employeeNo    nvarchar(40),
    employeeRank  int,
    entryDate     datetime,
    gender        nvarchar(5),
    identityNo    nvarchar(18),
    imgUrl        nvarchar(200),
    leader        bit,
    managerId     nvarchar(40),
    mobile        nvarchar(100),
    name          nvarchar(180),
    officePhone   nvarchar(20),
    password      nvarchar(100),
    username      nvarchar(40),
    privacyLevel  nvarchar(40),
    secretaryId   nvarchar(36),
    sortKey       bigint,
    sourceId      nvarchar(50),
    status        nvarchar(40),
    userId        nvarchar(255),
    pinYin        nvarchar(250),
    shortPinYin   nvarchar(250),
    imgUrlId      nvarchar(40),
    dingUserJson  ntext,
    corpId        nvarchar(256),
    position      nvarchar(80),
    enabled       bit
)
go

create unique index UK_rj7duahtop7qmf2ka0kxs57i0
    on h_org_user (dingtalkId)
    where [dingtalkId] IS NOT NULL
go

create table h_org_user_extend_attr
(
    id           nvarchar(120) not null,
    name         nvarchar(255) default '',
    code         nvarchar(120) default '',
    mapKey       nvarchar(120) default '',
    enable       tinyint       default 0,
    belong       nvarchar(120) default '',
    corpId       nvarchar(128) default 'ALL',
    deleted      tinyint       default 1,
    createdBy    nvarchar(120) default '',
    createdTime  datetime,
    modifiedBy   nvarchar(120),
    modifiedTime datetime,
    constraint UK_code_corpId
        unique (code, corpId)
)
go

create index IDX_corpId
    on h_org_user_extend_attr (corpId)
go

create table h_org_user_union_extend_attr
(
    id           nvarchar(120) not null,
    userId       nvarchar(120) default '',
    extendAttrId nvarchar(120) default '',
    mapVal       nvarchar(500) default '0',
    deleted      tinyint       default 1,
    createdBy    nvarchar(128) default '',
    createdTime  datetime,
    modifiedBy   nvarchar(128),
    modifiedTime datetime,
    constraint UK_userId_attrId
        unique (userId, extendAttrId)
)
go

create index IDX_extendAttrId
    on h_org_user_union_extend_attr (extendAttrId)
go

create index IDX_userId
    on h_org_user_union_extend_attr (userId)
go

create table h_perm_admin
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    adminType    nvarchar(40),
    dataManage   bit,
    appManage    bit,
    dataQuery    bit,
    userId       nvarchar(40),
    parentId     nvarchar(120)
)
go

create table h_perm_app_package
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    appCode      nvarchar(40),
    departments  ntext,
    roles        ntext,
    visibleType  nvarchar(40)
)
go

create table h_perm_apppackage_scope
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    adminId      nvarchar(40),
    code         nvarchar(40),
    name         nvarchar(50)
)
go

create table h_perm_biz_function
(
    id                 nvarchar(120) not null
        primary key,
    creater            nvarchar(120),
    createdTime        datetime,
    deleted            bit,
    modifier           nvarchar(120),
    modifiedTime       datetime,
    remarks            nvarchar(200),
    creatable          bit,
    dataPermissionType nvarchar(40),
    deletable          bit,
    editable           bit,
    exportable         bit,
    filterType         nvarchar(40),
    functionCode       nvarchar(40),
    importable         bit,
    permissionGroupId  nvarchar(40),
    schemaCode         nvarchar(40),
    visible            bit,
    nodeType           nvarchar(40),
    printAble          bit,
    editOwnerAble      bit,
    batchPrintAble     bit
)
go

create table h_perm_department_scope
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    adminId      nvarchar(40),
    name         nvarchar(200),
    queryCode    nvarchar(128),
    unitId       nvarchar(40),
    unitType     nvarchar(10)
)
go

create table h_perm_function_condition
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    operatorType nvarchar(40),
    propertyCode nvarchar(40),
    schemaCode   nvarchar(40),
    value        ntext,
    functionId   nvarchar(40)
)
go

create table h_perm_group
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    appCode      nvarchar(40),
    departments  ntext,
    name         nvarchar(50),
    roles        ntext,
    authorType   nvarchar(40)
)
go

create table h_perm_license
(
    id          nvarchar(42) not null
        primary key,
    bizId       nvarchar(42) not null,
    bizType     nvarchar(42) not null,
    createdTime datetime     not null
)
go

create index idx_perm_license_biz_id
    on h_perm_license (bizId)
go

create table h_perm_selection_scope
(
    id                varchar(120) not null
        primary key,
    creater           varchar(120),
    createdTime       datetime,
    deleted           bit,
    modifier          varchar(120),
    modifiedTime      datetime,
    remarks           varchar(200),
    departmentId      varchar(255),
    deptVisibleScope  text,
    deptVisibleType   varchar(255),
    staffVisibleScope text,
    staffVisibleType  varchar(255)
)
go

create table h_related_corp_setting
(
    id              nvarchar(120) not null
        primary key,
    creater         nvarchar(120),
    createdTime     datetime,
    deleted         bit,
    modifier        nvarchar(120),
    modifiedTime    datetime,
    remarks         nvarchar(200),
    agentId         nvarchar(120),
    appSecret       nvarchar(120),
    appkey          nvarchar(120),
    corpId          nvarchar(120),
    corpSecret      nvarchar(120),
    exportHost      nvarchar(32),
    extend1         nvarchar(120),
    extend2         nvarchar(120),
    extend3         nvarchar(120),
    extend4         nvarchar(120),
    extend5         nvarchar(120),
    headerNum       int           not null,
    name            nvarchar(64),
    orgType         nvarchar(12),
    relatedType     nvarchar(12),
    scanAppId       nvarchar(120),
    scanAppSecret   nvarchar(120),
    redirectUri     nvarchar(128),
    synRedirectUri  nvarchar(128),
    pcServerUrl     nvarchar(128),
    mobileServerUrl nvarchar(128),
    syncType        nvarchar(12),
    enabled         bit
)
go

create table h_report_page
(
    id             nvarchar(120) not null
        primary key,
    creater        nvarchar(120),
    createdTime    datetime,
    deleted        bit,
    modifier       nvarchar(120),
    modifiedTime   datetime,
    remarks        nvarchar(200),
    code           nvarchar(40),
    icon           nvarchar(50),
    pcAble         bit,
    name           nvarchar(50),
    mobileAble     bit,
    appCode        nvarchar(40),
    name_i18n      nvarchar(1000),
    reportObjectId nvarchar(40)
)
go

create table h_system_pair
(
    id        nvarchar(120) not null
        primary key,
    paramCode nvarchar(200),
    pairValue ntext
)
go

create table h_system_sequence_no
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    code         nvarchar(40),
    maxLength    int,
    resetDate    datetime,
    resetType    int,
    serialNo     int
)
go

create table h_system_setting
(
    id             nvarchar(120) not null
        primary key,
    paramCode      nvarchar(40)
        constraint UK_h_system_setting
            unique,
    paramValue     nvarchar(200),
    settingType    nvarchar(20),
    checked        bit,
    fileUploadType nvarchar(20)
)
go

create table h_system_setting_copy
(
    id          nvarchar(120) not null
        primary key,
    paramCode   nvarchar(40)
        constraint UK_h_system_setting_copy
            unique,
    paramValue  nvarchar(200),
    settingType nvarchar(20)
)
go

create table h_timer_job
(
    id             nvarchar(120) not null
        primary key,
    jobName        nvarchar(100),
    beanName       nvarchar(100),
    methodName     nvarchar(100),
    methodParams   nvarchar(255),
    year           int,
    cronExpression nvarchar(80),
    status         int,
    jobRunType     nvarchar(20),
    remark         nvarchar(100),
    createTime     datetime,
    updatetime2    datetime,
    taskId         nvarchar(120)
        constraint idx_h_timer_job_taskId
            unique,
    updateTime     datetime
)
go

create table h_user_
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    content      nvarchar(600),
    sortKey      int,
    userId       nvarchar(36)
)
go

create table h_user_comment
(
    id           varchar(120) not null
        primary key,
    content      varchar(600),
    creater      varchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     varchar(120),
    modifiedTime datetime,
    remarks      varchar(200),
    sortKey      int,
    userId       varchar(36)
)
go

create table h_user_favorites
(
    id            nvarchar(120) not null
        primary key,
    createdTime   datetime,
    creater       nvarchar(120),
    deleted       bit,
    modifiedTime  datetime,
    modifier      nvarchar(120),
    remarks       nvarchar(200),
    bizObjectKey  nvarchar(40),
    bizObjectType nvarchar(20),
    userId        nvarchar(36),
    appCode       nvarchar(40)
)
go

create table h_user_guide
(
    id           nvarchar(120) not null
        primary key,
    creater      nvarchar(120),
    createdTime  datetime,
    deleted      bit,
    modifier     nvarchar(120),
    modifiedTime datetime,
    remarks      nvarchar(200),
    display      bit,
    pageType     nvarchar(20)  not null,
    userId       nvarchar(40)  not null
)
go

create table h_workflow_header
(
    id                 nvarchar(120)                        not null
        primary key,
    createdTime        datetime,
    creater            nvarchar(120),
    deleted            bit,
    modifiedTime       datetime,
    modifier           nvarchar(120),
    remarks            nvarchar(200),
    icon               nvarchar(50),
    mobileOriginate    bit,
    pcOriginate        bit,
    schemaCode         nvarchar(40),
    sortKey            int,
    workflowCode       nvarchar(40)
        constraint UK_2t1h4foumcylj4hvrvhssf673
            unique,
    workflowName       nvarchar(200),
    published          bit,
    name_i18n          nvarchar(1000),
    externalLinkEnable tinyint      default 0               not null,
    shortCode          nvarchar(50),
    visibleType        nvarchar(40) default 'PART_VISIABLE' not null
)
go

create table h_workflow_permission
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    unitId       nvarchar(36),
    unitType     nvarchar(10),
    workflowCode nvarchar(40)
)
go

create table h_workflow_relative_event
(
    id            nvarchar(120) not null
        primary key,
    creater       nvarchar(120),
    createdTime   datetime,
    deleted       bit,
    modifier      nvarchar(120),
    modifiedTime  datetime,
    remarks       nvarchar(200),
    schemaCode    nvarchar(40),
    workflowCode  nvarchar(40),
    bizMethodCode nvarchar(40)
)
go

create table h_workflow_relative_object
(
    id              nvarchar(120) not null
        primary key,
    relativeCode    nvarchar(40),
    relativeType    nvarchar(40),
    workflowCode    nvarchar(40),
    workflowVersion int
)
go

create table h_workflow_template
(
    id              nvarchar(120) not null
        primary key,
    createdTime     datetime,
    creater         nvarchar(120),
    deleted         bit,
    modifiedTime    datetime,
    modifier        nvarchar(120),
    remarks         nvarchar(200),
    content         ntext,
    templateType    nvarchar(10),
    workflowCode    nvarchar(40),
    workflowVersion int
)
go

create table h_workflow_template_bak
(
    id              varchar(120) not null
        primary key,
    creater         varchar(120),
    createdTime     datetime,
    deleted         bit,
    modifier        varchar(120),
    modifiedTime    datetime,
    remarks         varchar(200),
    backupTime      datetime,
    content         text,
    templateType    varchar(10),
    workflowCode    varchar(40),
    workflowVersion int
)
go

create table h_workflow_trust
(
    id                  nvarchar(42) not null
        primary key,
    workflowTrustRuleId nvarchar(42) not null,
    workflowCode        nvarchar(40) not null,
    creater             nvarchar(42),
    createTime          datetime,
    constraint IDX_PROXY_RULE_WFCODE
        unique (workflowTrustRuleId, workflowCode)
)
go

create table h_workflow_trust_rule
(
    id           nvarchar(42) not null
        primary key,
    trustor      nvarchar(42) not null,
    trustorName  nvarchar(80) not null,
    trustee      nvarchar(42) not null,
    trusteeName  nvarchar(80) not null,
    trustType    nvarchar(20) not null,
    startTime    datetime,
    endTime      datetime,
    rangeType    nvarchar(20) not null,
    state        nvarchar(20),
    creater      nvarchar(42),
    createTime   datetime,
    modifier     nvarchar(42),
    modifiedTime datetime
)
go

create index IDX_WF_TRUSTEE
    on h_workflow_trust_rule (trustee)
go

create index IDX_WF_TRUSTOR
    on h_workflow_trust_rule (trustor)
go

create table ijpyn_test0122
(
    id                 varchar(36) not null
        constraint pk_ijpyn_test0122_id
            primary key,
    name               nvarchar(200) default NULL,
    creater            nvarchar(200) default '',
    createdDeptId      nvarchar(200) default '',
    owner              nvarchar(200) default '',
    ownerDeptId        nvarchar(200) default '',
    createdTime        datetime,
    modifier           nvarchar(200) default '',
    modifiedTime       datetime,
    workflowInstanceId nvarchar(200) default NULL,
    sequenceNo         nvarchar(200) default NULL,
    sequenceStatus     nvarchar(200) default NULL,
    ownerDeptQueryCode nvarchar(255) default NULL,
    userName           nvarchar(200) default NULL,
    sex                nvarchar(200) default NULL
)
go

create table iof70_testModel
(
    id                     varchar(36) not null
        constraint pk_id_id
            primary key nonclustered,
    name                   nvarchar(200) default NULL,
    creater                nvarchar(200) default '',
    createdDeptId          nvarchar(200) default '',
    owner                  nvarchar(200) default '',
    ownerDeptId            nvarchar(200) default '',
    createdTime            datetime,
    modifier               nvarchar(200) default '',
    modifiedTime           datetime,
    workflowInstanceId     nvarchar(200) default NULL,
    sequenceNo             nvarchar(200) default NULL,
    sequenceStatus         nvarchar(200) default NULL,
    ownerDeptQueryCode     nvarchar(255) default NULL,
    ShortText1609742598946 nvarchar(200) default NULL,
    LongText1609742602085  ntext
)
go

create table iof70_testWorkflowModel
(
    id                     varchar(36) not null
        constraint pk_iof70_testWorkflowModel_id
            primary key,
    name                   nvarchar(200) default NULL,
    creater                nvarchar(200) default '',
    createdDeptId          nvarchar(200) default '',
    owner                  nvarchar(200) default '',
    ownerDeptId            nvarchar(200) default '',
    createdTime            datetime,
    modifier               nvarchar(200) default '',
    modifiedTime           datetime,
    workflowInstanceId     nvarchar(200) default NULL,
    sequenceNo             nvarchar(200) default NULL,
    sequenceStatus         nvarchar(200) default NULL,
    ownerDeptQueryCode     nvarchar(255) default NULL,
    ShortText1609844477253 nvarchar(200) default NULL,
    Number1609844482363    decimal(19, 8)
)
go

create table qrtz_calendars
(
    SCHED_NAME    nvarchar(120) not null,
    CALENDAR_NAME nvarchar(200) not null,
    CALENDAR      nvarchar(1)   not null,
    primary key (SCHED_NAME, CALENDAR_NAME)
)
go

create table qrtz_fired_triggers
(
    SCHED_NAME        nvarchar(120) not null,
    ENTRY_ID          nvarchar(95)  not null,
    TRIGGER_NAME      nvarchar(200) not null,
    TRIGGER_GROUP     nvarchar(200) not null,
    INSTANCE_NAME     nvarchar(200) not null,
    FIRED_TIME        bigint        not null,
    SCHED_TIME        bigint        not null,
    PRIORITY          int           not null,
    STATE             nvarchar(16)  not null,
    JOB_NAME          nvarchar(200),
    JOB_GROUP         nvarchar(200),
    IS_NONCONCURRENT  nvarchar(1),
    REQUESTS_RECOVERY nvarchar(1),
    primary key (SCHED_NAME, ENTRY_ID)
)
go

create index IDX_QRTZ_FT_INST_JOB_REQ_RCVRY
    on qrtz_fired_triggers (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY)
go

create index IDX_QRTZ_FT_JG
    on qrtz_fired_triggers (SCHED_NAME, JOB_GROUP)
go

create index IDX_QRTZ_FT_J_G
    on qrtz_fired_triggers (SCHED_NAME, JOB_NAME, JOB_GROUP)
go

create index IDX_QRTZ_FT_TG
    on qrtz_fired_triggers (SCHED_NAME, TRIGGER_GROUP)
go

create index IDX_QRTZ_FT_TRIG_INST_NAME
    on qrtz_fired_triggers (SCHED_NAME, INSTANCE_NAME)
go

create index IDX_QRTZ_FT_T_G
    on qrtz_fired_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
go

create table qrtz_job_details
(
    SCHED_NAME        nvarchar(120) not null,
    JOB_NAME          nvarchar(200) not null,
    JOB_GROUP         nvarchar(200) not null,
    DESCRIPTION       nvarchar(250),
    JOB_CLASS_NAME    nvarchar(250) not null,
    IS_DURABLE        nvarchar(1)   not null,
    IS_NONCONCURRENT  nvarchar(1)   not null,
    IS_UPDATE_DATA    nvarchar(1)   not null,
    REQUESTS_RECOVERY nvarchar(1)   not null,
    JOB_DATA          nvarchar(1),
    primary key (SCHED_NAME, JOB_NAME, JOB_GROUP)
)
go

create index IDX_QRTZ_J_GRP
    on qrtz_job_details (SCHED_NAME, JOB_GROUP)
go

create index IDX_QRTZ_J_REQ_RECOVERY
    on qrtz_job_details (SCHED_NAME, REQUESTS_RECOVERY)
go

create table qrtz_locks
(
    SCHED_NAME nvarchar(120) not null,
    LOCK_NAME  nvarchar(40)  not null,
    primary key (SCHED_NAME, LOCK_NAME)
)
go

create table qrtz_paused_trigger_grps
(
    SCHED_NAME    nvarchar(120) not null,
    TRIGGER_GROUP nvarchar(200) not null,
    primary key (SCHED_NAME, TRIGGER_GROUP)
)
go

create table qrtz_scheduler_state
(
    SCHED_NAME        nvarchar(120) not null,
    INSTANCE_NAME     nvarchar(200) not null,
    LAST_CHECKIN_TIME bigint        not null,
    CHECKIN_INTERVAL  bigint        not null,
    primary key (SCHED_NAME, INSTANCE_NAME)
)
go

create table qrtz_triggers
(
    SCHED_NAME     nvarchar(120) not null,
    TRIGGER_NAME   nvarchar(200) not null,
    TRIGGER_GROUP  nvarchar(200) not null,
    JOB_NAME       nvarchar(200) not null,
    JOB_GROUP      nvarchar(200) not null,
    DESCRIPTION    nvarchar(250),
    NEXT_FIRE_TIME bigint,
    PREV_FIRE_TIME bigint,
    PRIORITY       int,
    TRIGGER_STATE  nvarchar(16)  not null,
    TRIGGER_TYPE   nvarchar(8)   not null,
    START_TIME     bigint        not null,
    END_TIME       bigint,
    CALENDAR_NAME  nvarchar(200),
    MISFIRE_INSTR  smallint,
    JOB_DATA       nvarchar(1),
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_triggers_ibfk_1
        foreign key (SCHED_NAME, JOB_NAME, JOB_GROUP) references qrtz_job_details
)
go

create table qrtz_cron_triggers
(
    SCHED_NAME      nvarchar(120) not null,
    TRIGGER_NAME    nvarchar(200) not null,
    TRIGGER_GROUP   nvarchar(200) not null,
    CRON_EXPRESSION nvarchar(200) not null,
    TIME_ZONE_ID    nvarchar(80),
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_cron_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers
)
go

create table qrtz_nvarchar_triggers
(
    SCHED_NAME    nvarchar(120) not null,
    TRIGGER_NAME  nvarchar(200) not null,
    TRIGGER_GROUP nvarchar(200) not null,
    nvarchar_DATA nvarchar(1),
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_nvarchar_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers
)
go

create table qrtz_simple_triggers
(
    SCHED_NAME      nvarchar(120) not null,
    TRIGGER_NAME    nvarchar(200) not null,
    TRIGGER_GROUP   nvarchar(200) not null,
    REPEAT_COUNT    bigint        not null,
    REPEAT_INTERVAL bigint        not null,
    TIMES_TRIGGERED bigint        not null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_simple_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers
)
go

create table qrtz_simprop_triggers
(
    SCHED_NAME    nvarchar(120) not null,
    TRIGGER_NAME  nvarchar(200) not null,
    TRIGGER_GROUP nvarchar(200) not null,
    STR_PROP_1    nvarchar(512),
    STR_PROP_2    nvarchar(512),
    STR_PROP_3    nvarchar(512),
    INT_PROP_1    int,
    INT_PROP_2    int,
    LONG_PROP_1   bigint,
    LONG_PROP_2   bigint,
    DEC_PROP_1    decimal(13, 4),
    DEC_PROP_2    decimal(13, 4),
    BOOL_PROP_1   nvarchar(1),
    BOOL_PROP_2   nvarchar(1),
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_simprop_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references qrtz_triggers
)
go

create index IDX_QRTZ_T_C
    on qrtz_triggers (SCHED_NAME, CALENDAR_NAME)
go

create index IDX_QRTZ_T_G
    on qrtz_triggers (SCHED_NAME, TRIGGER_GROUP)
go

create index IDX_QRTZ_T_J
    on qrtz_triggers (SCHED_NAME, JOB_NAME, JOB_GROUP)
go

create index IDX_QRTZ_T_JG
    on qrtz_triggers (SCHED_NAME, JOB_GROUP)
go

create index IDX_QRTZ_T_NEXT_FIRE_TIME
    on qrtz_triggers (SCHED_NAME, NEXT_FIRE_TIME)
go

create index IDX_QRTZ_T_NFT_MISFIRE
    on qrtz_triggers (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME)
go

create index IDX_QRTZ_T_NFT_ST
    on qrtz_triggers (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME)
go

create index IDX_QRTZ_T_NFT_ST_MISFIRE
    on qrtz_triggers (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE)
go

create index IDX_QRTZ_T_NFT_ST_MISFIRE_GRP
    on qrtz_triggers (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP, TRIGGER_STATE)
go

create index IDX_QRTZ_T_N_G_STATE
    on qrtz_triggers (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE)
go

create index IDX_QRTZ_T_N_STATE
    on qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE)
go

create index IDX_QRTZ_T_STATE
    on qrtz_triggers (SCHED_NAME, TRIGGER_STATE)
go


create function dbo.fristPinyin(
    @str nvarchar(max)
)
    returns nvarchar(max)
as
begin
    declare @word nchar(1),@PY nvarchar(max)

    set @PY = ''

    while len(@str) > 0
        begin
            set @word = left(@str, 1)

            --如果非汉字字符，返回原字符
            set @PY = @PY + (case
                                 when unicode(@word) between 19968 and 19968 + 20901
                                     then (select top 1 PY
                                           from (
                                                    select 'A' as PY, N'驁' as word
                                                    union all
                                                    select 'B', N'簿'
                                                    union all
                                                    select 'C', N'錯'
                                                    union all
                                                    select 'D', N'鵽'
                                                    union all
                                                    select 'E', N'樲'
                                                    union all
                                                    select 'F', N'鰒'
                                                    union all
                                                    select 'G', N'腂'
                                                    union all
                                                    select 'H', N'夻'
                                                    union all
                                                    select 'J', N'攈'
                                                    union all
                                                    select 'K', N'穒'
                                                    union all
                                                    select 'L', N'鱳'
                                                    union all
                                                    select 'M', N'旀'
                                                    union all
                                                    select 'N', N'桛'
                                                    union all
                                                    select 'O', N'漚'
                                                    union all
                                                    select 'P', N'曝'
                                                    union all
                                                    select 'Q', N'囕'
                                                    union all
                                                    select 'R', N'鶸'
                                                    union all
                                                    select 'S', N'蜶'
                                                    union all
                                                    select 'T', N'籜'
                                                    union all
                                                    select 'W', N'鶩'
                                                    union all
                                                    select 'X', N'鑂'
                                                    union all
                                                    select 'Y', N'韻'
                                                    union all
                                                    select 'Z', N'咗'
                                                ) T
                                           where word >= @word collate Chinese_PRC_CS_AS_KS_WS
                                           order by PY asc)
                                 else @word end)

            set @str = right(@str, len(@str) - 1)
        end

    return @PY
end
go

alter table h_biz_property add encryptOption bit null;

INSERT INTO base_security_client (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5, modifiedTime, modifier, remarks, accessTokenValiditySeconds, additionInformation, authorities, authorizedGrantTypes, autoApproveScopes, clientId, clientSecret, refreshTokenValiditySeconds, registeredRedirectUris, resourceIds, scopes, type)
VALUES ('8a5da52ed126447d359e70c05721a8aa', NULL, NULL, '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, '28800', 'API', 'api', 'authorization_code,implicit,password,refresh_token', 'read,write', 'api', '{noop}c31b32364ce19ca8fcd150a417ecce58', '28800', 'http://127.0.0.1/admin,http://127.0.0.1/admin#/oauth,http://127.0.0.1/oauth', 'api', 'read,write', 'APP');

INSERT INTO base_security_client (id,  deleted, accessTokenValiditySeconds, additionInformation, authorities, authorizedGrantTypes, autoApproveScopes, clientId, clientSecret, refreshTokenValiditySeconds, registeredRedirectUris, resourceIds, scopes, type)
VALUES ('52ed17238a5da59e71a8aa26447d0c05', '0', '3600', 'API', 'openapi', 'client_credentials', 'read,write', 'xclient', '{noop}0a417ecce58c31b32364ce19ca8fcd15', '3600', '', 'api', 'read,write', 'APP');

INSERT INTO h_org_user (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5, modifiedTime, modifier, remarks, active, admin, appellation, birthday, boss, departmentId, departureDate, dingtalkId, email, employeeNo, employeeRank, entryDate, gender, identityNo, imgUrl, leader, managerId, mobile, name, officePhone, password, username, privacyLevel, secretaryId, sortKey, sourceId, status, userId)
VALUES ('2c9280a26706a73a016706a93ccf002b', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, '2019-02-22 13:54:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1803c80ed28a3e25871d58808019816e', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', NULL, '{bcrypt}$2a$10$NvgvcocBqMn050z4nC0I6OeAhO5ERjM74pvMtSGLghPhWI5ed5myG', 'admin', NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO h_org_user (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5, modifiedTime, modifier, remarks, active, admin, appellation, birthday, boss, departmentId, departureDate, dingtalkId, email, employeeNo, employeeRank, entryDate, gender, identityNo, imgUrl, leader, managerId, mobile, name, officePhone, password, username, privacyLevel, secretaryId, sortKey, sourceId, status, userId)
VALUES ('2ccf3b346706a6d3016706dc51c0022b', '2019-06-05 19:30:30', NULL, '0', NULL, NULL, NULL, NULL, NULL, '2019-06-05 19:30:30', NULL, NULL, '1', '1', NULL, NULL, '0', '06ef8c9a3f3b6669a34036a3001e6340', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, '外部用户', NULL, '{bcrypt}$2a$10$NvgvcocBqMn050z4nC0I6OeAhO5ERjM74pvMtSGLghPhWI5ed5myG', 'xuser', NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO h_org_department (id, createdTime, creater, deleted, extend1, extend2, extend3, extend4, extend5, modifiedTime, modifier, remarks, calendarId, employees, leaf, managerId, name, parentId, sortKey, sourceId, queryCode)
VALUES ('06ef8c9a3f3b6669a34036a3001e6340', '2019-03-22 11:25:05', NULL, '0', '', '', NULL, NULL, NULL, '2019-05-14 13:44:21', NULL, NULL, NULL, NULL, '0', '', '外部', NULL, '0', NULL, '');

INSERT INTO h_org_dept_user (id, createdTime, creater, deleted, modifiedTime, modifier, remarks, deptId, main, userId)
VALUES ('07df8b34e4469a00169a36a336450cf3', '2019-03-22 11:25:07', NULL, '0','2019-03-22 11:25:07', NULL, NULL, '06ef8c9a3f3b6669a34036a3001e6340', NULL, '2ccf3b346706a6d3016706dc51c0022b');

INSERT INTO h_perm_admin (id, creater, createdTime, deleted, modifier, modifiedTime, remarks, adminType, dataManage, dataQuery, userId)
VALUES ('2c928a4c6c043e48016c04c108300a90', '2c928e4c6a4d1d87016a4d1f2f760048', '2019-9-6 10:23:15', '0', NULL, '2019-9-6 10:23:15', NULL, 'ADMIN', 1, 1, '2c9280a26706a73a016706a93ccf002b');

INSERT INTO h_system_setting(id, paramCode, paramValue, settingType, checked, fileUploadType) VALUES ('2c928e636f3fe9b5016f3feb81c70000', 'dingtalk.isSynEdu', 'false', 'DINGTALK_BASE', '0', NULL);

update h_related_corp_setting set enabled = 1 where id != '';
update h_org_user set enabled = 1 where id != '';
update h_org_department set enabled = 1 where id != '';

alter table h_app_package add groupId varchar(120) null ;

create table h_app_group
(
    id                          nvarchar(120) not null
        primary key,
    createdTime                 datetime,
    creater                     nvarchar(120),
    deleted                     bit,
    modifiedTime                datetime,
    modifier                    nvarchar(120),
    remarks                     nvarchar(200),
    code                        nvarchar(40) ,
    disabled                    bit,
    name                        nvarchar(50),
    sortKey                     int,
    name_i18n                   nvarchar(1000)
)
go

INSERT INTO h_app_group(id, createdTime, creater, deleted, modifiedTime, modifier, remarks, code, disabled, name, sortKey, name_i18n) VALUES ('2c928fe6785dbfbb01785dc6277a0000', '2021-03-23 14:29:31', '2c9280a26706a73a016706a93ccf002b', '0', '2021-03-23 14:29:31', NULL, NULL, 'default', NULL, '默认', 1, NULL);

create table h_org_direct_manager
(
    id           varchar(120)                           not null
        primary key,
    createdTime  datetime,
    creater      varchar(120),
    modifiedTime datetime,
    modifier     varchar(120),
    remarks      varchar(200),
    userId       varchar(36) not null,
    deptId       varchar(36)  not null,
    managerId    varchar(36)  not null,
    constraint uq_direct_user_dept
        unique (userId, deptId)
)
go

INSERT INTO h_app_group(id, createdTime, creater, deleted, modifiedTime, modifier, remarks, code, disabled, name, sortKey, name_i18n) VALUES ('2c928fe6785dbfbb01785dc6277a0001', '2021-04-26 17:50:31', '2c9280a26706a73a016706a93ccf002b', '0', '2021-04-26 17:50:31', NULL, NULL, 'all', NULL, '全部', 0, NULL);

update h_app_package set groupId='2c928fe6785dbfbb01785dc6277a0000' where groupId is null or groupId='';

ALTER TABLE h_biz_sheet add printJson ntext;
