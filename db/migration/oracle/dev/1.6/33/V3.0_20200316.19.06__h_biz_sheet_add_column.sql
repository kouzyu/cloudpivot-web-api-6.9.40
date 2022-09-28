ALTER TABLE h_biz_sheet ADD (formComment number(1,0) DEFAULT 0);
comment on column h_biz_sheet.formComment is '是否开启表单评论';