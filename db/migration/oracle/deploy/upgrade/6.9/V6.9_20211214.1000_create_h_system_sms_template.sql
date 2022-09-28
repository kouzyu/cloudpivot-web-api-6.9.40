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