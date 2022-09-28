ALTER TABLE h_biz_query_condition ADD (dateType VARCHAR(40) DEFAULT null)
comment on column h_biz_query_condition.dateType is '日期快捷方式';