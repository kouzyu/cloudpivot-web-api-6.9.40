CREATE TABLE `h_biz_object_relation` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `srcSc` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '源模型编码',
  `srcId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '源i表id',
  `srcParentSc` varchar(42) COLLATE utf8_bin DEFAULT NULL,
  `srcParentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '如果srcSchemaCode是子表，则此字段是主表的id',
  `targetSc` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '目标模型编码',
  `targetId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '目标i表id',
  `targetParentSc` varchar(42) COLLATE utf8_bin DEFAULT NULL,
  `targetParentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '如果targetSchemaCode是子表，则此字段是主表的id',
  `createTime` datetime NOT NULL,
  `sortBy` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sc_id` (`targetSc`,`targetId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='两个i表数据的关联关系，source-->target : 1->N';


ALTER TABLE `biz_workitem` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_workitem_finished` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_circulateitem` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';
ALTER TABLE `biz_circulateitem_finished` ADD COLUMN `sortKey` bigint(20) NOT NULL DEFAULT '0' COMMENT '同一批任务的排序';


ALTER TABLE `h_biz_property`
ADD COLUMN `repeated`  int NULL DEFAULT 0 COMMENT '去重属性：1开启0不开启' AFTER `relativeQuoteCode`;