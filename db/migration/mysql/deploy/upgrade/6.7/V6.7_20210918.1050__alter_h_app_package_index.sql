ALTER TABLE h_app_function 
ADD INDEX idx_type_ac (type, appCode) USING BTREE;