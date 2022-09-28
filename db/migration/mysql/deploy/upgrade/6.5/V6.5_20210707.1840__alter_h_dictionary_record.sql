ALTER TABLE h_dictionary_record ADD initialUsed bit(1) NULL DEFAULT NULL comment '字典数据历史使用状态';

update h_dictionary_record set initialUsed = 0 where initialUsed is null or initialUsed = '';

ALTER TABLE h_biz_query_condition MODIFY COLUMN options VARCHAR(2048);