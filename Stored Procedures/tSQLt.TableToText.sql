SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [tSQLt].[TableToText]
    @txt NVARCHAR(MAX) OUTPUT,
    @TableName NVARCHAR(MAX),
    @OrderBy NVARCHAR(MAX) = NULL
AS
BEGIN
    SET @txt = tSQLtPrivate::TableToString(@TableName,@OrderBy);
END;
GO
