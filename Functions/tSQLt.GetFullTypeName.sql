SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [tSQLt].[GetFullTypeName](@TypeId INT, @Length INT, @Precision INT, @Scale INT )
RETURNS TABLE
AS
RETURN SELECT typeName = TYPE_NAME(@TypeId) +
              CASE WHEN TYPE_NAME(@TypeId) = 'xml'
                    THEN ''
                   WHEN @Length = -1
                    THEN '(MAX)'
                   WHEN TYPE_NAME(@TypeId) LIKE 'n%char'
                    THEN '(' + CAST(@Length / 2 AS NVARCHAR) + ')'
                   WHEN TYPE_NAME(@TypeId) LIKE '%char' OR TYPE_NAME(@TypeId) LIKE '%binary'
                    THEN '(' + CAST(@Length AS NVARCHAR) + ')'
                   WHEN TYPE_NAME(@TypeId) IN ('decimal', 'numeric')
                    THEN '(' + CAST(@Precision AS NVARCHAR) + ',' + CAST(@Scale AS NVARCHAR) + ')'
                   ELSE ''
               END;

GO
