ALTER TABLE h_system_pair ADD COLUMN objectId varchar(120) NULL COMMENT '数据id';
ALTER TABLE h_system_pair ADD COLUMN schemaCode varchar(40) NULL COMMENT '模型编码';
ALTER TABLE h_system_pair ADD COLUMN formCode varchar(40) NULL COMMENT '表单编码';
ALTER TABLE h_system_pair ADD COLUMN workflowInstanceId varchar(120) NULL COMMENT '流程实例ID';

ALTER TABLE h_system_pair ADD INDEX `idx_bid_fcode`(`objectId`, `formCode`);

--update h_system_pair set objectId = replace(json_extract(pairValue, '$.objectId'), '"', '');
--update h_system_pair set objectId = replace(json_extract(pairValue, '$.id'), '"', '') where objectId is null;
--update h_system_pair set formCode = replace(json_extract(pairValue, '$.formCode'), '"', '');
---- update h_system_pair set formCode = replace(json_extract(pairValue, '$.sheetCode'), '"', '') where formCode is null;
--update h_system_pair set schemaCode = replace(json_extract(pairValue, '$.schemaCode'), '"', '');
--update h_system_pair set workflowInstanceId = replace(json_extract(pairValue, '$.workflowInstanceId'), '"', '');