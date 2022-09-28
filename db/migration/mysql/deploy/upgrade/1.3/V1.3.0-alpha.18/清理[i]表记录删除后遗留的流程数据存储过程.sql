

/*如果存在：则删除存储过程*/
DROP PROCEDURE IF EXISTS deleteBOAndWorkflow;


/*创建*/
CREATE PROCEDURE deleteBOAndWorkflow()
BEGIN
  DECLARE vWorkflowCode VARCHAR(50) DEFAULT ''; /*流程编码*/
  DECLARE vWorkflowInstanceId VARCHAR(50) DEFAULT ''; /*流程实例id*/
  DECLARE vBizObjectId VARCHAR(50) DEFAULT ''; /*业务对象id*/
  DECLARE vSchemaCode VARCHAR(50) DEFAULT ''; /*业务模型编码*/
  DECLARE vTableName VARCHAR(50) DEFAULT ''; /*业务表*/

  DECLARE done INT DEFAULT 0; /*定义游标结束标记*/

  DECLARE taskCursor CURSOR FOR select t.id, t.workflowCode, t.bizObjectId from biz_workflow_instance t;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN taskCursor;
  REPEAT
    FETCH taskCursor INTO vWorkflowInstanceId, vWorkflowCode, vBizObjectId;

    IF NOT done THEN
      SET vSchemaCode = (select h.schemaCode from h_workflow_header h where h.workflowCode = vWorkflowCode);
      /*select vSchemaCode;*/

      IF vSchemaCode <> '' THEN
        SET vTableName = concat('i_', vSchemaCode);
        /*select vTableName;*/

        SET @tSQL = concat('select count(1) into @vTableCount from information_schema.tables where table_name = \'', vTableName, '\'');

        PREPARE tStmt FROM @tSQL;
        EXECUTE tStmt;
        DEALLOCATE PREPARE tStmt; /*释放资源*/

        /*select @vTableCount;*/
        /*判断表是否存在*/
        IF @vTableCount > 0 THEN

          SET @sql = concat('select count(*) into @vDataCount from ', vTableName, ' where id = \'', vBizObjectId, '\'');

          PREPARE stmt FROM @sql;
          EXECUTE stmt;
          DEALLOCATE PREPARE stmt;

          /*select @vDataCount;*/
          /*判断i表是否有数据*/
          IF @vDataCount = 0 THEN
             /*set vWorkflowInstanceId = 'aaaaa';*/
             /*select @vDataCount, vWorkflowInstanceId, vWorkflowCode, vBizObjectId, vSchemaCode;*/

             SET @sql1 = concat('delete from biz_workflow_instance where id = \'', vWorkflowInstanceId, '\'');
             SET @sql2 = concat('delete from biz_workflow_token where instanceId = \'', vWorkflowInstanceId, '\'');
             SET @sql3 = concat('delete from biz_workitem where instanceId = \'', vWorkflowInstanceId, '\'');
             SET @sql4 = concat('delete from biz_workitem_finished where instanceId = \'', vWorkflowInstanceId, '\'');
             SET @sql5 = concat('delete from biz_circulateitem where instanceId = \'', vWorkflowInstanceId, '\'');
             SET @sql6 = concat('delete from biz_circulateitem_finished where instanceId = \'', vWorkflowInstanceId, '\'');

             PREPARE stmtDel1 FROM @sql1;
             PREPARE stmtDel2 FROM @sql2;
             PREPARE stmtDel3 FROM @sql3;
             PREPARE stmtDel4 FROM @sql4;
             PREPARE stmtDel5 FROM @sql5;
             PREPARE stmtDel6 FROM @sql6;

             EXECUTE stmtDel1;
             EXECUTE stmtDel2;
             EXECUTE stmtDel3;
             EXECUTE stmtDel4;
             EXECUTE stmtDel5;
             EXECUTE stmtDel6;

             DEALLOCATE PREPARE stmtDel1;
             DEALLOCATE PREPARE stmtDel2;
             DEALLOCATE PREPARE stmtDel3;
             DEALLOCATE PREPARE stmtDel4;
             DEALLOCATE PREPARE stmtDel5;
             DEALLOCATE PREPARE stmtDel6;

          END IF;

        END IF;

      END IF;

    END IF;
  UNTIL done END REPEAT;

  CLOSE taskCursor;
END;

/*调用存储过程*/
CALL deleteBOAndWorkflow();

