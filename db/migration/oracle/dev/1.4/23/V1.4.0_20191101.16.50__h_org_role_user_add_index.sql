-- 角色用户关联表联合索引
CREATE INDEX idx_role_user_sourceid ON h_org_role_user(userSourceId,roleSourceId);

-- 部门用户关联表联合索引
CREATE INDEX idx_dept_user_composeid ON h_org_dept_user(userId,deptId);