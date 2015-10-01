SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [DiscountTests].[test price at $200 yields 15% discount]
AS
BEGIN
  DECLARE @actual DECIMAL(10,2);
  
  SELECT @actual = dbo.ComputeDiscount(200);
  
  EXEC tSQLt.AssertEquals 170, @actual;
END;
GO
