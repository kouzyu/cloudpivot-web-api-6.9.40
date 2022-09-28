

/***********************************************更新部门表queryCode字段长度***********************************************/
ALTER TABLE h_org_department MODIFY queryCode varchar(512) default null;

/***********************************************更新部门权限表queryCode字段长度***********************************************/
ALTER TABLE h_perm_department_scope MODIFY queryCode varchar(512) default null;

/***********************************************更新数据项表propertyLength值***********************************************/
UPDATE h_biz_property SET propertyLength = 512 WHERE code = 'ownerDeptQueryCode';


/*************************************************更新部门表queryCode规则*************************************************/
DROP PROCEDURE IF EXISTS updateDepartQueryCode;

CREATE PROCEDURE updateDepartQueryCode(IN vParentId VARCHAR(50), IN vParentQueryCode VARCHAR(100))
BEGIN
  DECLARE done INT DEFAULT 0;

  DECLARE vDeptId VARCHAR(50) DEFAULT '';
  DECLARE vSourceId VARCHAR(50) DEFAULT '';

  DECLARE taskCursor CURSOR FOR SELECT id, sourceId FROM h_org_department t WHERE t.parentId = vParentId;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  SET @@max_sp_recursion_depth = 300; /*设置递归最大深度*/

  OPEN taskCursor;

  REPEAT
    FETCH taskCursor INTO vDeptId, vSourceId;

    IF NOT done THEN

      /*SELECT vParentQueryCode;*/

      SET @vFullQueryCode = concat(vParentQueryCode, '#', vSourceId);

      /*SELECT @vFullQueryCode;*/

      /*更新queryCode，规则 parentQueryCode+'#'+sourceId */
      SET @sql1 = concat('update h_org_department d set d.queryCode = \'', @vFullQueryCode, '\' where d.id = \'', vDeptId, '\'');

      /*SELECT @sql1;*/

      PREPARE stmt1 FROM @sql1;
      EXECUTE stmt1;

      /*SELECT @vFullQueryCode;*/

      CALL updateDepartQueryCode(vDeptId, @vFullQueryCode);

    /*ELSE
      SELECT 'no child.';*/

    END IF;
  UNTIL done END REPEAT;
  CLOSE taskCursor;
END;


/*************************************************调用更新部门权限表 存储过程*************************************************/
DROP PROCEDURE IF EXISTS updateDepartInit;
CREATE PROCEDURE updateDepartInit()
BEGIN

  /*备份部门表*/
  /*create table if not exists h_org_department_bak select * from h_org_department t;*/

  /*跟新跟部门的queryCode = 1*/
  update h_org_department set queryCode = '1' where sourceId = '1';
  select id into @id from h_org_department  where sourceId = '1';

  /*select @id;*/

  CALL updateDepartQueryCode(@id, '1');

END;
call updateDepartInit();


/*************************************************更新部门权限表queryCode规则*************************************************/
update h_perm_department_scope s set s.queryCode = (select d.queryCode from h_org_department d where d.id = s.unitId and s.unitType = 'DEPARTMENT');
/*commit;*/


/***************************************更新i表的queryCode***************************************************/
DROP PROCEDURE IF EXISTS updateITableQueryCode;

CREATE PROCEDURE updateITableQueryCode()
BEGIN
  DECLARE vTableName VARCHAR(50) DEFAULT '';
  DECLARE done INT DEFAULT 0;
  DECLARE vQueryCodeCount INT DEFAULT 0;

  DECLARE taskCursor CURSOR FOR SELECT table_name FROM information_schema.tables WHERE table_name like 'i_%' AND table_rows > 0;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  OPEN taskCursor;

  REPEAT
    FETCH taskCursor INTO vTableName;
    IF NOT done THEN

      SET vQueryCodeCount = (SELECT count(*) FROM information_schema.columns WHERE table_name = vTableName AND column_name = 'ownerDeptQueryCode');
      IF vQueryCodeCount > 0 THEN

        /*SELECT vTableName;*/

        SET @alterSQL = concat('ALTER TABLE ', vTableName, ' MODIFY ownerDeptQueryCode varchar(512) default null');
        PREPARE stmt1 FROM @alterSQL;
        EXECUTE stmt1;

        SET @sql = concat('update ', vTableName, ' t set t.ownerDeptQueryCode = (select d.queryCode from h_org_department d where d.id = t.ownerDeptId)');

        /*SELECT @sql;*/

        PREPARE stmt FROM @sql;
        EXECUTE stmt;

      END IF;

    END IF;
  UNTIL done END REPEAT;
  CLOSE taskCursor;
END;

CALL updateITableQueryCode();

