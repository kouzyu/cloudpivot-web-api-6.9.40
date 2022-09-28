update h_biz_query_column set `name` = '拥有者' where propertyCode = 'owner';
update h_biz_query_column set `name` = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_query_condition set `name` = '拥有者' where propertyCode = 'owner';
update h_biz_query_condition set `name` = '拥有者部门' where propertyCode = 'ownerDeptId';
update h_biz_property set `name` = '拥有者' where code = 'owner';
update h_biz_property set `name` = '拥有者部门' where code = 'ownerDeptId';