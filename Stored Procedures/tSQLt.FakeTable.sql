SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [tSQLt].[FakeTable]
    @SchemaName NVARCHAR(MAX),
    @TableName NVARCHAR(MAX)
AS
BEGIN

   DECLARE @OrigSchemaName NVARCHAR(MAX);
   DECLARE @NewName NVARCHAR(4000);
   DECLARE @Cmd NVARCHAR(MAX);
   
   SET @OrigSchemaName = @SchemaName;   
   SET @SchemaName = tSQLt.Private_GetCleanSchemaName(@SchemaName, @TableName);
   
   IF @SchemaName IS NULL
   BEGIN
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = 
            '''' + COALESCE(@OrigSchemaName, 'NULL') + '.' + COALESCE(@TableName, 'NULL') + 
            ''' does not exist.';
        RAISERROR (@ErrorMessage, 16, 10);
   END;

   EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName, @TableName, @NewName OUTPUT

   SELECT @Cmd = 'DECLARE @N TABLE(n INT IDENTITY(1,1));
      SELECT Src.*
        INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + '
        FROM ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@NewName) + ' Src
       RIGHT JOIN @N AS n
          ON n.n<>n.n
       WHERE n.n<>n.n
   ';
   EXEC (@Cmd);

   EXEC sys.sp_addextendedproperty 
      @name = N'tSQLt.FakeTable_OrgTableName', 
      @value = @NewName, 
      @level0type = N'SCHEMA', @level0name = @SchemaName, 
      @level1type = N'TABLE',  @level1name = @TableName;
END
GO
