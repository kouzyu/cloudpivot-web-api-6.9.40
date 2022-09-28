ALTER TABLE h_biz_property ADD (repeated number(1, 0) DEFAULT 0);
comment on column h_biz_property.repeated is '去重属性：1开启0不开启';