
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