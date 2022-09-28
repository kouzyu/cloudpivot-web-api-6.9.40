DROP TABLE IF EXISTS `h_biz_data_rule`;
CREATE TABLE `h_biz_data_rule`  (
  `id` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `creater` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createdTime` datetime(0) NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT NULL,
  `modifier` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modifiedTime` datetime(0) NULL DEFAULT NULL,
  `remarks` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `schemaCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `propertyCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `options` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `dataRuleType` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `checkType` int(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据规则' ROW_FORMAT = Dynamic;
