ALTER TABLE h_org_user ADD (dingUserJson CLOB);
comment on column h_org_user.dingUserJson is '钉钉同步过来的json数据记录';