-- 批量向模型表中添加version字段
DROP PROCEDURE IF EXISTS addVersionParam;
-- 1.创建存储过程
DELIMITER &&
CREATE PROCEDURE `addVersionParam`(IN vDBName VARCHAR(100))
BEGIN
    DECLARE vSchemaCode VARCHAR(50) DEFAULT '';
    DECLARE vTableName VARCHAR(100) DEFAULT '';
    DECLARE vAlterSQL VARCHAR(500) DEFAULT '';
    DECLARE nCount int DEFAULT 0;
    DECLARE nCount2 int DEFAULT 0;
    DECLARE nCount3 int DEFAULT 0;
    DECLARE nCount4 int DEFAULT 0;
    DECLARE done INT DEFAULT 0;
    DECLARE taskCursor CURSOR FOR SELECT table_name
                                  FROM INFORMATION_SCHEMA.TABLES
                                  WHERE table_schema = vDBName and table_name LIKE "i%";
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN taskCursor;
    REPEAT
        FETCH taskCursor INTO vTableName;
        IF NOT done THEN
            set vSchemaCode = SUBSTR(vTableName, LOCATE('_', vTableName) + 1);
            -- 判断是否为模型相关表
            SELECT count(*) into nCount4 FROM h_biz_schema where `code` = vSchemaCode;
            if nCount4 > 0 THEN
                -- 判断表是否存在（可省略）
                SELECT count(*)
                into nCount3
                FROM information_schema.TABLES
                WHERE TABLE_SCHEMA = vDBName and table_name = vTableName;
                if nCount3 > 0 THEN
                    -- 判断该表是否存在该字段
                    SELECT count(*)
                    into nCount2
                    FROM information_schema.columns
                    WHERE TABLE_SCHEMA = vDBName
                      and table_name = vTableName
                      AND column_name = 'version';
                    if nCount2 = 0 THEN
                        SET vAlterSQL = concat('ALTER TABLE ', vTableName,
                                               ' ADD COLUMN `version` decimal(25, 8) default  0.00000000  COMMENT \'版本号\'');
                    ELSE
                        SET vAlterSQL = concat('ALTER TABLE ', vTableName,
                                               ' MODIFY COLUMN `version` decimal(25, 8) default  0.00000000  COMMENT \'版本号\'');
                    end if;
                    set @vSql = vAlterSQL;
                    PREPARE stmt FROM @vSql;
                    EXECUTE stmt;
                    select count(*)
                    into nCount
                    from h_biz_property
                    where schemaCode = vSchemaCode and `code` = 'version';
                    if nCount = 0 THEN
                        INSERT INTO `h_biz_property` (`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `code`,
                                                      `defaultProperty`, `defaultValue`, `name`, `propertyEmpty`,
                                                      `propertyIndex`, `propertyLength`, `propertyType`, `published`,
                                                      `relativeCode`, `schemaCode`, `repeated`)
                        VALUES (replace(uuid(), '-', ''), now(), NULL, false, now(), 'version', true, '0', '版本号', false,
                                false, 12, 'NUMERICAL', true, NULL, vSchemaCode, 0);
                    ELSE
                        UPDATE h_biz_property
                        set propertyType='NUMERICAL',
                            defaultValue='0',
                            `name`='版本号'
                        where schemaCode = vSchemaCode
                          and `code` = 'version';
                    end if;
                end if;
            end if;
        END IF;
    UNTIL done END REPEAT;
    CLOSE taskCursor;
END;
&&
DELIMITER ;
-- 2.执行存储过程 !!! 默认当前库，可修改需要执行的库名
CALL addVersionParam(database());
-- 3.执行完删除
DROP PROCEDURE IF EXISTS addVersionParam;