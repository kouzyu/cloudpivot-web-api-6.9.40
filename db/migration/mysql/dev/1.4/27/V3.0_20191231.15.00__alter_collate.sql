ALTER TABLE `h_system_pair`
MODIFY COLUMN `paramCode`  varchar(200) BINARY CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL AFTER `id`;