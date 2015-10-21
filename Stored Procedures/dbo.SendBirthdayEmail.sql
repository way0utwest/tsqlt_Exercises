
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[SendBirthdayEmail]
  @CustomerId INT
AS
BEGIN
  SET NOCOUNT ON 
  RAISERROR('Don''t you dare call me again! ;-)',16,10);
END;
GO
