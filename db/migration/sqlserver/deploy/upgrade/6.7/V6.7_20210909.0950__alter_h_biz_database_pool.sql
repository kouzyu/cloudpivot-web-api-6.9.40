ALTER TABLE h_biz_database_pool ADD datasourceType nvarchar(40);
GO
UPDATE h_biz_database_pool SET datasourceType = 'DATABASE';
ALTER TABLE h_biz_database_pool ADD externInfo ntext;
GO
