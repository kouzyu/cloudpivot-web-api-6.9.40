ALTER TABLE h_org_user ADD (pinYin VARCHAR(250) DEFAULT null);
comment on column h_org_user.pinYin is '姓名拼音';

ALTER TABLE h_org_user ADD (shortPinYin VARCHAR(250) DEFAULT null);
comment on column h_org_user.shortPinYin is '姓名简拼';
