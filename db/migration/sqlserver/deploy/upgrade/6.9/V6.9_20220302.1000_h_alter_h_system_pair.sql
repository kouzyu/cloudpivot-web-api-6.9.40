ALTER TABLE h_system_pair add objectId nvarchar(120);
GO

ALTER TABLE h_system_pair add schemaCode nvarchar(40);
GO

ALTER TABLE h_system_pair add formCode nvarchar(40);
GO

ALTER TABLE h_system_pair add workflowInstanceId nvarchar(120);
GO

create index idx_bid_fcode on h_system_pair (objectId, formCode)
go