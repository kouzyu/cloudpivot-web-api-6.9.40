alter table h_biz_perm_property
    add encryptVisible bit null comment '是否可见加密';

update h_biz_perm_property set encryptVisible = 0 where id != '';