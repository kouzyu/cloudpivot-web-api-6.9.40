CREATE TABLE `h_system_sms_template` (
    `id` varchar(120) NOT NULL,
    `type` varchar(20) NOT NULL COMMENT '1待办、2催办、3事件通知',
    `code` varchar(20) NOT NULL COMMENT '模板编码',
    `name` varchar(40) NOT NULL COMMENT '模板名称',
    `content` text NOT NULL COMMENT '模板内容',
    `params` longtext DEFAULT NULL COMMENT '参数说明',
    `enabled` bit(1) DEFAULT NULL COMMENT '是否启用',
    `defaults` bit(1) DEFAULT NULL COMMENT '是否默认',
    `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
    `deleted` bit(1) DEFAULT NULL COMMENT '是否删除',
    `creater` varchar(120) DEFAULT NULL,
    `createdTime` datetime DEFAULT NULL,
    `modifier` varchar(120) DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `h_system_sms_template` VALUES ('2c928ff67de11137017de119dec601c2', 'TODO', 'Todo', '默认待办通知', '您有新的流程待处理，流程标题：${name}，请及时处理！', '[{\"key\":\"name\",\"value\":\"\"}]', b'1', b'1', NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `h_system_sms_template` VALUES ('2c928ff67de11137017de11d5b3001c4', 'URGE', 'Remind', '默认催办通知', '您的流程任务被人催办，流程标题：${name}，催办人${creater}，请及时处理！', '[{\"key\":\"name\",\"value\":\"流程的标题\"},{\"key\":\"creater\",\"value\":\"流程发起人\"}]', b'1', b'1', NULL, b'0', NULL, NULL, NULL, NULL);