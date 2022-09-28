
CREATE TABLE IF NOT EXISTS `h_system_pair` (
  `id` varchar(120) NOT NULL,
  `paramCode` varchar(200) DEFAULT NULL,
  `pairValue` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_9tviae6s7glway1kpyiybg4yp` (`paramCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;