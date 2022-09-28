create table h_form_comment
(
    id              varchar(42)                    not null
        primary key,
    content         varchar2(3000)                 null,
    commentator     varchar2(42)                   not null,
    commentatorName varchar2(80)                   not null,
    departmentId    varchar2(42)                   null,
    schemaCode      varchar2(42)                   not null,
    bizObjectId     varchar2(42)                   not null,
    replyCommentId  varchar2(42)                   null,
    replyUserId     varchar2(42)                   null,
    replyUserName   varchar2(80)                   null,
    originCommentId varchar2(42)                   null,
    floor           int          default 0         not null,
    state           varchar2(20) default 'ENABLED' not null,
    deleted         number(1, 0) default 0         not null,
    attachmentNum   int          default 0         not null,
    modifier        varchar2(42)                   null,
    createdTime     date         default sysdate   not null,
    modifiedTime    date                           null,
    text            varchar2(4000)                 null
);

create index IDX_FORM_OBJ_ID on h_form_comment (bizObjectId);

ALTER TABLE h_biz_property ADD (relativePropertyCode VARCHAR2(80) DEFAULT null);
comment on column h_biz_property.relativePropertyCode is '关联表单显示字段';

create index idx_h_biz_attachment_boi on h_biz_attachment (bizObjectId);
alter table H_BIZ_ATTACHMENT modify PARENTBIZOBJECTID default '';
create index idx_h_biz_attachment_pboi on h_biz_attachment (parentBizObjectId);

-- create index idx_h_org_role_code on h_org_role (code);

-- 這里有问题
alter table H_IM_WORK_RECORD_HISTORY modify CONTENT VARCHAR2(3000);

-- ALTER TABLE h_im_work_record MODIFY content varchar2(3000) default '';

-- ALTER TABLE h_form_comment ADD  (text varchar2(4000));
-- comment on column h_form_comment.text is '评论内容html格式';

create table h_from_comment_attachment
(
    id            varchar2(42)               not null
        primary key,
    bizObjectId   varchar2(42)               not null,
    schemaCode    varchar2(42)               not null,
    commentId     varchar2(42)               not null,
    fileExtension varchar2(30)               null,
    fileSize      int       default 0       not null,
    mimeType      varchar2(50)               not null,
    name          varchar2(255)              not null,
    refId         varchar2(80)               not null,
    createdTime   date default sysdate not null,
    creater       varchar2(42)               not null
);

create index IDX_F_C_A_COMM_ID on h_from_comment_attachment (commentId);
create index IDX_F_C_A_REF_ID on h_from_comment_attachment (refId);