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
