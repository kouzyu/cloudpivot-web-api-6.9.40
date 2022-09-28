CREATE FUNCTION dbo.RegexMatch
(
  @source NVARCHAR(max),  --需要匹配的源字符串
  @pattern NVARCHAR(max)   --正则表达式
)
RETURNS BIT  --返回结果false，true
AS
BEGIN

  --0（成功）或非零数字（失败），是由OLE 自动化对象返回的HRESULT 的整数值。
  DECLARE @hr  INT

  --用于保存返回的对象令牌，以便之后对该对象进行操作
  DECLARE @regExp INT

  --保存结果
  DECLARE @result BIT

  --创建OLE 对象实例
  EXEC @hr = sp_OACreate 'VBScript.RegExp', @regExp OUTPUT
  IF @hr <> 0 BEGIN
   SET @result = 0
   RETURN @result
  END

  --设置模式
  EXEC @hr = sp_OASetProperty @regExp, 'Pattern', @pattern
  IF @hr <> 0 BEGIN
   SET @result = 0
   RETURN @result
  END
  --设置全局可用性
  EXEC @hr = sp_OASetProperty @regExp, 'Global', false
  IF @hr <> 0 BEGIN
   SET @result = 0
   RETURN @result
  END
  --设置忽略大小写 默认区分大小写
  EXEC @hr = sp_OASetProperty @regExp, 'IgnoreCase', 0
  IF @hr <> 0 BEGIN
   SET @result = 0
   RETURN @result
  END
  --调用对象方法
  EXEC @hr = sp_OAMethod @regExp, 'Test', @result OUTPUT, @source
  IF @hr <> 0 BEGIN
   SET @result = 0
   RETURN @result
  END
  --释放OLE 对象
  EXEC @hr = sp_OADestroy @regExp
  IF @hr <> 0 BEGIN
   SET @result = 0
   RETURN @result
  END
RETURN @result
END

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