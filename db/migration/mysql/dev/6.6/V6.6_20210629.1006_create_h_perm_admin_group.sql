CREATE TABLE `h_perm_admin_group` (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `departmentsJson` longtext,
  `name` varchar(50) DEFAULT NULL,
  `appPackagesJson` longtext,
  `adminId` varchar(120) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

