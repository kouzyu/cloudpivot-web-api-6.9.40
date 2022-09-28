DROP TABLE IF EXISTS `h_biz_batch_update_record`;
CREATE TABLE `h_biz_batch_update_record`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schemaCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `propertyCode` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userId` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modifiedTime` datetime(0) NULL DEFAULT NULL,
  `propertyName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `total` int(10) NULL DEFAULT NULL,
  `successCount` int(10) NULL DEFAULT NULL,
  `failCount` int(10) NULL DEFAULT NULL,
  `modifiedValue` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '列表数据批量修改记录' ROW_FORMAT = Dynamic;


ALTER table h_perm_biz_function add column batchUpdateAble bit(1) default null comment '批量修改';