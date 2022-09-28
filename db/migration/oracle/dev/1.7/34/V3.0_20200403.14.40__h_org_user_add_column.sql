ALTER TABLE h_org_user ADD (position varchar2(80) DEFAULT null);
comment on column h_org_user.position is '职位';

