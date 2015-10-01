CREATE TABLE [dbo].[Items]
(
[ItemId] [int] NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WeightInGrams] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items] ADD CONSTRAINT [PK__Items__727E838BB1E1046A] PRIMARY KEY CLUSTERED  ([ItemId]) ON [PRIMARY]
GO
