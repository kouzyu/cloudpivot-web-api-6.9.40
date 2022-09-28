CREATE TABLE `h_related_corp_setting` (
    `id` varchar(120)  NOT NULL,
    `creater` varchar(120)  DEFAULT NULL,
    `createdTime` datetime DEFAULT NULL,
    `deleted` bit(1) DEFAULT NULL,
    `modifier` varchar(120)  DEFAULT NULL,
    `modifiedTime` datetime DEFAULT NULL,
    `remarks` varchar(200)  DEFAULT NULL,
    `agentId` varchar(120)  DEFAULT NULL,
    `appSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL,
    `appkey` varchar(120)  DEFAULT NULL,
    `corpId` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织的corpId',
    `corpSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织的corpSecret',
    `exportHost` varchar(32) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '多机器转发的地址',
    `extend1` varchar(120)  DEFAULT NULL,
    `extend2` varchar(120)  DEFAULT NULL,
    `extend3` varchar(120)  DEFAULT NULL,
    `extend4` varchar(120)  DEFAULT NULL,
    `extend5` varchar(120)  DEFAULT NULL,
    `headerNum` int(11) NOT NULL COMMENT ' 企业标记，用于部门sourceid',
    `name` varchar(64) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '公司名称',
    `orgType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '第三方类型',
    `relatedType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '组织类型',
    `scanAppId` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '扫码登录appid',
    `scanAppSecret` varchar(120) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '扫码登录Secret',
    `redirectUri` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '登录回调地址',
    `synRedirectUri` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '增量回调地址',
    `pcServerUrl` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT 'pc端地址',
    `mobileServerUrl` varchar(128) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '手机端地址',
    `syncType` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '同步方式',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_ci;


-- 用户新增组织外键关联
ALTER TABLE `h_org_user`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 角色组新增组织外键关联
ALTER TABLE `h_org_role_group`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 角色新增组织外键关联
ALTER TABLE `h_org_role`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 部门新增组织外键关联
ALTER TABLE `h_org_department`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;
-- 部门历史新增组织外键关联
ALTER TABLE `h_org_department_history`
    ADD COLUMN `corpId` varchar(256) NULL DEFAULT NULL;

CREATE TABLE IF NOT EXISTS `h_org_synchronize_log`(
  `id` varchar(120) NOT NULL,
  `targetType` varchar(30) DEFAULT NULL COMMENT '同步类型 部门|用户|角色|某个部门|某个角色用户',
  `trackId` varchar(60) DEFAULT NULL COMMENT '同步批次',
  `targetId` varchar(120) DEFAULT NULL COMMENT '目标源数据',
  `errorType` varchar(1000) DEFAULT NULL COMMENT '错误原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `h_biz_sheet` ADD COLUMN `formComment` bit(1) DEFAULT 0 COMMENT '是否开启表单评论';

-- 部门
ALTER TABLE `h_org_department` DROP INDEX `UK_m8jlxslrsucu3y6dv1lb1s5jf`;

-- 用户
ALTER TABLE `h_org_user` DROP INDEX `UK_phr7by4273l3804n3xc2gq15o`;

-- 角色
ALTER TABLE `h_org_role` DROP INDEX `UK_itk9w9ftn6a2vn5o8c7n83ymc`;

CREATE TABLE `h_biz_export_task` (
    `id` varchar(36) COLLATE utf8_bin NOT NULL COMMENT 'primary key',
    `startTime` datetime DEFAULT NULL COMMENT '开始时间',
    `endTime` datetime DEFAULT NULL COMMENT '结束时间',
    `message` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '失败信息',
    `taskStatus` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '任务状态',
    `syncResult` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '同步结果',
    `userId` varchar(36) COLLATE utf8_bin DEFAULT NULL COMMENT '谁同步的',
    `createdTime` datetime DEFAULT NULL COMMENT '生成时间',
    `creater` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
    `deleted` bit(1) DEFAULT NULL COMMENT '是否删除',
    `modifiedTime` datetime DEFAULT NULL COMMENT '修改时间' ,
    `modifier` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '修改者',
    `remarks` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `h_biz_export_task` CHANGE `syncResult` `exportResultStatus` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '同步结果';

ALTER TABLE `h_biz_export_task` ADD COLUMN `path` varchar(120) DEFAULT NULL COMMENT '文件路径';

-- 删除部门用户关联重复项 保留最旧的记录
delete from h_org_dept_user where id in(
    select a.id from (
                         select hodu.id from h_org_dept_user hodu where hodu.id in(
                             select a.id from h_org_dept_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) num,a.deptId,a.userId,MIN(a.createdTime) from h_org_dept_user a GROUP BY a.deptId,a.userId having num > 1
                                              ) b on a.deptId = b.deptId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_dept_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.deptId,a.userId,MIN(a.createdTime) minTime from h_org_dept_user a GROUP BY a.deptId,a.userId having num > 1
                                               ) b on a.deptId = b.deptId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);
-- 建立部门用户联合唯一索引
ALTER TABLE `h_org_dept_user`
DROP INDEX `idx_dept_user_composeid`,
    ADD UNIQUE INDEX `idx_dept_user_composeid`(`userId`, `deptId`) USING BTREE;

-- 删除角色用户关联重复项 保留最旧的记录
delete from h_org_role_user where id in(
    select a.id from (
                         select hodu.id from h_org_role_user hodu where hodu.id in(
                             select a.id from h_org_role_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) from h_org_role_user a GROUP BY a.roleId,a.userId having num > 1
                                              ) b on a.roleId = b.roleId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_role_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) minTime from h_org_role_user a GROUP BY a.roleId,a.userId having num > 1
                                               ) b on a.roleId = b.roleId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);

-- 建立角色用户联合唯一索引
ALTER TABLE `h_org_role_user` ADD UNIQUE INDEX `idx_role_user_composeid`(`userId`, `roleId`) USING BTREE;


-- 字段调整为用户主键
update d_process_task,h_org_user set d_process_task.userId = h_org_user.id where h_org_user.userId = d_process_task.userId;

update d_process_instance,h_org_user set d_process_instance.originator = h_org_user.id where h_org_user.userId = d_process_instance.originator;


DROP PROCEDURE IF EXISTS updateCorpIdIsNull;

DELIMITER &&

CREATE PROCEDURE updateCorpIdIsNull()
BEGIN

    DECLARE MY_CORPID VARCHAR(50);
    DECLARE IS_CLOUD_PIVOT VARCHAR(50);

    SET MY_CORPID = (select hss.paramValue from h_system_setting hss where hss.paramCode = 'dingtalk.client.corpId');
    if MY_CORPID is not null then
    update h_org_user set corpId = MY_CORPID where corpId is null;
    update h_org_department set corpId = MY_CORPID where corpId is null;
    update h_org_role set corpId = MY_CORPID where corpId is null;
    update h_org_role_group set corpId = MY_CORPID where corpId is null;
    else
    SET IS_CLOUD_PIVOT = (select hss.paramValue from h_system_setting hss where hss.paramCode = 'cloudpivot.load.is_cloud_pivot');
    if IS_CLOUD_PIVOT = '1' then
        update h_org_user set corpId = 'main' where corpId is null;
        update h_org_department set corpId = 'main' where corpId is null;
        update h_org_role set corpId = 'main' where corpId is null;
        update h_org_role_group set corpId = 'main' where corpId is null;
    end if;
end if;

END &&

DELIMITER ;

CALL updateCorpIdIsNull();


ALTER TABLE `h_biz_sheet` MODIFY COLUMN `tempAuthSchemaCodes` varchar(3500) DEFAULT NULL COMMENT '临时授权的SchemaCode 以,分割';