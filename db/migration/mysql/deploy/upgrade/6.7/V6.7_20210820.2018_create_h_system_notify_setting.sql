DROP TABLE IF EXISTS `h_system_notify_setting`;
CREATE TABLE `h_system_notify_setting` (
  `id` varchar(120) NOT NULL,
  `corpId` varchar(120) DEFAULT NULL,
  `unitType` varchar(20) DEFAULT NULL,
  `msgChannelType` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;