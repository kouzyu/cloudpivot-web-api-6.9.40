ALTER TABLE h_biz_sheet ADD (borderMode VARCHAR(10) DEFAULT null);
comment on column h_biz_sheet.borderMode is '表单是否支持边框模式,close或open';
ALTER TABLE h_biz_sheet ADD (layout VARCHAR(20) DEFAULT null);
comment on column h_biz_sheet.layout is '表单边框布局,horizontal-左右布局,vertical-上下布局';


