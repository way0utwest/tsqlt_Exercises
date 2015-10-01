CREATE TABLE [dbo].[ShippingLocations]
(
[ShippingLocationId] [int] NOT NULL IDENTITY(0, -1),
[X] [decimal] (14, 12) NULL,
[Y] [decimal] (14, 12) NULL,
[Z] [decimal] (14, 12) NULL,
[VX] [decimal] (16, 12) NULL,
[VY] [decimal] (16, 12) NULL,
[VZ] [decimal] (16, 12) NULL,
[DTime] [datetime2] NULL CONSTRAINT [ShippingLocations_DTime_Dflt] DEFAULT (sysdatetime())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ShippingLocations] ADD CONSTRAINT [PK__Shipping__9423190BA8D45785] PRIMARY KEY CLUSTERED  ([ShippingLocationId]) ON [PRIMARY]
GO
