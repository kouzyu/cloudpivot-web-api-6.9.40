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
    startTime 		        date  		    null ,
    endTime 		        date  		    null ,
    message                 varchar2(4000)  null,
    taskStatus              varchar2(50)    null,
    exportResultStatus      varchar2(50)     null,
    userId                  varchar2(36)     null,
    path                     varchar2(120)   null
);