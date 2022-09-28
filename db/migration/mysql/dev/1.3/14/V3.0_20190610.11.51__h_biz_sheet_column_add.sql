ALTER TABLE `h_biz_sheet` ADD COLUMN `draftHtmlJson` longtext DEFAULT NULL COMMENT '草稿在线设计与编辑json';
ALTER TABLE `h_biz_sheet` ADD COLUMN `publishedHtmlJson` longtext DEFAULT NULL COMMENT '发布在线设计与编辑json';
ALTER TABLE `h_biz_sheet` ADD COLUMN `draftActionsJson` longtext DEFAULT NULL COMMENT '草稿在线设计与编辑按钮json';
ALTER TABLE `h_biz_sheet` ADD COLUMN `publishedActionsJson` longtext DEFAULT NULL COMMENT '发布在线设计与编辑j按钮json';