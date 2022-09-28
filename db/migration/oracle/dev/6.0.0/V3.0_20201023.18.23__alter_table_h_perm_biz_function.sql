ALTER TABLE h_perm_biz_function ADD (batchPrintAble number(1,0) DEFAULT 0);
comment on column h_perm_biz_function.batchPrintAble is '批量打印';
