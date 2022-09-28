ALTER TABLE h_biz_service ADD (shared number(1, 0) DEFAULT null);
ALTER TABLE h_biz_service ADD (userIds clob DEFAULT null);
comment on column h_biz_service.shared is '是否共享，0-私有，1共享';
comment on column h_biz_service.userIds is '用戶id，多個用戶用逗號隔開';