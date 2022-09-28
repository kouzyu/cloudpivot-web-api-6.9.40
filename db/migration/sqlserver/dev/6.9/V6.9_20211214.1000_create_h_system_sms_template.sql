CREATE TABLE h_system_sms_template (
    id nvarchar(120) NOT NULL primary key,
    type nvarchar(20) NOT NULL,
    code nvarchar(20) NOT NULL,
    name nvarchar(40) NOT NULL,
    content ntext NOT NULL,
    params ntext DEFAULT NULL,
    enabled bit DEFAULT NULL,
    defaults bit DEFAULT NULL,
    remarks nvarchar(200) DEFAULT NULL,
    deleted bit DEFAULT NULL,
    creater nvarchar(120) DEFAULT NULL,
    createdTime datetime DEFAULT NULL,
    modifier nvarchar(120) DEFAULT NULL,
    modifiedTime datetime DEFAULT NULL
)
go

INSERT INTO h_system_sms_template VALUES ('2c928ff67de11137017de119dec601c2', 'TODO', 'Todo', '默认待办通知', '您有新的流程待处理，流程标题：${name}，请及时处理！', '[{\"key\":\"name\",\"value\":\"\"}]', '1', '1', NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO h_system_sms_template VALUES ('2c928ff67de11137017de11d5b3001c4', 'URGE', 'Remind', '默认催办通知', '您的流程任务被人催办，流程标题：${name}，催办人${creater}，请及时处理！', '[{\"key\":\"name\",\"value\":\"流程的标题\"},{\"key\":\"creater\",\"value\":\"流程发起人\"}]', '1', '1', NULL, '0', NULL, NULL, NULL, NULL);