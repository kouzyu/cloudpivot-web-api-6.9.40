alter table H_APP_PACKAGE
    add groupId varchar(120) ;

comment on column H_APP_PACKAGE.groupId is '应用分组id' ;