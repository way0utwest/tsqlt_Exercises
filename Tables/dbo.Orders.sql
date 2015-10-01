CREATE TABLE [dbo].[Orders]
(
[OrderId] [int] NOT NULL,
[CustomerId] [int] NULL,
[Amount] [decimal] (10, 2) NULL,
[WeightInGrams] [int] NULL,
[ShippingLocationId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [PK__Orders__C3905BCF54824B80] PRIMARY KEY CLUSTERED  ([OrderId]) ON [PRIMARY]
GO
