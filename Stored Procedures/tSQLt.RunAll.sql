SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [tSQLt].[RunAll]
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @TestClassName NVARCHAR(MAX);
  DECLARE @TestProcName NVARCHAR(MAX);

  EXEC tSQLt.Private_CleanTestResult;

  DECLARE tests CURSOR LOCAL FAST_FORWARD FOR
   SELECT testClassName
     FROM tSQLt.Private_TestClasses;

  OPEN tests;
  
  FETCH NEXT FROM tests INTO @TestClassName;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    EXEC tSQLt.Private_RunTestClass @TestClassName;
    
    FETCH NEXT FROM tests INTO @TestClassName;
  END;
  
  CLOSE tests;
  DEALLOCATE tests;
  
  EXEC tSQLt.RunTestClassSummary;
END;
GO
