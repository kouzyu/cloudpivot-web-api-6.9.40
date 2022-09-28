ALTER TABLE h_org_user ADD (imgUrlId VARCHAR(40) DEFAULT null);
comment on column h_org_user.imgUrlId is '头像id';

ALTER TABLE h_biz_query_condition ADD (dateType VARCHAR(40) DEFAULT null);
comment on column h_biz_query_condition.dateType is '日期快捷方式';