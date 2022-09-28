
alter table H_BIZ_SCHEMA add MODELTYPE varchar2(120);
comment on column H_BIZ_SCHEMA.MODELTYPE is '模型类型 LIST/TREE';