/* 无数据可不用执行 */


/*备份h_biz_query_column  列表展示项表*/
create table if not exists h_biz_query_column_bak select * from h_biz_query_column c;

/***************************************新增h_biz_query_column 子表的历史数据***************************************************/
DELIMITER
DROP PROCEDURE IF EXISTS insertBizQueryColumn;
CREATE PROCEDURE insertBizQueryColumn()
BEGIN
	DECLARE childSchemaCount INT DEFAULT 0;
	DECLARE schemaCodeFirst VARCHAR(50) DEFAULT '';
	DECLARE done  INT DEFAULT 0;
	DECLARE taskCursor CURSOR FOR SELECT code FROM h_biz_property AS p WHERE  p.published='1' AND p.propertyType = 'CHILD_TABLE' GROUP BY code;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  OPEN taskCursor;
--                                  第一个游标循环开始
		cursor_loop:LOOP
			FETCH taskCursor INTO schemaCodeFirst ;
			IF done = 1 THEN
				LEAVE cursor_loop;
			ELSE
				SET childSchemaCount= (SELECT count(*) FROM h_biz_query_column AS c WHERE c.propertyCode = schemaCodeFirst );
				IF   childSchemaCount > 0 THEN
					BEGIN
						DECLARE done2  INT DEFAULT 0;
						DECLARE queryIdFirst VARCHAR(50) DEFAULT '';
						DECLARE taskCursor2 CURSOR FOR SELECT queryId FROM h_biz_query_column AS c WHERE c.propertyCode = schemaCodeFirst GROUP BY queryId;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = 1;
						OPEN taskCursor2;
							cursor_loop2:LOOP
								FETCH taskCursor2 INTO queryIdFirst;
								IF done2 =1 THEN
									LEAVE cursor_loop2;
								ELSE
									BEGIN
										DECLARE propertyCodeFirst VARCHAR(50) DEFAULT '';
										DECLARE propertyCount  INT DEFAULT 0;
										DECLARE done3  INT DEFAULT 0;
										DECLARE taskCursor3 CURSOR FOR SELECT code FROM h_biz_property AS p WHERE p.schemaCode = schemaCodeFirst AND p.published = '1' AND p.defaultProperty='0' GROUP BY code ;
										DECLARE CONTINUE HANDLER FOR NOT FOUND SET done3 = 1;
										OPEN taskCursor3;
											cursor_loop3:LOOP
												FETCH taskCursor3 INTO propertyCodeFirst;
												IF done3 =1 THEN
													LEAVE cursor_loop3;
												ELSE
													SET propertyCount = (SELECT count(*) FROM h_biz_query_column AS c WHERE c.schemaCode = schemaCodeFirst  AND c.propertyCode= propertyCodeFirst AND c.queryId = queryIdFirst);
													IF  propertyCount = 0 THEN
															BEGIN
																DECLARE sortKeyFirst INT DEFAULT 1;
																DECLARE propertyName  VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;
																DECLARE propertyNameI18C  VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;
																DECLARE propertyTypeFirst  VARCHAR(50) DEFAULT NULL;
																DECLARE modifyTime  datetime DEFAULT NULL;
																DECLARE createTime  datetime DEFAULT NULL;
																DECLARE done4  INT DEFAULT 0;
																DECLARE clientTypeFirst VARCHAR(50) DEFAULT NULL;
																DECLARE taskCursor4 CURSOR FOR SELECT clientType FROM h_biz_query_column  AS c WHERE c.propertyCode = schemaCodeFirst AND c.queryId = queryIdFirst ;
																DECLARE CONTINUE HANDLER FOR NOT FOUND SET done4 = 1;
																OPEN taskCursor4;
																	cursor_loop4:LOOP
																		FETCH taskCursor4 INTO clientTypeFirst;
																		IF done4 =1 THEN
																			LEAVE cursor_loop4;
																		ELSE
																			SET modifyTime = (SELECT modifiedTime FROM h_biz_property  AS p WHERE p.schemaCode = schemaCodeFirst  AND p.code= propertyCodeFirst);
																			SET propertyName = (SELECT name FROM h_biz_property  AS p WHERE p.schemaCode = schemaCodeFirst  AND p.code= propertyCodeFirst);
																			SET propertyTypeFirst = (SELECT propertyType FROM h_biz_property  AS p WHERE p.schemaCode = schemaCodeFirst  AND p.code= propertyCodeFirst);
																			SET propertyNameI18C = (SELECT name_i18n FROM h_biz_property  AS p  WHERE p.schemaCode = schemaCodeFirst  AND p.code= propertyCodeFirst);
																			SET sortKeyFirst = (SELECT sortKey FROM h_biz_property  AS p WHERE p.schemaCode = schemaCodeFirst  AND p.code= propertyCodeFirst);
																			INSERT INTO `h_biz_query_column`
																			(`id` ,
																			`creater` ,`createdTime` ,`deleted` ,`modifier` ,`modifiedTime` ,`remarks` ,`isSystem` ,`name` ,`propertyCode` ,`propertyType` ,`queryId` ,`schemaCode` ,`sortKey` ,`sumType` ,`unit` ,`width` ,`displayFormat` ,`name_i18n` ,`clientType` )
																			values
																			(replace(uuid(),"-",""),Null,NULL,0,modifyTime,Null,NULL,NULL,propertyName,propertyCodeFirst,propertyTypeFirst,
																				queryIdFirst,schemaCodeFirst,sortKeyFirst,'STATISTICS',0,162,2,propertyNameI18C,clientTypeFirst);
																		END IF;
																	END LOOP cursor_loop4;
																CLOSE taskCursor4;
															END;
													END IF;
												END IF;
											END LOOP cursor_loop3;
										CLOSE taskCursor3;
									END;
								END IF;
							END LOOP cursor_loop2;
						CLOSE taskCursor2;
					END;
				END IF;
			END IF;
		END LOOP cursor_loop;
  CLOSE taskCursor;
END;
DELIMITER ;
CALL  insertBizQueryColumn();





