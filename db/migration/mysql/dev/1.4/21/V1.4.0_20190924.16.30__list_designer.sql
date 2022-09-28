CREATE TABLE `h_biz_query_present` (
   `id` varchar(120) COLLATE utf8_bin NOT NULL,
   `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL,
   `createdTime` datetime DEFAULT NULL,
   `deleted` bit(1) DEFAULT NULL,
   `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL,
   `modifiedTime` datetime DEFAULT NULL,
   `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL,
   `queryId` varchar(36) COLLATE utf8_bin DEFAULT NULL,
   `schemaCode` varchar(40) COLLATE utf8_bin DEFAULT NULL,
   `clientType` varchar(40) DEFAULT NULL COMMENT 'PC或者MOBILE端',
   `htmlJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表htmlJson数据',
   `actionsJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表action操作JSON数据',
   `columnsJson` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列表展示字段columnJSON数据',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



ALTER TABLE `h_biz_query` ADD COLUMN `queryPresentationType` varchar(40) DEFAULT 'LIST' COMMENT '列表视图类型';

ALTER TABLE `h_biz_query` ADD COLUMN `showOnPc` bit(1) DEFAULT NULL COMMENT 'PC是否可见';

ALTER TABLE `h_biz_query` ADD COLUMN `showOnMobile` bit(1) DEFAULT NULL COMMENT '移动端是否可见';

ALTER TABLE `h_biz_query` ADD COLUMN `publish` bit(1) DEFAULT NULL COMMENT '发布状态';

ALTER TABLE `h_biz_query_column` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_condition` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_sorter` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';

ALTER TABLE `h_biz_query_action` ADD COLUMN `clientType` varchar(40) DEFAULT 'PC' COMMENT 'PC或者MOBILE端';