CREATE TABLE `h_biz_database_pool` (
    `id` varchar(120) NOT NULL,
    `creater` varchar(120) DEFAULT NULL,
    `createdTime` datetime DEFAULT NULL,
    `deleted` bit(1) DEFAULT NULL,
    `modifier` varchar(120) DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    `remarks` varchar(200) DEFAULT NULL,
    `code` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '数据库连接池编码',
    `name` varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT '数据库连接池名称',
    `description` varchar(2000) DEFAULT NULL COMMENT '描述',
    `databaseType` varchar(15) NOT NULL COMMENT '数据库类型',
    `jdbcUrl` varchar(200) DEFAULT NULL COMMENT '数据库连接串',
    `username` varchar(40) DEFAULT NULL COMMENT '账号',
    `password` varchar(40) DEFAULT NULL COMMENT '密码',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务数据库连接池';
