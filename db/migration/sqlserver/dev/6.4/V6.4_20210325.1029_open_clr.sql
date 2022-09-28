--开启SQL Server高级选项和CLR
exec sp_configure 'show advanced options', '1';
RECONFIGURE
go
exec sp_configure 'clr enabled', '1'
RECONFIGURE
go
exec sp_configure 'show advanced options', '1';
RECONFIGURE
go  