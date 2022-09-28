DROP TABLE IF EXISTS `h_biz_perm_group`;
CREATE TABLE `h_biz_perm_group` (
  `id` varchar(120) NOT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `createdTime` datetime DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `enabled` bit(1) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `name_i18n` varchar(1000) DEFAULT NULL,
  `roles` longtext,
  `schemaCode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
