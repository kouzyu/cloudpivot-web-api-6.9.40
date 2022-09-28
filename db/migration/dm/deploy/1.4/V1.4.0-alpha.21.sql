CREATE TABLE h_report_page
(
    id           varchar2(120) NOT NULL PRIMARY KEY,
    creater      varchar2(120),
    createdTime  date,
    deleted      number(1, 0),
    modifier     varchar2(120),
    modifiedTime date,
    remarks      varchar2(200),
    code         varchar2(40),
    icon         varchar2(50),
    pcAble       number(1, 0),
    name         varchar2(50),
    mobileAble   number(1, 0),
    appCode      varchar2(40),
    name_i18n    varchar2(1000)
);

-- 数据规则触发记录表
ALTER TABLE h_biz_rule_trigger
    ADD ( triggerMainObjectId varchar2(100));
ALTER TABLE h_biz_rule_trigger
    ADD ( triggerMainObjectName varchar2(200));
ALTER TABLE h_biz_rule_trigger
    ADD ( triggerTableType varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceAppCode varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceAppName varchar2(50));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceSchemaCode varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( sourceSchemaName varchar2(50));
ALTER TABLE h_biz_rule_trigger
    ADD ( targetSchemaName varchar2(50));
ALTER TABLE h_biz_rule_trigger
    ADD ( targetTableCode varchar2(40));
ALTER TABLE h_biz_rule_trigger
    ADD ( success number(1, 0));
ALTER TABLE h_biz_rule_trigger
    ADD ( failLog CLOB);
ALTER TABLE h_biz_rule_trigger
    ADD ( effect number(1, 0));

-- 数据规则影响数据表
ALTER TABLE h_biz_rule_effect
    ADD ( targetTableType varchar2(40));
ALTER TABLE h_biz_rule_effect
    ADD ( targetTableCode varchar2(40));
ALTER TABLE h_biz_rule_effect
    ADD ( targetMainObjectId varchar2(100));
ALTER TABLE h_biz_rule_effect
    ADD ( targetMainObjectName varchar2(200));
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertyLastValue CLOB);
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertySetValue CLOB);
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertyName varchar2(50));
ALTER TABLE h_biz_rule_effect
    ADD ( targetPropertyType varchar2(40));


ALTER TABLE h_report_page
    ADD ( reportObjectId varchar2(40));