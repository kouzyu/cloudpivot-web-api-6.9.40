DROP PROCEDURE IF EXISTS addDefaultBusinessRule;
DELIMITER &&
CREATE PROCEDURE addDefaultBusinessRule()
	BEGIN
		DECLARE stopflag INT DEFAULT 0;
		DECLARE tempSchemaCode VARCHAR(400) DEFAULT NULL;
		DECLARE businessRuleCount INT DEFAULT 0;
		DECLARE schemaCode_cur CURSOR FOR SELECT `code` FROM h_biz_schema WHERE `code` IN (SELECT `code` FROM `h_app_function`);
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET stopflag=1;
		OPEN schemaCode_cur;

		cursor_loop:LOOP
			FETCH schemaCode_cur into tempSchemaCode;
			IF stopflag =1 THEN
				LEAVE cursor_loop;
			ELSE
				SELECT COUNT(*) INTO businessRuleCount FROM `h_business_rule` WHERE `schemaCode`=tempSchemaCode AND `code`='Create';
				IF businessRuleCount<1 THEN
					INSERT IGNORE INTO `h_business_rule`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `node`, `route`, `schedulerSetting`, `bizRuleType`, `defaultRule`, `code`, `name`, `schemaCode`, `remarks`) VALUES (REPLACE(UUID(),"-",""), '2020-05-07 19:49:00', NULL, 0, '2020-05-07 19:49:00', NULL, '[{\"height\":40,\"logic\":false,\"nodeCode\":\"Start\",\"nodeName\":\"开始\",\"nodeType\":\"START\",\"width\":158,\"x\":327,\"y\":36},{\"height\":40,\"logic\":false,\"nodeCode\":\"End\",\"nodeName\":\"结束\",\"nodeType\":\"END\",\"width\":158,\"x\":327,\"y\":196},{\"height\":40,\"logic\":false,\"nodeCode\":\"Create\",\"nodeName\":\"新增数据\",\"nodeType\":\"SYSTEM_CREATE\",\"width\":158,\"x\":327,\"y\":116}]', '[{\"points\":[\"406, 76\",\"406, 116\"],\"postNode\":\"Create\",\"preNode\":\"Start\",\"routeCondition\":true},{\"points\":[\"406, 156\",\"406, 196\"],\"postNode\":\"End\",\"preNode\":\"Create\",\"routeCondition\":true}]', NULL, 'DATA_OP', 1, 'Create', '新增', tempSchemaCode, NULL);
				END IF;

				SELECT COUNT(*) INTO businessRuleCount FROM `h_business_rule` WHERE `schemaCode`=tempSchemaCode AND `code`='Update';
				IF businessRuleCount<1 THEN
					INSERT IGNORE INTO `h_business_rule`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `node`, `route`, `schedulerSetting`, `bizRuleType`, `defaultRule`, `code`, `name`, `schemaCode`, `remarks`) VALUES (REPLACE(UUID(),"-",""), '2020-05-07 19:49:00', NULL, 0, '2020-05-07 19:49:00', NULL, '[{\"height\":40,\"logic\":false,\"nodeCode\":\"Start\",\"nodeName\":\"开始\",\"nodeType\":\"START\",\"width\":158,\"x\":327,\"y\":36},{\"height\":40,\"logic\":false,\"nodeCode\":\"End\",\"nodeName\":\"结束\",\"nodeType\":\"END\",\"width\":158,\"x\":327,\"y\":196},{\"height\":40,\"logic\":false,\"nodeCode\":\"Update\",\"nodeName\":\"更新数据\",\"nodeType\":\"SYSTEM_UPDATE\",\"width\":158,\"x\":327,\"y\":116}]', '[{\"points\":[\"406, 76\",\"406, 116\"],\"postNode\":\"Update\",\"preNode\":\"Start\",\"routeCondition\":true},{\"points\":[\"406, 156\",\"406, 196\"],\"postNode\":\"End\",\"preNode\":\"Update\",\"routeCondition\":true}]', NULL, 'DATA_OP', 1, 'Update', '更新', tempSchemaCode, NULL);
				END IF;

				SELECT COUNT(*) INTO businessRuleCount FROM `h_business_rule` WHERE `schemaCode`=tempSchemaCode AND `code`='Delete';
				IF businessRuleCount<1 THEN
					INSERT IGNORE INTO `h_business_rule`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `node`, `route`, `schedulerSetting`, `bizRuleType`, `defaultRule`, `code`, `name`, `schemaCode`, `remarks`) VALUES (REPLACE(UUID(),"-",""), '2020-05-07 19:49:00', NULL, 0, '2020-05-07 19:49:00', NULL, '[{\"height\":40,\"logic\":false,\"nodeCode\":\"Start\",\"nodeName\":\"开始\",\"nodeType\":\"START\",\"width\":158,\"x\":327,\"y\":36},{\"height\":40,\"logic\":false,\"nodeCode\":\"End\",\"nodeName\":\"结束\",\"nodeType\":\"END\",\"width\":158,\"x\":327,\"y\":196},{\"height\":40,\"logic\":false,\"nodeCode\":\"Delete\",\"nodeName\":\"删除数据\",\"nodeType\":\"SYSTEM_DELETE\",\"width\":158,\"x\":327,\"y\":116}]', '[{\"points\":[\"406, 76\",\"406, 116\"],\"postNode\":\"Delete\",\"preNode\":\"Start\",\"routeCondition\":true},{\"points\":[\"406, 156\",\"406, 196\"],\"postNode\":\"End\",\"preNode\":\"Delete\",\"routeCondition\":true}]', NULL, 'DATA_OP', 1, 'Delete', '删除', tempSchemaCode, NULL);
				END IF;

				SELECT COUNT(*) INTO businessRuleCount FROM `h_business_rule` WHERE `schemaCode`=tempSchemaCode AND `code`='Load';
				IF businessRuleCount<1 THEN
					INSERT IGNORE INTO `h_business_rule`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `node`, `route`, `schedulerSetting`, `bizRuleType`, `defaultRule`, `code`, `name`, `schemaCode`, `remarks`) VALUES (REPLACE(UUID(),"-",""), '2020-05-07 19:49:00', NULL, 0, '2020-05-07 19:49:00', NULL, '[{\"height\":40,\"logic\":false,\"nodeCode\":\"Start\",\"nodeName\":\"开始\",\"nodeType\":\"START\",\"width\":158,\"x\":327,\"y\":36},{\"height\":40,\"logic\":false,\"nodeCode\":\"End\",\"nodeName\":\"结束\",\"nodeType\":\"END\",\"width\":158,\"x\":327,\"y\":196}]', '[{\"points\":[\"406, 76\",\"406, 196\"],\"postNode\":\"End\",\"preNode\":\"Start\",\"routeCondition\":true}]', NULL, 'DATA_OP', 1, 'Load', '查询', tempSchemaCode, NULL);
				END IF;

				SELECT COUNT(*) INTO businessRuleCount FROM `h_business_rule` WHERE `schemaCode`=tempSchemaCode AND `code`='GetList';
				IF businessRuleCount<1 THEN
					INSERT IGNORE INTO `h_business_rule`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `node`, `route`, `schedulerSetting`, `bizRuleType`, `defaultRule`, `code`, `name`, `schemaCode`, `remarks`) VALUES (REPLACE(UUID(),"-",""), '2020-05-07 19:49:00', NULL, 0, '2020-05-07 19:49:00', NULL, '[{\"height\":40,\"logic\":false,\"nodeCode\":\"Start\",\"nodeName\":\"开始\",\"nodeType\":\"START\",\"width\":158,\"x\":327,\"y\":36},{\"height\":40,\"logic\":false,\"nodeCode\":\"End\",\"nodeName\":\"结束\",\"nodeType\":\"END\",\"width\":158,\"x\":327,\"y\":196},{\"dataSourceType\":\"GET_LIST\",\"height\":40,\"logic\":false,\"methodMapping\":null,\"nodeCode\":\"GetList\",\"nodeName\":\"获取集合数据\",\"nodeType\":\"GET_LIST\",\"width\":158,\"x\":327,\"y\":116}]', '[{\"points\":[\"406, 76\",\"406, 116\"],\"postNode\":\"GetList\",\"preNode\":\"Start\",\"routeCondition\":true},{\"points\":[\"406, 156\",\"406, 196\"],\"postNode\":\"End\",\"preNode\":\"GetList\",\"routeCondition\":true}]', NULL, 'GET_LIST', 1, 'GetList', '获取列表', tempSchemaCode, NULL);
				END IF;

				SELECT COUNT(*) INTO businessRuleCount FROM `h_business_rule` WHERE `schemaCode`=tempSchemaCode AND `code`='Cancel';
				IF businessRuleCount<1 THEN
					INSERT IGNORE INTO `h_business_rule`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `node`, `route`, `schedulerSetting`, `bizRuleType`, `defaultRule`, `code`, `name`, `schemaCode`, `remarks`) VALUES (REPLACE(UUID(),"-",""), '2020-05-07 19:49:00', NULL, 0, '2020-05-07 19:49:00', NULL, '[{\"height\":40,\"logic\":false,\"nodeCode\":\"Start\",\"nodeName\":\"开始\",\"nodeType\":\"START\",\"width\":158,\"x\":327,\"y\":36},{\"height\":40,\"logic\":false,\"nodeCode\":\"End\",\"nodeName\":\"结束\",\"nodeType\":\"END\",\"width\":158,\"x\":327,\"y\":196}]', '[{\"points\":[\"406, 76\",\"406, 196\"],\"postNode\":\"End\",\"preNode\":\"Start\",\"routeCondition\":true}]', NULL, 'DATA_OP', 1, 'Cancel', '流程作废', tempSchemaCode, NULL);
				END IF;

				SELECT COUNT(*) INTO businessRuleCount FROM `h_business_rule` WHERE `schemaCode`=tempSchemaCode AND `code`='Available';
				IF businessRuleCount<1 THEN
					INSERT IGNORE INTO `h_business_rule`(`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `node`, `route`, `schedulerSetting`, `bizRuleType`, `defaultRule`, `code`, `name`, `schemaCode`, `remarks`) VALUES (REPLACE(UUID(),"-",""), '2020-05-07 19:49:00', NULL, 0, '2020-05-07 19:49:00', NULL, '[{\"height\":40,\"logic\":false,\"nodeCode\":\"Start\",\"nodeName\":\"开始\",\"nodeType\":\"START\",\"width\":158,\"x\":327,\"y\":36},{\"height\":40,\"logic\":false,\"nodeCode\":\"End\",\"nodeName\":\"结束\",\"nodeType\":\"END\",\"width\":158,\"x\":327,\"y\":196}]', '[{\"points\":[\"406, 76\",\"406, 196\"],\"postNode\":\"End\",\"preNode\":\"Start\",\"routeCondition\":true}]', NULL, 'DATA_OP', 1, 'Available', '流程生效', tempSchemaCode, NULL);
				END IF;

			END IF;
		END LOOP cursor_loop;
		CLOSE schemaCode_cur;
	END &&
DELIMITER;

CALL addDefaultBusinessRule();