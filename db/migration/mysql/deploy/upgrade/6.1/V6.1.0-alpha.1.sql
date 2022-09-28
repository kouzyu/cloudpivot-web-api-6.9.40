DELIMITER $$
CREATE FUNCTION `fristPinyin`(P_NAME VARCHAR(255)) RETURNS varchar(255) CHARSET utf8
DETERMINISTIC
BEGIN
    DECLARE V_RETURN VARCHAR(255);
    DECLARE V_BOOL INT DEFAULT 0;
          DECLARE FIRST_VARCHAR VARCHAR(1);

    SET FIRST_VARCHAR = left(CONVERT(P_NAME USING gbk),1);
    SELECT FIRST_VARCHAR REGEXP '[a-zA-Z]' INTO V_BOOL;
    IF V_BOOL = 1 THEN
      SET V_RETURN = FIRST_VARCHAR;
    ELSE
      SET V_RETURN = ELT(INTERVAL(CONV(HEX(left(CONVERT(P_NAME USING gbk),1)),16,10),
          0xB0A1,0xB0C5,0xB2C1,0xB4EE,0xB6EA,0xB7A2,0xB8C1,0xB9FE,0xBBF7,
          0xBFA6,0xC0AC,0xC2E8,0xC4C3,0xC5B6,0xC5BE,0xC6DA,0xC8BB,
          0xC8F6,0xCBFA,0xCDDA,0xCEF4,0xD1B9,0xD4D1),
      'a','b','c','d','e','f','g','h','j','k','l','m','n','o','p','q','r','s','t','w','x','y','z');
    END IF;
    RETURN V_RETURN;
END$$
DELIMITER;


drop table if exists h_biz_datasource_category;

/*==============================================================*/
/* Table: h_biz_datasource_category                             */
/*==============================================================*/
create table h_biz_datasource_category
(
   id                   varchar(128) not null comment '主键',
   createdTime          datetime default CURRENT_TIMESTAMP comment '创建时间',
   modifiedTime         datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   name                 varchar(128) not null default '‘’' comment '目录名称',
   primary key (id)
)ENGINE = InnoDB COLLATE = utf8_general_ci;

alter table h_biz_datasource_category comment '第三方数据源目录';


drop table if exists h_biz_datasource_method;

/*==============================================================*/
/* Table: h_biz_datasource_method                               */
/*==============================================================*/
create table h_biz_datasource_method
(
   id                   varchar(128) not null comment '主键',
   createdTime          datetime default CURRENT_TIMESTAMP comment '创建时间',
   creater              varchar(128) comment '链接名称创建者',
   modifier             varchar(128) comment '修改者',
   modifiedTime         datetime default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '修改时间',
   deleted              bit comment '删除标志',
   remarks              varchar(256) comment '备注',
   code                 varchar(32) not null default '' comment '编码',
   name                 varchar(256) not null default '' comment '名称',
   sqlConfig            varchar(512) not null default '' comment 'sql执行语句',
   datasourceCategoryId varchar(128) not null default '' comment '集成目录ID',
   dataBaseConnectId    varchar(128) not null default '' comment '数据源Id',
   reportObjectId       varchar(32) not null default '' comment '自定义SQL高级数据源的唯一标志',
   reportTableName      varchar(32) not null default '' comment '报表数据源表别名',
   primary key (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

alter table h_biz_datasource_method comment '第三方数据源方法';

/*==============================================================*/
/* Index: uk_code                                               */
/*==============================================================*/
create unique index uk_code on h_biz_datasource_method
(
   code
);


/*==============================================================*/
/* Table: create firstPinyin function                              */
/*==============================================================*/
drop function if exists `fristPinyin`;

CREATE FUNCTION `fristPinyin`(P_NAME VARCHAR(255)) RETURNS varchar(255) CHARSET utf8
DETERMINISTIC
BEGIN
    DECLARE V_RETURN VARCHAR(255);
    DECLARE V_BOOL INT DEFAULT 0;
          DECLARE FIRST_VARCHAR VARCHAR(1);

    SET FIRST_VARCHAR = left(CONVERT(P_NAME USING gbk),1);
    SELECT FIRST_VARCHAR REGEXP '[a-zA-Z]' INTO V_BOOL;
    IF V_BOOL = 1 THEN
      SET V_RETURN = FIRST_VARCHAR;
    ELSE
      SET V_RETURN = ELT(INTERVAL(CONV(HEX(left(CONVERT(P_NAME USING gbk),1)),16,10),
          0xB0A1,0xB0C5,0xB2C1,0xB4EE,0xB6EA,0xB7A2,0xB8C1,0xB9FE,0xBBF7,
          0xBFA6,0xC0AC,0xC2E8,0xC4C3,0xC5B6,0xC5BE,0xC6DA,0xC8BB,
          0xC8F6,0xCBFA,0xCDDA,0xCEF4,0xD1B9,0xD4D1),
       'a','b','c','d','e','f','g','h','j','k','l','m','n','o','p','q','r','s','t','w','x','y','z');
    END IF;
    RETURN V_RETURN;
END ;
