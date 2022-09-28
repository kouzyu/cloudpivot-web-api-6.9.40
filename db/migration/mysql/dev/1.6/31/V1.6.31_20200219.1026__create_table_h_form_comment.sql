CREATE TABLE `h_form_comment` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `content` varchar(3000) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '评论内容',
  `commentator` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '评论人id',
  `commentatorName` varchar(80) CHARACTER SET utf8mb4 NOT NULL COMMENT '评论人名称',
  `departmentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '评论人部门id',
  `schemaCode` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '模型编码',
  `bizObjectId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '表单id',
  `replyCommentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '被回复的评论id',
  `replyUserId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '被回复的用户id',
  `replyUserName` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '被回复的用户名称',
  `originCommentId` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '最原始的评论id',
  `floor` int(11) NOT NULL DEFAULT '0' COMMENT '评论层级，最原始评论从0开始',
  `state` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'ENABLED' COMMENT '评论状态，可用：ENABLED；禁用：DISABLED；',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被删除，0：否；1：是',
  `attachmentNum` int(11) NOT NULL DEFAULT '0' COMMENT '附件数量',
  `modifier` varchar(42) COLLATE utf8_bin DEFAULT NULL COMMENT '删除/更新用户id',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `modifiedTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '删除/更新时间',
  PRIMARY KEY (`id`),
  KEY `IDX_FORM_OBJ_ID` (`bizObjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表单评论表';

CREATE TABLE `h_from_comment_attachment` (
  `id` varchar(42) COLLATE utf8_bin NOT NULL,
  `bizObjectId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '表单id',
  `schemaCode` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '模型编码',
  `commentId` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '评论id',
  `fileExtension` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '文件后缀名',
  `fileSize` int(11) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimeType` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '文件媒体类型',
  `name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '文件名称，带后缀',
  `refId` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '上传到文件系统的文件id',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上传时间',
  `creater` varchar(42) COLLATE utf8_bin NOT NULL COMMENT '上传用户id',
  PRIMARY KEY (`id`),
  KEY `IDX_F_C_A_COMM_ID` (`commentId`),
  KEY `IDX_F_C_A_REF_ID` (`refId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表单评论附件表';
