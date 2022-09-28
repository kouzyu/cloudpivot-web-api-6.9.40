alter table H_ORG_ROLE_GROUP add parentId varchar(120);

comment on column H_ORG_ROLE_GROUP.parentId is '上一级角色组id';