DROP TABLE IF EXISTS `h_app_group`;
CREATE TABLE `h_app_group`  (
  `id` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createdTime` datetime(0) NULL DEFAULT NULL,
  `creater` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT NULL,
  `modifiedTime` datetime(0) NULL DEFAULT NULL,
  `modifier` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remarks` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `code` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `disabled` bit(1) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sortKey` int(11) NULL DEFAULT NULL,
  `name_i18n` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '双语言',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO `h_app_group`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `remarks`, `code`, `disabled`, `name`, `sortKey`, `name_i18n`) VALUES ('2c928fe6785dbfbb01785dc6277a0000', '2021-03-23 14:29:31', '2c9280a26706a73a016706a93ccf002b', b'0', '2021-03-23 14:29:31', NULL, NULL, 'default', NULL, '默认', 1, NULL);
