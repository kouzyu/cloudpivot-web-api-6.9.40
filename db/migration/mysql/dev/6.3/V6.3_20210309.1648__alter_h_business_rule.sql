ALTER TABLE h_business_rule ADD enabled bit(1) NULL DEFAULT NULL comment '是否生效';
ALTER TABLE h_business_rule ADD quoteProperty longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL comment '引用编码 数据模型编码.数据项编码 ,分割';

update h_business_rule set enabled = 1 where enabled is null;