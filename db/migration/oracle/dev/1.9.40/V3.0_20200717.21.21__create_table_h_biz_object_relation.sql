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
  sortBy            bigint(20) NULL
);
