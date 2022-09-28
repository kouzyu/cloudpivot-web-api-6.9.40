CREATE TABLE h_biz_object_relation (
  id                varchar2(42) not null primary key,
  srcSc             varchar2(42) NULL,
  srcId             varchar2(42) NULL,
  srcParentSc       varchar2(42) NULL,
  srcParentId       varchar2(42) NULL,
  targetSc          varchar2(42) NULL,
  targetId          varchar2(42) NULL,
  targetParentSc    varchar2(42) NULL,
  targetParentId    varchar2(42) NULL,
  createTime        date NULL,
  sortBy            number(20) NULL
);

ALTER TABLE biz_workitem ADD (sortKey number(20) DEFAULT NULL);
ALTER TABLE biz_workitem_finished ADD (sortKey number(20) DEFAULT NULL);
ALTER TABLE biz_circulateitem ADD (sortKey number(20) DEFAULT NULL);
ALTER TABLE biz_circulateitem_finished ADD (sortKey number(20) DEFAULT NULL);

ALTER TABLE h_biz_property ADD (repeated number(1, 0) DEFAULT 0);
comment on column h_biz_property.repeated is '去重属性：1开启0不开启';

