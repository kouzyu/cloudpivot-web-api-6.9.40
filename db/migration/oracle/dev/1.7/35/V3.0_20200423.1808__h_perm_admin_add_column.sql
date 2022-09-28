ALTER TABLE h_perm_admin ADD (parentId varchar2(120) DEFAULT null);
comment on column h_perm_admin.parentId is '基于哪个创建的';