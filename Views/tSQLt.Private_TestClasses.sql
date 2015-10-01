SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [tSQLt].[Private_TestClasses]
AS
  SELECT DISTINCT s.name AS testClassName, s.schema_id
    FROM sys.extended_properties ep
    JOIN sys.schemas s
      ON ep.major_id = s.schema_id
   WHERE ep.name = N'tSQLt.TestClass';
GO
