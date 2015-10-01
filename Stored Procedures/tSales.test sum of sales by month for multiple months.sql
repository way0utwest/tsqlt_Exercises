SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
CREATE  PROCEDURE [tSales].[test sum of sales by month for multiple months]
AS
BEGIN
-- Assemble
CREATE TABLE #Expected (
  yearnum int
, monthnum TINYINT
, salestotal money
)

SELECT *
 INTO #actual
 FROM #Expected AS e
 WHERE 1 = 0

INSERT INTO #Expected
    ( yearnum
    , monthnum
    , salestotal
    )
  VALUES
    ( 2012, 11,  2500.23 )
,   ( 2012, 12,  2200.15 )
,   ( 2013, 1,  2656.75 )


EXEC tsqlt.FakeTable @TableName = N'MonthlySales', @SchemaName='dbo';

INSERT dbo.MonthlySales
  VALUES
    ( 11, 1000.00)
,   ( 11, 1500.23)
,   ( 12, 2200.15)
,   ( 13, 1000.00)
,   ( 13, 1656.00)
,   ( 13, 0000.75);


-- Act
INSERT #actual
SELECT 
 
 yearnum = DATEPART( YEAR, DATEADD( MONTH, datenum, '20111201'))
 , MONTHNUM = DATEPART(MONTH, DATEADD( MONTH, DATENUM, '20111201'))
 , SALESTOTAL = SUM(ms.salesamount)
  FROM dbo.MonthlySales AS ms
 GROUP BY 
 DATEPART( YEAR, DATEADD( MONTH, datenum, '20111201'))
 , DATEPART(MONTH, DATEADD( MONTH, DATENUM, '20111201'))
ORDER BY 
  DATEPART( YEAR, DATEADD( MONTH, datenum, '20111201'))
 , DATEPART(MONTH, DATEADD( MONTH, DATENUM, '20111201'))


-- Assert
  EXEC tsqlt.AssertEqualsTable
    @Expected = N'#EXPECTED', 
    @Actual = N'#actual', 
    @FailMsg = N'The calculations are incorrect';
  
END



GO
