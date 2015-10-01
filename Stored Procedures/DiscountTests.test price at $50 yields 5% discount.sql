SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [DiscountTests].[test price at $50 yields 5% discount]
AS
BEGIN
  DECLARE @actual DECIMAL(10,2);
  
  SELECT @actual = dbo.ComputeDiscount(50);
  
  EXEC tSQLt.AssertEquals 47.5, @actual;
END;
GO
