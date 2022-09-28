CREATE TABLE h_related_corp_setting (
                                        id varchar2(120)  NOT NULL   primary key,
                                        creater varchar2(120)  DEFAULT NULL,
                                        createdTime date DEFAULT NULL,
                                        deleted number(1, 0) DEFAULT NULL,
                                        modifier varchar2(120)  DEFAULT NULL,
                                        modifiedTime date DEFAULT NULL,
                                        remarks varchar2(200)  DEFAULT NULL,
                                        agentId varchar2(120)  DEFAULT NULL,
                                        appSecret varchar2(120)  DEFAULT NULL,
                                        appkey varchar2(120)  DEFAULT NULL,
                                        corpId varchar2(120)  DEFAULT NULL,
                                        corpSecret varchar2(120)  DEFAULT NULL,
                                        exportHost varchar2(36)  DEFAULT NULL,
                                        extend1 varchar2(120)  DEFAULT NULL,
                                        extend2 varchar2(120)  DEFAULT NULL,
                                        extend3 varchar2(120)  DEFAULT NULL,
                                        extend4 varchar2(120)  DEFAULT NULL,
                                        extend5 varchar2(120)  DEFAULT NULL,
                                        headerNum int DEFAULT NULL,
                                        name varchar2(240)  DEFAULT NULL,
                                        orgType varchar2(12)  DEFAULT NULL,
                                        relatedType varchar2(12)  DEFAULT NULL,
                                        scanAppId varchar2(120)  DEFAULT NULL,
                                        scanAppSecret varchar2(200)  DEFAULT NULL,
                                        redirectUri varchar2(200)  DEFAULT NULL,
                                        synRedirectUri varchar2(120)  DEFAULT NULL,
                                        pcServerUrl varchar2(120)  DEFAULT NULL,
                                        mobileServerUrl varchar2(120)  DEFAULT NULL,
                                        syncType varchar2(12)  DEFAULT NULL
);

ALTER TABLE h_org_department ADD (corpId VARCHAR2(256) DEFAULT null);
ALTER TABLE h_org_department_history ADD (corpId VARCHAR2(256) DEFAULT null);

ALTER TABLE h_org_user ADD (corpId VARCHAR2(256) DEFAULT null);
comment on column h_org_user.corpId is '用户新增组织外键关联';

ALTER TABLE h_org_role_group ADD (corpId VARCHAR2(256) DEFAULT null);
comment on column h_org_role_group.corpId is '角色组新增组织外键关联';

ALTER TABLE h_org_role ADD (corpId VARCHAR(256) DEFAULT null);
comment on column h_org_role.corpId is '角色新增组织外键关联';

CREATE TABLE h_org_synchronize_log (
                                       id varchar2(120)  NOT NULL   primary key,
                                       targetType varchar2(30)  DEFAULT NULL,
                                       trackId varchar2(60)  DEFAULT NULL,
                                       targetId varchar2(120)  DEFAULT NULL,
                                       errorType varchar2(1000)  DEFAULT NULL
);

ALTER TABLE h_biz_sheet ADD (formComment number(1,0) DEFAULT 0);
comment on column h_biz_sheet.formComment is '是否开启表单评论';


ALTER TABLE H_ORG_DEPARTMENT DROP CONSTRAINT UK_h_org_department_sourceId;

ALTER TABLE H_ORG_ROLE DROP CONSTRAINT UK_h_org_role_sourceId;

create table h_biz_export_task
(
    id                     varchar2(36) not null
        primary key,
    createdTime             date            null,
    creater                 varchar2(120)   null,
    deleted                 number(1, 0)    null,
    modifiedTime            date            null,
    modifier                varchar2(120)   null,
    remarks                 varchar2(200)   null,
    startTime 		        date  		    null ,
    endTime 		        date  		    null ,
    message                 varchar2(4000)  null,
    taskStatus              varchar2(50)    null,
    exportResultStatus      varchar2(50)     null,
    userId                  varchar2(36)     null,
    path                     varchar2(120)   null
);

-- 删除部门用户关联重复项 保留最旧的记录
delete from h_org_dept_user where id in(
    select a.id from (
                         select hodu.id from h_org_dept_user hodu where hodu.id in(
                             select a.id from h_org_dept_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) as num,a.deptId,a.userId,MIN(a.createdTime) from h_org_dept_user a GROUP BY a.deptId,a.userId having count(a.userId) > 1
                                              ) b on a.deptId = b.deptId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_dept_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.deptId,a.userId,MIN(a.createdTime) minTime from h_org_dept_user a GROUP BY a.deptId,a.userId having count(a.userId) > 1
                                               ) b on a.deptId = b.deptId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);
-- 建立部门用户联合唯一索引
DROP INDEX idx_dept_user_composeid;

alter table h_org_dept_user add constraint idx_dept_user_composeid unique(userId,deptId);

-- 删除角色用户关联重复项 保留最旧的记录
delete from h_org_role_user where id in(
    select a.id from (
                         select hodu.id from h_org_role_user hodu where hodu.id in(
                             select a.id from h_org_role_user a
                                                  LEFT JOIN
                                              (
                                                  select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) from h_org_role_user a GROUP BY a.roleId,a.userId having count(a.userId) > 1
                                              ) b on a.roleId = b.roleId and a.userId = b.userId
                             where b.num is not null
                         ) and hodu.id not in(
                             select  a.id from h_org_role_user a
                                                   LEFT JOIN
                                               (
                                                   select count(a.userId) num,a.roleId,a.userId,MIN(a.createdTime) minTime from h_org_role_user a GROUP BY a.roleId,a.userId having count(a.userId) > 1
                                               ) b on a.roleId = b.roleId and a.userId = b.userId and a.createdTime = b.minTime
                             where b.num is not null
                         )
                     ) a
);

-- 建立角色用户联合唯一索引
alter table h_org_role_user add constraint idx_role_user_composeid unique(userId,roleId);



update d_process_task hpt set hpt.userId = (select hou.id from h_org_user hou where hpt.userId = hou.userId)
where exists (select userId from h_org_user hou where hou.userId = hpt.userId);

update d_process_instance hpi set hpi.originator = (select hou.id from h_org_user hou where hpi.originator = hou.userId)
where exists (select hou.userId from h_org_user hou where hou.userId = hpi.originator);


-- ALTER TABLE h_biz_sheet MODIFY COLUMN tempAuthSchemaCodes varchar2(3500) DEFAULT NULL;

ALTER TABLE h_biz_sheet MODIFY  (tempAuthSchemaCodes varchar2(3500));