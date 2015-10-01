CREATE TABLE [dbo].[OrderItems]
(
[OrderItemId] [int] NOT NULL,
[OrderId] [int] NULL,
[ItemId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderItems] ADD CONSTRAINT [PK__OrderIte__57ED0681B1751E32] PRIMARY KEY CLUSTERED  ([OrderItemId]) ON [PRIMARY]
GO
