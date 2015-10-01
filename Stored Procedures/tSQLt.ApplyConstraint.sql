SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/

CREATE PROCEDURE [tSQLt].[ApplyConstraint]
       @SchemaName NVARCHAR(MAX),
       @TableName NVARCHAR(MAX),
       @ConstraintName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @OrgTableName NVARCHAR(MAX);
  DECLARE @Cmd NVARCHAR(MAX);

  SELECT @OrgTableName = CAST(value AS NVARCHAR(4000))
    FROM sys.extended_properties
   WHERE class_desc = 'OBJECT_OR_COLUMN'
     AND major_id = OBJECT_ID(@SchemaName + '.' + @TableName)
     AND minor_id = 0
     AND name = 'tSQLt.FakeTable_OrgTableName';

  SELECT @Cmd = 'CONSTRAINT ' + name + ' CHECK' + definition 
    FROM sys.check_constraints
   WHERE object_id = OBJECT_ID(@SchemaName + '.' + @ConstraintName)
     AND parent_object_id = OBJECT_ID(@SchemaName + '.' + @OrgTableName);

  IF @Cmd IS NOT NULL
  BEGIN
     EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName, @ConstraintName;
     SELECT @Cmd = 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD ' + @Cmd;

     EXEC (@Cmd);
  END
  ELSE
  BEGIN
     DECLARE @CreateIndexCmd NVARCHAR(MAX);
     SELECT @Cmd = cmd ,@CreateIndexCmd = CreIdxCmd
       FROM tSQLt.Private_GetForeignKeyDefinition(@SchemaName, @OrgTableName, @ConstraintName);

     IF @Cmd IS NOT NULL
     BEGIN
        EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName, @ConstraintName;
        SELECT @Cmd = @CreateIndexCmd + 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD ' + @Cmd;

        EXEC (@Cmd);
     END
     ELSE
     BEGIN
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = '''' + @SchemaName + '.' + @ConstraintName + 
            ''' is not a valid constraint on table ''' + @SchemaName + '.' + @TableName + 
            ''' for the tSQLt.ApplyConstraint procedure';
        RAISERROR (@ErrorMessage, 16, 10);
     END;
  END;

  RETURN 0;
END;
GO
