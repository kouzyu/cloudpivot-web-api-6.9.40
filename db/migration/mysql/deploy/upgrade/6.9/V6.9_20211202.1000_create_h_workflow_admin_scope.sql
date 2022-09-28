CREATE TABLE `h_workflow_admin_scope`  (
  `id` varchar(120) NOT NULL,
  `createdTime` datetime(0) DEFAULT NULL,
  `creater` varchar(120) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `modifiedTime` datetime(0) DEFAULT NULL,
  `modifier` varchar(120) DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `adminId` varchar(120) DEFAULT NULL,
  `unitType` varchar(10) DEFAULT NULL,
  `unitId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_workflow_adminId`(`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;