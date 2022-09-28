CREATE TABLE h_org_synchronize_log (
  id varchar2(120)  NOT NULL   primary key,
  targetType varchar2(30)  DEFAULT NULL,
  trackId varchar2(60)  DEFAULT NULL,
  targetId varchar2(120)  DEFAULT NULL,
  errorType varchar2(1000)  DEFAULT NULL
);