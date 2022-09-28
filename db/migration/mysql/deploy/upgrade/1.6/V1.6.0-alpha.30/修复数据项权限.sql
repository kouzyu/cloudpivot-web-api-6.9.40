

/* 无数据可不用执行 */


/*备份h_h_biz_perm_property数据项权限表表*/
create table if not exists h_biz_perm_property_bak select * from h_biz_perm_property p;

/***************************************新增h_biz_perm_property主表的历史数据***************************************************/
DELIMITER
DROP PROCEDURE IF EXISTS insertPermProperty;
CREATE PROCEDURE insertPermProperty()
BEGIN
	DECLARE childPropertyCount INT DEFAULT 0;
  DECLARE groupIdCount  INT DEFAULT 0;
 	DECLARE childGroupIdCount  INT DEFAULT 0;
  DECLARE schemaCodeFirst VARCHAR(50) DEFAULT '';
	DECLARE schemaCodeMain VARCHAR(50) DEFAULT '';
	DECLARE propertyPermCount  INT DEFAULT 0;
	DECLARE done  INT DEFAULT 0;
	DECLARE taskCursor CURSOR FOR SELECT schemaCode FROM h_biz_property ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  OPEN taskCursor;
--                                  第一个游标循环开始
  cursor_loop:LOOP
			FETCH taskCursor INTO schemaCodeFirst ;
			IF done = 1 THEN
				LEAVE cursor_loop;
			ELSE
				SET groupIdCount= (SELECT count(*) FROM h_biz_perm_group AS g WHERE g.schemaCode = schemaCodeFirst );
				IF groupIdCount > 0 THEN
					BEGIN
						DECLARE done1  INT DEFAULT 0;
						DECLARE groupIdFist VARCHAR(50) DEFAULT '';
						DECLARE taskCursor1 CURSOR FOR SELECT id FROM h_biz_perm_group AS g WHERE g.schemaCode = schemaCodeFirst;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1 = 1;
						OPEN taskCursor1;
							cursor_loop1:LOOP
								FETCH taskCursor1 INTO groupIdFist ;
									IF done1 = 1 THEN
										LEAVE cursor_loop1;
									ELSE
										BEGIN
											DECLARE done2  INT DEFAULT 0;
											DECLARE propertyCodeFirst VARCHAR(50) DEFAULT '';
											DECLARE propertyName  VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;
											DECLARE propertyNameI18C  VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;
											DECLARE requiredFirst  INT DEFAULT 0;
											DECLARE propertyTypeFirst  VARCHAR(50) DEFAULT NULL;
											DECLARE time  VARCHAR(50) DEFAULT NULL;
											DECLARE propertyCount  INT DEFAULT 0;
											DECLARE taskCursor2 CURSOR FOR SELECT code FROM h_biz_property AS b WHERE b.schemaCode = schemaCodeFirst AND b.published = '1' AND b.defaultProperty='0';
											DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = 1;
											OPEN taskCursor2;
												cursor_loop2:LOOP
													FETCH taskCursor2 INTO propertyCodeFirst;
													IF done2 =1 THEN
														LEAVE cursor_loop2;
													ELSE
														SET requiredFirst = (SELECT propertyEmpty FROM h_biz_property AS b WHERE b.schemaCode= schemaCodeFirst AND b.code = propertyCodeFirst);
														SET propertyCount = (SELECT COUNT(*) FROM h_biz_perm_property AS p WHERE p.propertyCode = propertyCodeFirst AND p.groupId = groupIdFist AND p.schemaCode = schemaCodeFirst  );
														IF propertyCount>0  THEN
															UPDATE `h_biz_perm_property` AS p SET p.required = requiredFirst WHERE p.groupId = groupIdFist AND p.bizPermType != 'CHECK';
														ELSE
															SET time = (SELECT createdTime FROM h_biz_property AS b WHERE b.schemaCode = schemaCodeFirst AND b.code = propertyCodeFirst);
															SET propertyTypeFirst = (SELECT propertyType FROM h_biz_property AS b WHERE b.schemaCode = schemaCodeFirst AND b.code = propertyCodeFirst);
															SET propertyName = (SELECT name FROM h_biz_property AS b WHERE b.schemaCode= schemaCodeFirst AND b.code = propertyCodeFirst);
															SET propertyNameI18C = (SELECT name_i18n FROM h_biz_property AS b WHERE b.schemaCode= schemaCodeFirst AND b.code = propertyCodeFirst);
															INSERT INTO h_biz_perm_property(`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `bizPermType`, `groupId`, `name`, `name_i18n`, `propertyCode`, `propertyType`, `required`, `visible`, `writeAble`, `schemaCode`) values (replace(uuid(),"-",""),Null,time,0,Null,NULL,Null,'ADD',groupIdFist,propertyName,propertyNameI18C,propertyCodeFirst,propertyTypeFirst,requiredFirst,1,1,schemaCodeFirst);

															INSERT INTO `h_biz_perm_property`(`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `bizPermType`, `groupId`, `name`, `name_i18n`, `propertyCode`, `propertyType`, `required`, `visible`, `writeAble`, `schemaCode`) values (replace(uuid(),"-",""),Null,time,0,Null,NULL,Null,'CHECK',groupIdFist,propertyName,propertyNameI18C,propertyCodeFirst,propertyTypeFirst,0,1,0,schemaCodeFirst);

															INSERT INTO `h_biz_perm_property`(`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `bizPermType`, `groupId`, `name`, `name_i18n`, `propertyCode`, `propertyType`, `required`, `visible`, `writeAble`, `schemaCode`) values (replace(uuid(),"-",""),Null,time,0,Null,NULL,Null,'EDIT',groupIdFist,propertyName,propertyNameI18C,propertyCodeFirst,propertyTypeFirst,requiredFirst,1,1,schemaCodeFirst);
														END IF;
													END IF;
												END LOOP cursor_loop2;
										END;
									END IF;
							END LOOP cursor_loop1;
						CLOSE taskCursor1;
					END;
				END IF;
			END IF;
	  END LOOP cursor_loop;
   CLOSE taskCursor;
--                                  第一个游标循环结束
 END;
DELIMITER;
CALL  insertPermProperty();

/***************************************新增h_biz_perm_property子表的历史数据***************************************************/
DELIMITER
DROP PROCEDURE IF EXISTS insertChildPermProperty;
CREATE PROCEDURE insertChildPermProperty()
BEGIN
	DECLARE childPropertyCount INT DEFAULT 0;
  DECLARE groupIdCount  INT DEFAULT 0;
 	DECLARE childGroupIdCount  INT DEFAULT 0;
  DECLARE schemaCodeFirst VARCHAR(50) DEFAULT '';
	DECLARE schemaCodeMain VARCHAR(50) DEFAULT '';
	DECLARE propertyPermCount  INT DEFAULT 0;
	DECLARE done  INT DEFAULT 0;
	DECLARE taskCursor CURSOR FOR SELECT code FROM h_biz_property AS b WHERE  b.propertyType = 'CHILD_TABLE' ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  OPEN taskCursor;
--                                  第一个游标循环开始
		cursor_loop:LOOP
			FETCH taskCursor INTO schemaCodeFirst ;
			IF done = 1 THEN
				LEAVE cursor_loop;
			ELSE
				SET groupIdCount= (SELECT count(*) FROM h_biz_perm_group AS g WHERE g.schemaCode = schemaCodeFirst );
				SET childPropertyCount= (SELECT count(*) FROM h_biz_property AS b WHERE b.schemaCode = schemaCodeFirst AND b.defaultProperty = '0' AND b.published = '1' );
				IF   childPropertyCount > 0 THEN
 					SET schemaCodeMain = (SELECT schemaCode FROM h_biz_property AS b WHERE b.code = schemaCodeFirst AND b.published = '1' AND b.propertyType = 'CHILD_TABLE' );
 					SET childGroupIdCount = (SELECT count(*) FROM h_biz_perm_group AS g WHERE g.schemaCode = schemaCodeMain );
					IF childGroupIdCount> 0 THEN
							BEGIN
									DECLARE done1  INT DEFAULT 0;
									DECLARE groupIdFist VARCHAR(50) DEFAULT '';
									DECLARE taskCursor1 CURSOR FOR SELECT id FROM h_biz_perm_group AS g WHERE g.schemaCode = schemaCodeMain ;
									DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1 = 1;
									OPEN taskCursor1;
										cursor_loop1:LOOP
											FETCH taskCursor1 INTO groupIdFist ;
												IF done1 = 1 THEN
													LEAVE cursor_loop1;
												ELSE
													BEGIN
														DECLARE done2  INT DEFAULT 0;
														DECLARE propertyCodeFirst VARCHAR(50) DEFAULT '';
														DECLARE propertyName  VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;
														DECLARE propertyNameI18C  VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ;
														DECLARE requiredFirst  INT DEFAULT 0;
														DECLARE propertyTypeFirst  VARCHAR(50) DEFAULT NULL;
														DECLARE time  VARCHAR(50) DEFAULT NULL;
														DECLARE propertyCount  INT DEFAULT 0;
														DECLARE taskCursor2 CURSOR FOR SELECT code FROM h_biz_property AS b WHERE b.schemaCode = schemaCodeFirst AND b.published = '1' AND b.defaultProperty='0' GROUP BY code;
														DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = 1;
														OPEN taskCursor2;
															cursor_loop2:LOOP
																FETCH taskCursor2 INTO propertyCodeFirst;
																IF done2 =1 THEN
																	LEAVE cursor_loop2;
																ELSE
																	SET requiredFirst = (SELECT propertyEmpty FROM h_biz_property AS b WHERE b.schemaCode= schemaCodeFirst AND b.code = propertyCodeFirst);
																	SET propertyCount = (SELECT COUNT(*) FROM h_biz_perm_property AS p WHERE p.propertyCode = propertyCodeFirst AND p.groupId = groupIdFist AND p.schemaCode = schemaCodeFirst  );
																	IF propertyCount>0  THEN
																		UPDATE `h_biz_perm_property` AS p SET p.required = requiredFirst WHERE p.groupId = groupIdFist AND p.bizPermType != 'CHECK';
																	ELSE
																		SET time = (SELECT createdTime FROM h_biz_property AS b WHERE b.schemaCode = schemaCodeFirst AND b.code = propertyCodeFirst);
																		SET propertyTypeFirst = (SELECT propertyType FROM h_biz_property AS b WHERE b.schemaCode = schemaCodeFirst AND b.code = propertyCodeFirst);
																		SET propertyName = (SELECT name FROM h_biz_property AS b WHERE b.schemaCode= schemaCodeFirst AND b.code = propertyCodeFirst);
																		SET propertyNameI18C = (SELECT name_i18n FROM h_biz_property AS b WHERE b.schemaCode= schemaCodeFirst AND b.code = propertyCodeFirst);
																		INSERT INTO h_biz_perm_property(`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `bizPermType`, `groupId`, `name`, `name_i18n`, `propertyCode`, `propertyType`, `required`, `visible`, `writeAble`, `schemaCode`) values (replace(uuid(),"-",""),Null,time,0,Null,NULL,Null,'ADD',groupIdFist,propertyName,propertyNameI18C,propertyCodeFirst,propertyTypeFirst,requiredFirst,1,1,schemaCodeFirst);

																		INSERT INTO `h_biz_perm_property`(`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `bizPermType`, `groupId`, `name`, `name_i18n`, `propertyCode`, `propertyType`, `required`, `visible`, `writeAble`, `schemaCode`) values (replace(uuid(),"-",""),Null,time,0,Null,NULL,Null,'CHECK',groupIdFist,propertyName,propertyNameI18C,propertyCodeFirst,propertyTypeFirst,0,1,0,schemaCodeFirst);

																		INSERT INTO `h_biz_perm_property`(`id`, `creater`, `createdTime`, `deleted`, `modifier`, `modifiedTime`, `remarks`, `bizPermType`, `groupId`, `name`, `name_i18n`, `propertyCode`, `propertyType`, `required`, `visible`, `writeAble`, `schemaCode`) values (replace(uuid(),"-",""),Null,time,0,Null,NULL,Null,'EDIT',groupIdFist,propertyName,propertyNameI18C,propertyCodeFirst,propertyTypeFirst,requiredFirst,1,1,schemaCodeFirst);
																	END IF;
																END IF;
															END LOOP cursor_loop2;
													END;
												END IF;
										END LOOP cursor_loop1;
									CLOSE taskCursor1;
							END;

 					END IF;
				END IF;
			END IF;
	  END LOOP cursor_loop;
  CLOSE taskCursor;
--                                  第一个游标循环结束
END;
DELIMITER;
CALL  insertChildPermProperty();
