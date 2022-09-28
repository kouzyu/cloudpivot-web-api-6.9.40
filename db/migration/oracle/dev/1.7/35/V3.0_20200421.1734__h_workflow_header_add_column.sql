ALTER TABLE h_workflow_header ADD (externalLinkEnable number(1, 0)  DEFAULT '0' NOT NULL);
comment on column h_workflow_header.externalLinkEnable is '是否开启外链';

ALTER TABLE h_workflow_header ADD (shortCode varchar2(50)  DEFAULT NULL);
comment on column h_workflow_header.shortCode is '外链短码';