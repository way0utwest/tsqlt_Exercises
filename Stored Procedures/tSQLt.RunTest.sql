SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [tSQLt].[RunTest]
   @TestName NVARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @Msg NVARCHAR(MAX),
            @ResolvedTestName NVARCHAR(MAX);
    
    SELECT @ResolvedTestName = '['+OBJECT_SCHEMA_NAME(OBJECT_ID(@TestName))+'].['+OBJECT_NAME(OBJECT_ID(@TestName))+']';

    IF @ResolvedTestName IS NULL
    BEGIN
        RAISERROR ('The test case %s does not exist.', 16, 10, @TestName) WITH NOWAIT;
        RETURN -1;
    END

    EXEC tSQLt.Private_CleanTestResult;
    EXEC tSQLt.Private_RunTest @ResolvedTestName

    SELECT @Msg = Msg
      FROM tSQLt.TestCaseSummary();

    EXEC tSQLt.Private_Print @Msg;
END;
GO
