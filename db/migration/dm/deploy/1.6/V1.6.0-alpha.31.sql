

ALTER TABLE h_biz_property ADD (relativePropertyCode VARCHAR2(80) DEFAULT null);
comment on column h_biz_property.relativePropertyCode is '关联表单显示字段';

create index idx_h_biz_attachment_boi on h_biz_attachment (bizObjectId);
alter table H_BIZ_ATTACHMENT modify PARENTBIZOBJECTID default '';
create index idx_h_biz_attachment_pboi on h_biz_attachment (parentBizObjectId);

-- create index idx_h_org_role_code on h_org_role (code);

-- 這里有问题
alter table H_IM_WORK_RECORD_HISTORY modify CONTENT VARCHAR2(3000);

ALTER TABLE h_im_work_record MODIFY content varchar2(3000) default '';

ALTER TABLE h_form_comment ADD  (text varchar2(4000));
comment on column h_form_comment.text is '评论内容html格式';

CREATE TABLE h_form_comment (
    id varchar2(42)  NOT NULL,
    content varchar2(3000) DEFAULT NULL ,
    commentator varchar2(42)  NOT NULL ,
    commentatorName varchar2(80) NOT NULL ,
    departmentId varchar2(42)  DEFAULT NULL ,
    schemaCode varchar2(42)  NOT NULL ,
    bizObjectId varchar2(42)  NOT NULL,
    replyCommentId varchar2(42)  DEFAULT NULL ,
    replyUserId varchar2(42)  DEFAULT NULL ,
    replyUserName varchar2(80) DEFAULT NULL ,
    originCommentId varchar2(42)  DEFAULT NULL ,
    floor int(11) DEFAULT 0  NOT NULL ,
    state varchar2(20)  DEFAULT 'ENABLED' NOT NULL  ,
    deleted number(1, 0)  DEFAULT 0 NOT NULL,
    attachmentNum int(11) DEFAULT 0 NOT NULL,
    modifier varchar2(42)  DEFAULT NULL ,
    createdTime date NOT NULL,
    modifiedTime date DEFAULT NULL,
    PRIMARY KEY (id)
    );

CREATE TABLE h_from_comment_attachment (
    id varchar2(42)  NOT NULL,
    bizObjectId varchar2(42)  NOT NULL ,
    schemaCode varchar2(42)  NOT NULL ,
    commentId varchar2(42)  NOT NULL ,
    fileExtension varchar2(30)  DEFAULT NULL ,
    fileSize int(11) DEFAULT 0 NOT NULL ,
    mimeType varchar2(50)  NOT NULL ,
    name varchar2(255)  NOT NULL ,
    refId varchar2(80)  NOT NULL ,
    createdTime date NOT NULL ,
    creater varchar2(42)  NOT NULL ,
    PRIMARY KEY (id)
    );
