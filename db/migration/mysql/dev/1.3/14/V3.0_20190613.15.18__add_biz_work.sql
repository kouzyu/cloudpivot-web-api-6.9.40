 -- ----------------------------
-- Table structure for biz_work_record
 -- ----------------------------
CREATE TABLE IF NOT EXISTS `h_im_work_record`(
`id` varchar(36) NOT NULL  ,
  `workitemId` varchar(36) NOT NULL ,
  `recordId` varchar(36) NOT NULL,
  `requestId` varchar(36) NOT NULL,
  `receivers` longtext ,
  `title` varchar(100) DEFAULT NULL  ,
  `content` varchar(200) DEFAULT NULL  ,
  `url` varchar(500) DEFAULT NULL  ,
  `receiveTime` datetime DEFAULT NULL  ,
  `tryTimes` int(36) DEFAULT NULL ,
  `failRetry` varchar(200) DEFAULT NULL ,
  `messageType` varchar(200) DEFAULT NULL  ,
  `failUserRetry` bit(1) DEFAULT NULL,
  `WorkRecordStatus` varchar(40) NOT NULL ,
  `bizParams` longtext ,
  `createdTime` datetime DEFAULT NULL  ,
  `modifiedTime` datetime DEFAULT NULL ,
  PRIMARY KEY (`id`),
  KEY `I_RecordId` (`recordId`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待办事项表';

-- ----------------------------
-- Table structure for biz_work_record_history
-- ----------------------------
CREATE TABLE IF NOT EXISTS `h_im_work_record_history`(

--   `id` varchar(36) NOT NULL COMMENT '待办事项表id',
   `taskId` varchar(36) NOT NULL COMMENT '待办事项历史任务id',
    `id` varchar(36) NOT NULL  ,
  `workitemId` varchar(36) NOT NULL ,
  `recordId` varchar(36) NOT NULL,
  `requestId` varchar(36) NOT NULL,
  `receivers` longtext ,
  `title` varchar(100) DEFAULT NULL  ,
  `content` varchar(200) DEFAULT NULL  ,
  `url` varchar(500) DEFAULT NULL  ,
  `receiveTime` datetime DEFAULT NULL  ,
  `tryTimes` int(36) DEFAULT NULL ,
  `failRetry` varchar(200) DEFAULT NULL ,
  `messageType` varchar(200) DEFAULT NULL  ,
  `failUserRetry` bit(1) DEFAULT NULL,
  `WorkRecordStatus` varchar(40) NOT NULL,
  `bizParams` longtext,
  `createdTime` datetime DEFAULT NULL  ,
  `modifiedTime` datetime DEFAULT NULL ,
  PRIMARY KEY (`id`),
  KEY `I_RecordId` (`recordId`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待办事项历史纪录表';