CREATE TABLE h_log_synchro (
  id varchar2(42) primary key,
  trackId varchar2(60) NOT NULL,
  creater varchar2(42) NULL,
  createdTime date,
  startTime date,
  endTime date,
  fixer varchar2(42)  NULL,
  fixedTime date,
  fixedCount INTEGER NOT NULL,
  fixNotes varchar2(1000) NOT NULL,
  fixedStatus varchar2(40)  NULL ,
  executeStatus varchar2(40)  NULL
);
