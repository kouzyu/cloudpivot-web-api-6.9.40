/*无数据可不运行此sql存储过程*/
/*备份h_biz_query_action  列表操作按钮表*/
create table if not exists h_biz_query_action_bak select * from h_biz_query_action a;

/***************************************新增h_biz_query_action 拥有者修改操作按钮PC端的历史数据***************************************************/
DELIMITER
DROP PROCEDURE IF EXISTS insertBizQueryAction;
CREATE PROCEDURE insertBizQueryAction()
BEGIN
	DECLARE childSchemaCount INT DEFAULT 0;
	DECLARE schemaCodeFirst VARCHAR(50) DEFAULT '';
	DECLARE createdTimeFirst VARCHAR(50) DEFAULT '';
	DECLARE createrFirst VARCHAR(50) DEFAULT '';
	DECLARE modifierFirst VARCHAR(50) DEFAULT '';
	DECLARE queryIdFirst VARCHAR(50) DEFAULT '';
	DECLARE editOwnerCount INT DEFAULT 0;
	DECLARE done  INT DEFAULT 0;
	DECLARE taskCursor CURSOR FOR SELECT queryId FROM h_biz_query_action AS a GROUP BY a.queryId ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  OPEN taskCursor;
--                                  第一个游标循环开始
		cursor_loop:LOOP
			FETCH taskCursor INTO queryIdFirst ;
			IF done = 1 THEN
				LEAVE cursor_loop;
			ELSE
				SET schemaCodeFirst= (SELECT schemaCode FROM h_biz_query_action AS a WHERE a.queryId = queryIdFirst GROUP BY a.schemaCode limit 1 );
				SET createrFirst= (SELECT creater FROM h_biz_query_action AS a WHERE a.queryId = queryIdFirst GROUP BY a.creater limit 1 );
				SET modifierFirst= (SELECT modifier FROM h_biz_query_action AS a WHERE a.queryId = queryIdFirst GROUP BY a.modifier limit 1 );
				SET createdTimeFirst= (SELECT createdTime FROM h_biz_query_action AS a WHERE a.queryId = queryIdFirst GROUP BY a.createdTime limit 1 );
				SET editOwnerCount = (SELECT COUNT(*) FROM h_biz_query_action AS a WHERE a.queryId = queryIdFirst AND a.queryActionType = 'EDITOWNER' );
				IF editOwnerCount < 1 THEN
					INSERT INTO `h_biz_query_action`( `id`,
														`creater`,
														`createdTime`,
														`deleted`,
														`modifier`,
														`modifiedTime`,
														`remarks`,
														`actionCode`,
														`associationCode`,
														`associationType`,
														`customService`,
														`icon`,
														`name`,
														`queryActionType`,
														`queryId`,
														`schemaCode`,
														`serviceCode`,
														`serviceMethod`,
														`sortKey`,
														`systemAction`,
														`name_i18n`,
														`clientType`)
													values
													(replace(uuid(),"-",""),createrFirst,createdTimeFirst,0,modifierFirst,Null,NULL,'editowner',Null,Null,0,
													NULL,'修改拥有者','EDITOWNER',queryIdFirst,schemaCodeFirst,NULL,NULL,'6',0,NULL,'PC');
				END IF;
			END IF;
		END LOOP cursor_loop;
  CLOSE taskCursor;
END;
DELIMITER;
CALL  insertBizQueryAction();