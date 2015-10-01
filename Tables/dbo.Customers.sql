CREATE TABLE [dbo].[Customers]
(
[CustomerId] [int] NOT NULL,
[FirstName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthDate] [date] NULL,
[AccountCreatedDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK__Customer__A4AE64D8377F5362] PRIMARY KEY CLUSTERED  ([CustomerId]) ON [PRIMARY]
GO
