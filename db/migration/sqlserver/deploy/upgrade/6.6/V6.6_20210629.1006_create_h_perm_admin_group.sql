create table h_perm_admin_group
(
    id           nvarchar(120) not null
        primary key,
    createdTime  datetime,
    creater      nvarchar(120),
    deleted      bit,
    modifiedTime datetime,
    modifier     nvarchar(120),
    remarks      nvarchar(200),
    appCode      nvarchar(40),
    departmentsJson  ntext,
    name         nvarchar(50),
    appPackagesJson        ntext,
    adminId   nvarchar(120)
)
go