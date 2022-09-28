CREATE TABLE h_access_token (
  id varchar2(40)  NOT NULL PRIMARY KEY,
  userId varchar2(40)  DEFAULT NULL,
  leastUse int DEFAULT NULL,
  accessToken varchar2(2000)  DEFAULT NULL,
  createTime date DEFAULT NULL
);

create index idx_access_token_userId on h_access_token (userId);