SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[AddMissingKeys]
AS
BEGIN
   ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_CustomerId FOREIGN KEY (CustomerId) REFERENCES dbo.Customers(CustomerId);
   ALTER TABLE dbo.Orders ADD CONSTRAINT FK_Orders_ShippingLocationId FOREIGN KEY (ShippingLocationId) REFERENCES dbo.ShippingLocations(ShippingLocationId);
   ALTER TABLE dbo.OrderItems ADD CONSTRAINT FK_OrderItems_OrderId FOREIGN KEY (OrderId) REFERENCES dbo.Orders(OrderId);
   ALTER TABLE dbo.OrderItems ADD CONSTRAINT FK_OrderItems_ItemId FOREIGN KEY (ItemId) REFERENCES dbo.Items(ItemId);
END;
GO
