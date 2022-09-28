-- 批量向模型表中添加version字段
-- 1.创建
create  or replace procedure addVersionParam(vUser in varchar2) as
begin
    declare
        cursor csr is select  table_name from all_tables where owner = upper(vUser) and lower(table_name) like 'i%';
        vSchemaCode VARCHAR(200);
        nCount4 number;
        nCount3 number;
        nCount number;
        v_sql varchar2(1000);
    begin
        for row_table_name in csr loop
--                dbms_output.put_line('table_name ---> '||row_table_name.table_name);
                vSchemaCode := SUBSTR(row_table_name.table_name, INSTR(row_table_name.table_name, '_',1,1) + 1,LENGTH(row_table_name.table_name)) ;
                -- 判断是否为模型相关表
--                dbms_output.put_line('schemaCode by spit ---> '||vSchemaCode);
                SELECT count(*) into nCount4 FROM h_biz_schema where LOWER(code) = LOWER(vSchemaCode);
                if nCount4>0 then
                    SELECT count(*) into nCount3 FROM ALL_TAB_COLUMNS WHERE owner = UPPER(vUser) and TABLE_NAME = row_table_name.table_name  and column_name = 'version';
                    SELECT code into vSchemaCode FROM h_biz_schema where LOWER(code) = LOWER(vSchemaCode);
--					dbms_output.put_line('schemaCode in table ---> '||vSchemaCode);
					if nCount3=0 then
--                        dbms_output.put_line('version not exist');
                        v_sql := 'ALTER TABLE "'||vUser||'"."'||row_table_name.table_name||'" ADD ("version" NUMBER(20,8) DEFAULT 0)';
--                        dbms_output.put_line('exec sql start--->'||v_sql);
                        execute immediate v_sql;
                        v_sql :='COMMENT ON COLUMN "'||vUser||'"."'||row_table_name.table_name||'"."version" is ''版本号''';
--                        dbms_output.put_line('exec sql start--->'||v_sql);
                        execute immediate v_sql;
                    end if;
                    select count(*) into nCount from h_biz_property where schemaCode = vSchemaCode and code = 'version';
                    if nCount=0 then
                        v_sql := 'INSERT INTO h_biz_property (id, createdTime, creater, deleted, modifiedTime, code,
                                                      defaultProperty, defaultValue, name, propertyEmpty,
                                                      propertyIndex, propertyLength, propertyType, published,
                                                      relativeCode, schemaCode, repeated)
                        VALUES (LOWER(sys_guid()), sysdate, NULL, 0,sysdate,'||'''version'', 1, 0, ''版本号'', 0,
                                0, 12, ''NUMERICAL'', 1, NULL,'''||vSchemaCode||''', 0)';
--                        dbms_output.put_line('exec sql start--->'||v_sql);
                        execute immediate v_sql;

                    end if;
--                    dbms_output.put_line('exec sql end <---');
                end if;
            end loop;
    end;
end addVersionParam;
/

-- 2.执行!!!!!!输入库所属用户名 （获取当前用户 select username from user_users）
call addVersionParam('TEST');

-- 3.删除
drop procedure  addVersionParam;
