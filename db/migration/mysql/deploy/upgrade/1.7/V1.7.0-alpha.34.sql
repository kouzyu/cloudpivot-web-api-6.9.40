ALTER TABLE `biz_workitem` ADD COLUMN `isTrust` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托，0：否；1：是';
ALTER TABLE `biz_workitem` ADD COLUMN `trustor` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人ID';
ALTER TABLE `biz_workitem` ADD COLUMN `trustorName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人名称';

ALTER TABLE `biz_workitem_finished` ADD COLUMN `isTrust` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托，0：否；1：是';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `trustor` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人ID';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `trustorName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托人名称';

ALTER TABLE `biz_workflow_instance` ADD COLUMN `isTrustStart` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被委托发起，0：否；1：是';
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trustee` varchar(42) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人ID';
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trusteeName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被委托人名称';


CREATE TABLE `h_workflow_trust` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `workflowTrustRuleId` varchar(42) COLLATE utf8_bin NOT NULL,
    `workflowCode` varchar(40) COLLATE utf8_bin NOT NULL,
    `creater` varchar(42) COLLATE utf8_bin DEFAULT NULL,
    `createTime` datetime DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `IDX_PROXY_RULE_WFCODE` (`workflowTrustRuleId`,`workflowCode`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='流程委托表';

CREATE TABLE `h_workflow_trust_rule` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `trustor` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '委托人id',
    `trustorName` varchar(80) CHARACTER SET utf8mb4 NOT NULL COMMENT '委托人名称',
    `trustee` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '受托人id',
    `trusteeName` varchar(80) CHARACTER SET utf8mb4 NOT NULL COMMENT '受托人名称',
    `trustType` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '委托类型，流程审批：APPROVAL；流程发起：START',
    `startTime` datetime DEFAULT NULL COMMENT '委托开始时间',
    `endTime` datetime DEFAULT NULL COMMENT '委托结束时间',
    `rangeType` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '委托范围类型，全部：ALL；部分：PART',
    `state` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '委托规则状态，RUN;STOP',
    `creater` varchar(42) COLLATE utf8_bin DEFAULT NULL,
    `createTime` datetime DEFAULT NULL,
    `modifier` varchar(42) COLLATE utf8_bin DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `IDX_WF_TRUSTOR` (`trustor`),
    KEY `IDX_WF_TRUSTEE` (`trustee`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='流程、任务委托规则';


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


ALTER TABLE `biz_workflow_instance` DROP COLUMN `isTrustStart`;
ALTER TABLE `biz_workflow_instance` ADD COLUMN `trustType` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '委托类型，流程审批：APPROVAL；流程发起：START';

ALTER TABLE `h_org_user` ADD COLUMN `position` varchar(80) DEFAULT NULL COMMENT '职位';


ALTER TABLE `h_perm_biz_function` ADD COLUMN `editOwnerAble` BIT(1) DEFAULT NULL COMMENT '更新拥有者';

CREATE TABLE `h_log_synchro` (
    `id` varchar(42) COLLATE utf8_bin NOT NULL,
    `trackId` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '同步批次',
    `creater` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
    `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
    `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步开始时间',
    `endTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步结束时间',
    `fixer` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '修复人',
    `fixedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新的修复时间',
    `fixedCount` int(11) NOT NULL DEFAULT 0 COMMENT '修复次数',
    `fixNotes` varchar(1000) CHARACTER SET utf8mb4 NOT NULL COMMENT '修复说明',
    `fixedStatus` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '修复状态',
    `executeStatus` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '执行状态',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='组织同步操作日志';

ALTER TABLE `h_org_synchronize_log` ADD COLUMN `corpId` varchar(120) DEFAULT NULL COMMENT '组织corpId';

ALTER TABLE `h_org_synchronize_log` ADD COLUMN `status` varchar(40) DEFAULT NULL COMMENT '状态';


ALTER TABLE `h_biz_database_pool` MODIFY `password` varchar(300)  DEFAULT NULL ;


ALTER TABLE `h_biz_property`
    ADD INDEX `Idx_schemaCode` (`schemaCode`) USING BTREE ;

ALTER TABLE `h_biz_schema`
    ADD INDEX `idx_schemaCode` (`code`) USING BTREE ;
