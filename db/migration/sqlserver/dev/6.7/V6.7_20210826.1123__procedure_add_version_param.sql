-- 批量向模型表中添加version字段
-- 1.删除已存在的存储过程
DROP PROCEDURE IF EXISTS addVersionParam
go
-- 2.创建
CREATE PROCEDURE addVersionParam AS
declare @nCount int
declare @nCount2 int
declare @nCount3 int
declare @nCount4 int
declare @sql varchar(200)
declare @tablename varchar(50)
declare @schemaCode varchar(50)
declare
    taskCursor CURSOR FOR select TABLE_NAME
                          from INFORMATION_SCHEMA.TABLES
                          where TABLE_TYPE = 'BASE TABLE'
                            and TABLE_NAME like 'i%'


    open taskCursor
    fetch next from taskCursor into @tablename
    while(@@fetch_status = 0)
        BEGIN
            set @schemaCode = RIGHT(@tablename, LEN(@tablename) - charindex('_', @tablename));
            -- 判断是否为模型相关表
            SELECT @nCount4 = count(*) FROM h_biz_schema where code = @schemaCode;
            if @nCount4 > 0
                begin
                    -- 判断表是否存在（可省略）
                    SELECT @nCount3 = count(*) FROM information_schema.TABLES WHERE table_name = @tablename
                    if @nCount3 > 0
                        begin
                            print '-- 表' + @tablename + ' -- 编码' + @schemaCode;
                            select @nCount3 = count(*)
                            from sysobjects SO,
                                 syscolumns SC,
                                 systypes ST
                            where SO.id = SC.id
                              and SO.xtype = 'U'
                              and SO.status >= 0
                              and SC.xtype = ST.xusertype
                              and SO.name = @tablename
                              and SC.name = 'version'
                            -- 判断字段是否存在
                            if @nCount3 = 0
                                begin
                                    set @sql = 'alter table ' + @tablename +
                                               ' add version decimal(20,8)  not null default 0'
                                    print '    execute start---> ' + @sql
                                    execute (@sql)
                                    print '    execute end  <--- '
                                end
                            select @nCount = count(*) from h_biz_property where LOWER(schemaCode) = @schemaCode
                                                                            and code = 'version';
                            if @nCount = 0
                                begin
                                    INSERT INTO h_biz_property (id, createdTime, creater, deleted, modifiedTime, code,
                                                                defaultProperty, defaultValue, name, propertyEmpty,
                                                                propertyIndex, propertyLength, propertyType, published,
                                                                relativeCode, schemaCode, repeated)
                                    VALUES (replace(newId(), '-', ''), getdate(), NULL, 0, getdate(), 'version', 1, '0',
                                            '版本号', 0, 0, 12, 'NUMERICAL', 1, NULL, @schemaCode, 0);
                                end
                            else
                                begin
                                    UPDATE h_biz_property
                                    set propertyType='NUMERICAL',
                                        defaultValue='0',
                                        name='版本号'
                                    where schemaCode = @schemaCode
                                      and code = 'version';
                                end
                        end
                end

            fetch next from taskCursor into @tablename
        END
    close taskCursor
    deallocate taskCursor
go
-- 3.执行
EXEC dbo.addVersionParam
go
-- 4.删除
DROP PROCEDURE IF EXISTS addVersionParam
go