-- ALTER TABLE `h_app_function` ADD COLUMN `pcAble` bit(1) DEFAULT 1 COMMENT 'PC是否可见';

ALTER TABLE h_app_function ADD (pcAble number(1,0) DEFAULT 1);

-- ALTER TABLE `h_app_function` ADD COLUMN `mobileAble` bit(1) DEFAULT 1 COMMENT '移动端是否可见';

ALTER TABLE h_app_function ADD (mobileAble number(1,0) DEFAULT 1);

-- UPDATE `h_app_function` SET `pcAble`=0 WHERE `type`='Report' AND `code` IN (SELECT `code` FROM `h_report_page` WHERE `pcAble`=0);

UPDATE h_app_function SET pcAble=0 WHERE type='Report' AND code IN (SELECT code FROM h_report_page WHERE pcAble=0);

-- UPDATE `h_app_function` SET `mobileAble`=0 WHERE `type`='Report' AND `code` IN (SELECT `code` FROM `h_report_page` WHERE `mobileAble`=0);


UPDATE h_app_function SET mobileAble=0 WHERE type='Report' AND code IN (SELECT code FROM h_report_page WHERE mobileAble=0);