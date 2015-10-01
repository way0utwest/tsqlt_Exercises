SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [tSQLt].[NewTestClass]
    @ClassName NVARCHAR(MAX)
AS
BEGIN
    EXEC tSQLt.DropClass @ClassName = @ClassName;
    EXEC ('CREATE SCHEMA ' + @ClassName);
    
    EXEC sp_addextendedproperty @name = N'tSQLt.TestClass', 
                                @value = 1,
                                @level0type = 'SCHEMA',
                                @level0name = @ClassName;
END;
GO
