alter table h_perm_admin_group ADD externalLinkVisible NUMBER(1,0) DEFAULT (1) NOT NULL ;
comment ON COLUMN h_perm_admin_group.externalLinkVisible IS '是否可查看外链';