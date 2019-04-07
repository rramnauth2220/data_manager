USE [LexisExtract]
GO

/****** Object:  Table [dbo].[Manager_Users]    Script Date: 4/7/2019 6:43:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Manager_Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[InitialLogin] [datetime] NOT NULL,
	[RecentLogin] [datetime] NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
	[NumLogins] [int] NOT NULL,
 CONSTRAINT [PK_Manager_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Manager_Users] ADD  CONSTRAINT [DF_Manager_Users_Role]  DEFAULT ('Guest') FOR [Role]
GO

ALTER TABLE [dbo].[Manager_Users] ADD  CONSTRAINT [DF_Manager_Users_NumLogins]  DEFAULT ((0)) FOR [NumLogins]
GO

