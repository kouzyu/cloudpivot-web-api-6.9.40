alter table h_biz_database_pool add datasourceType varchar(40) null;
update h_biz_database_pool set datasourceType = 'DATABASE';
alter table h_biz_database_pool add externInfo longtext null;
