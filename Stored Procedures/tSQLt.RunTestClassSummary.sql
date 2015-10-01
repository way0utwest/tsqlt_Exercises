SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [tSQLt].[RunTestClassSummary]
AS
BEGIN
    DECLARE @Formatter NVARCHAR(MAX);
    SELECT @Formatter = tSQLt.GetTestResultFormatter();
    EXEC (@Formatter);
END
GO
