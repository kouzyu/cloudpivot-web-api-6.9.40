ALTER TABLE `h_perm_admin`
ADD COLUMN `parentId` varchar(120) COLLATE utf8_bin NULL COMMENT '基于哪个创建的' AFTER `userId`;
