SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [tSQLt].[Private_RenameObjectToUniqueName]
    @SchemaName NVARCHAR(MAX),
    @ObjectName NVARCHAR(MAX),
    @NewName NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
   DECLARE @FullName NVARCHAR(MAX);

   SET @FullName = @SchemaName + '.' + @ObjectName;

   SET @NewName=@ObjectName;  
   WHILE OBJECT_ID(@SchemaName+'.'+@NewName) IS NOT NULL  
       SELECT @NewName=left(left(@ObjectName,150)+REPLACE(CAST(NEWID() AS NVARCHAR(200)),'-',''),256)  

   DECLARE @RenameCmd NVARCHAR(MAX);
   SET @RenameCmd = 'EXEC sp_rename ''' + @FullName + ''', ''' + @NewName + ''';';
   EXEC tSQLt.SuppressOutput @RenameCmd;
END;
GO
