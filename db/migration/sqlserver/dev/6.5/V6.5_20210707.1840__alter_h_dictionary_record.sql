alter table h_dictionary_record add initialUsed BIT default 0;
go

update h_dictionary_record set initialUsed = 0 where initialUsed is null or initialUsed ='';

ALTER TABLE h_biz_query_condition ALTER COLUMN options VARCHAR(2048);