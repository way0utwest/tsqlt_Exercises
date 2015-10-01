SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [DiscountTests].[test price at $100 yields 5% discount]
AS
BEGIN
  DECLARE @actual DECIMAL(10,2);
  
  SELECT @actual = dbo.ComputeDiscount(100);
  
  EXEC tSQLt.AssertEquals 95, @actual;
END;
GO
