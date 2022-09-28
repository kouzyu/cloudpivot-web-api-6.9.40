ALTER TABLE h_im_message_history ADD COLUMN smsParams longtext NULL COMMENT '短信模板参数';
ALTER TABLE h_im_message_history ADD COLUMN smsCode varchar(50) NULL COMMENT '短信模板编码';