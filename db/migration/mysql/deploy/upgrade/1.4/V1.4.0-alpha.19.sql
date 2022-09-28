ALTER TABLE `h_biz_rule` ADD COLUMN `dataConditionJoinType` varchar(40) DEFAULT NULL COMMENT '触发数据条件连接类型';

ALTER TABLE `h_biz_rule` ADD COLUMN `dataConditionJson` longtext COMMENT '数据条件json';

ALTER TABLE `h_perm_group` ADD COLUMN `authorType` varchar(40) DEFAULT NULL COMMENT ' 授权类型';


ALTER TABLE `h_org_user` ADD COLUMN `pinYin` VARCHAR(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名拼音';
ALTER TABLE `h_org_user` ADD COLUMN `shortPinYin` VARCHAR(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名简拼';

ALTER TABLE `h_app_package` ADD COLUMN `appNameSpace` varchar(40) DEFAULT NULL COMMENT '应用命名空间';

ALTER TABLE h_perm_function_condition MODIFY COLUMN `value` LONGTEXT;

create table h_open_api_event
(
	id varchar(120) not null
		primary key,
	callback varchar(400) null comment '回调地址',
	clientId varchar(30) null comment '客户端编号',
	eventTarget varchar(300) null comment '事件对象',
	eventTargetType varchar(255) null comment '事件对象类型',
	eventType varchar(255) null comment '事件触发类型'
);

update h_biz_query_column set `name` = '拥有者' where propertyCode = 'owner';
update h_biz_query_column set `name` = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_query_condition set `name` = '拥有者' where propertyCode = 'owner';
update h_biz_query_condition set `name` = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_property set `name` = '拥有者' where code = 'owner';
update h_biz_property set `name` = '拥有者部门' where code = 'ownerDeptId';

CREATE TABLE `h_access_token` (
  `id` varchar(40) COLLATE utf8_bin NOT NULL,
  `userId` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `leastUse` tinyint(1) DEFAULT NULL,
  `accessToken` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access_token_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
